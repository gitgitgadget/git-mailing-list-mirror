From: Andreas Amann <a.amann@ucc.ie>
Subject: problem with modification time of packfiles
Date: Sun, 18 Oct 2015 22:37:55 +0100
Message-ID: <87io63503w.fsf@msstf091.ucc.ie>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 19 00:00:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Znvzs-0001Kz-LE
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 00:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbbJRVwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 17:52:24 -0400
Received: from mail-am1on0097.outbound.protection.outlook.com ([157.56.112.97]:59056
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751268AbbJRVwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 17:52:23 -0400
X-Greylist: delayed 861 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Oct 2015 17:52:22 EDT
Received: from DB4PR02CA0019.eurprd02.prod.outlook.com (10.242.174.147) by
 VI1PR02MB0688.eurprd02.prod.outlook.com (10.162.10.15) with Microsoft SMTP
 Server (TLS) id 15.1.300.14; Sun, 18 Oct 2015 21:37:58 +0000
Received: from DB3FFO11FD026.protection.gbl (2a01:111:f400:7e04::183) by
 DB4PR02CA0019.outlook.office365.com (2a01:111:e400:983b::19) with Microsoft
 SMTP Server (TLS) id 15.1.300.14 via Frontend Transport; Sun, 18 Oct 2015
 21:37:57 +0000
Authentication-Results: spf=pass (sender IP is 143.239.1.24)
 smtp.mailfrom=ucc.ie; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=permerror action=none
 header.from=ucc.ie;
Received-SPF: Pass (protection.outlook.com: domain of ucc.ie designates
 143.239.1.24 as permitted sender) receiver=protection.outlook.com;
 client-ip=143.239.1.24; helo=mail4.ucc.ie;
Received: from mail4.ucc.ie (143.239.1.24) by
 DB3FFO11FD026.mail.protection.outlook.com (10.47.217.57) with Microsoft SMTP
 Server (TLS) id 15.1.300.4 via Frontend Transport; Sun, 18 Oct 2015 21:37:57
 +0000
Received: from msstf091.ucc.ie (msstf091.ucc.ie [143.239.76.91])
	by mail4.ucc.ie (8.14.4/8.14.4) with ESMTP id t9ILbuTd020789
	for <git@vger.kernel.org>; Sun, 18 Oct 2015 22:37:56 +0100
Received: by msstf091.ucc.ie (Postfix, from userid 1000)
	id C604EA406C; Sun, 18 Oct 2015 22:37:55 +0100 (IST)
User-Agent: Notmuch/0.20.2 (http://notmuchmail.org) Emacs/24.5.1 (x86_64-unknown-linux-gnu)
X-EOPAttributedMessage: 0
X-Microsoft-Exchange-Diagnostics: 1;DB3FFO11FD026;1:3fM8TrNW9MrYksnE7EvznpTK8OCqT95Bb9qr/+NBM/hZDO6wSQfyjKKRWXzBKlCNbcQhimiwF8eWfGakLyO2+3SlRAs0I/mK7kf8oWP9UkgxSFTVzuGGZsMLeclci0pyJ3bcd0czxIAa2GRy3D2Bfv3L56FjqDMUM5LVXY5j8/dAXk1OQk4mHv36jq8oWmdT8QwGygyODzcllZ/TSJRHIpve565718ENieOzi8IgZpidmIX7n4mBwhXxdoEdGT6MLocvcLbqiPkFNhMfALB2G7/UQMOgqERkKM1Ssuz2XGg5k2DcbgfFb66OKdMz4l7ebrjktOmJm6asi74uy5WY0j10GKkghtCFIMmVab1nveI=
X-Forefront-Antispam-Report: CIP:143.239.1.24;CTRY:IE;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(2980300002)(438002)(199003)(164054003)(189002)(48376002)(54356999)(45336002)(106466001)(16796002)(5001970100001)(5008740100001)(450100001)(5003940100001)(107886002)(110136002)(74482002)(42186005)(6806005)(40036005)(50986999)(11100500001)(46386002)(36756003)(4001350100001)(46102003)(86362001)(92566002)(189998001)(83506001)(87936001)(33646002)(103686003)(52956003)(5007970100001)(64706001)(50466002)(90966002)(229853001)(2351001)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR02MB0688;H:mail4.ucc.ie;FPR:;SPF:Pass;PTR:mail4.ucc.ie;A:0;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR02MB0688;2:vS/4ixBsSluMqys/xEDRIsgRx8bSAJesGTFpZOCo0Ul5qs2DWsgkzwA4cN5z4ZCZupGAFbX1laq3uWdh7FfS0b1BnOGuD4vvb6d8Z/qS7nV7bDulHszD/Xdq00ubkMFUP/hY/ipDn5LvYaXNRldxZHUW+tYB823qpe8RLElyqWo=;3:cZoAdSViKCSlPR94L/+L6S43QnwB2uHL+jXLf175CCI8qDZD3RAclM/gLb48tqMzsLZ17GvyyfXrfJjJKIAd0SEecp8o0ujbOI+p4tOCEUx2hWx0o1MtrUIoXFXKqfndWQqXsynTKQ12qYQ/nmzqdJjPMLSFltcqgxurHM+C94BbnfNOSUKduz97uFtb6IgQXiXKdrlKPRxeUI4QP/HQdSs7JzjUmGKSdSOWpf9LGp4=;25:MKaDAb4zy7tjJ4JhB1uatCFFsZbdEPAIm0ZgZaQSSXpamwAZKv2kB8cIsTlWbpv9sg1DsboWtY5/bHfxdTsZWk5+du54fxCB2W4KjLxeKoag3xu7rMpy/K/xwrq+voQ9/V1Ld5pW8fJyy3O9k8JFH2VG68pSgQPPKOU0Q5X3PYcsKv04NwoBs4EpsrBb20zje7OtxdN6T9ASl8rEqhGScElArrwTykhUaQ6j36vCZGUUZX6mpm+1Z6St2K+g7ZZ3i9DODQJz5sAlS3ZUkrj8zA==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB0688;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR02MB0688;20:XyYleF8p8DucOJQuFeTK+VjKAURuDujwKY7AQWVKgDPGjNE6lTpzPF5P8SvzPEUQWO6C6U7qQJf85ZP7YRPBOI5u96PNY2WSIee//kiSjEO0QZUTzgghKceueNu3COZQuEr0dkbdZhax0VCqYZpb1s7iZRNkdR7h+peLnjiEnwEIMy4rm8q7W4CR5KR8WR1noQizZz2ZblqIMajYZWWJnvr8FoymiJ4oomeXKr1GnLRLp/WR2dnv2IYOdFV4GsYqJWV6aZY595+j0mxbWtC2K0p4ixUODEXdYEF9ofXljXzoiXk/hdaBRH3Q5SpM4BvKpz/Rhn6SsxWt4Of/b050Ct3QCTROCjBlT7UEyEiYEoFTUf3ZLNdX+nfOUai7SQLLXH8jrzK7OpIjCCVuocyF2sVgn+EZU/uuTDwJv77bVFrZxltXVUOmMbUyTI01XexF41uWc/WZbBBhmE9iKUj7Eca/fBVmHexQDPuJ2z+hZLHQoF4kn64BVxJymut9uzQ5;4:xyJKW5cCW+9J+ct7f+G8BgP67tHxyxptyssUccR8+Tc83rew9dcWHo1ys+HjxsqFhvThqX1AIbkfRsGtJGVjVYeE9m1uPNzmG6AE/z0lDYDxhljvl+ZEVjgUjIkR7RpcqjFM9c/jSzQrohFXxgGJNpuPbfAWlvjWmvI+S/C21ZuYeB5xsiZHsxxaEOudd1gRylG525dT5af2CjdmY1h2b+8bD+mkyiDaXdFr9boz
 4RJcaWt/74Now13dTAcDZvmdfifbjH2sdFHHFHDMBJS8Xeyz4YP82as1x/CMEt0gAUMwLJq4cZyMEbbBKfNNjayPF8/6VAchii 
X-Microsoft-Antispam-PRVS: <VI1PR02MB068832215D1CB3A9779A30788F3B0@VI1PR02MB0688.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(520078)(5005006)(8121501046)(3002001);SRVR:VI1PR02MB0688;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB0688;
X-Forefront-PRVS: 07334CBCCD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR02MB0688;23:D7Zn8X9IAM7wMUoc/U9uKRUbjOqUMNuQjJcK6XgK7?=
 =?us-ascii?Q?2nPnWwbsyp4jQAIgMVU4/eH4Npzs+d1Z5zKFBL73OHy8afD1cJKZrlPztiax?=
 =?us-ascii?Q?6VI4xlnZlRQZq4mEDZWfE7rWLVVTK9NY/h/SkIrpZNhMYDO7gsVtlAMRdRqy?=
 =?us-ascii?Q?mQ3IDgltspr0VNI9ACO1n4D/6o4RV4Iz8Me4nwTfpU4aa/Ilb1cb7XsYI5IP?=
 =?us-ascii?Q?xeklj6B5ToWQYDakwg17IeMFWMDkJQu3JrPxgT/I5deqf56a9FDO/I7PdAH6?=
 =?us-ascii?Q?SSYFgIQKr0KcOURg4JtejZBNsw5Y5hEPn1nEtzU2z7/gK847WO/tsgnqVpta?=
 =?us-ascii?Q?3osM0u4T4uiSFnCD7f3HQKzhade6E5Yxw3KCbHNiL51+zEoqBzBk0J6SrS/6?=
 =?us-ascii?Q?UMlyqxvxDP/yA+cR6mBs1fC1fdSJJcos1HBI6a01mwm0cFBPxv4l7adqdBgw?=
 =?us-ascii?Q?xnP6MRhaN77SKv22zboXaTL5ChJATbCvCbWyMhVexTAhAW14D7BXtbAFNIvX?=
 =?us-ascii?Q?M4Fd4gMNKrcaSgnSOJMBsYEy9IJ/e1MeuiPMwJId7NZOlYfH7iwrqAgACO1F?=
 =?us-ascii?Q?mPYkTFwz5mfUNoIrBOjJ1x6Jtbi5ucJODji4vI4McBnPrs2VJVGCut0z/eE3?=
 =?us-ascii?Q?pMIcp5 
X-Microsoft-Exchange-Diagnostics: 1;VI1PR02MB0688;5:UHbj/IuNQyKVXfb/eQfcPUoOg+2mhNsRV9IADAMn4luqCpEe9EW/WlBSmdthrD/AZ7N11L0SuGHwYZoWju/0wCQVMuW99Plvr3rPKq8t6FGhsdDaSCKdxl9nurVgiZqMySubbgrrojnDymIc6NEBDg==;24:M0npiXToorxP4PvBGeTqexwJ4ChhSJs1DseXdNmDVBG9aptJ40sS3vrPN93nwdiC5XaxgwhhVWAcy6TQQefjrFXgLEMDRYFqqjk0wVRdEk8=;20:iXKCAKTbVmO51bwtATDo7uttM9+jrfhC0w8dJh2cmu8Y0nFv+ScMP9TrAoOseFSWkO+tCbbOcEclg3SWMYLD7A==
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ucc.ie
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2015 21:37:57.1049
 (UTC)
X-MS-Exchange-CrossTenant-Id: 46fe5ca5-866f-4e42-92e9-ed8786245545
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=46fe5ca5-866f-4e42-92e9-ed8786245545;Ip=[143.239.1.24];Helo=[mail4.ucc.ie]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB0688
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279822>

git (2.6.1) sometimes updates the modification time of a packfile, even if it
has not changed at all.

On my system this triggers quite expensive an d unnecessary backup
operations, which I would prefer to avoid.  Is there a simple way to
keep the mtime of packfiles fixed, once they are created?

Apparently the undesired mtime update is done in
sha1_file.c:freshen_file() which is called (indirectly) by
write_sha1_file().  However I did not understand, why this is done.

Any clarification and pointers, how mtime can be kept constant would be
appreciated.

Thanks,
Andreas
