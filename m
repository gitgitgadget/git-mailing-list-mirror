From: Anatol Rudolph <a.rudolph@2vizcon.com>
Subject: git branch command is incompatible with bash
Date: Mon, 27 Jul 2015 14:12:54 +0200
Message-ID: <20150727121253.GC17338@2vizcon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 27 14:46:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJho0-0003Ve-Mg
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 14:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbbG0Mqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 08:46:47 -0400
Received: from mail-db3on0069.outbound.protection.outlook.com ([157.55.234.69]:20215
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752508AbbG0Mqq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 08:46:46 -0400
X-Greylist: delayed 1102 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2015 08:46:46 EDT
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;
Received: from 2vizcon.com (88.79.150.146) by
 HE1PR06MB1338.eurprd06.prod.outlook.com (10.163.176.148) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Mon, 27 Jul 2015 12:13:00 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [88.79.150.146]
X-ClientProxiedBy: HE1PR02CA0056.eurprd02.prod.outlook.com (25.163.170.24) To
 HE1PR06MB1338.eurprd06.prod.outlook.com (25.163.176.148)
X-Microsoft-Exchange-Diagnostics: 1;HE1PR06MB1338;2:SE1z8oyNVT5qAPsm8C53ags1w271HHcg6NVl5v7X2q3ZUAXAS95JD3iYnuLi7q2g6g/8ZKIHMF6bG2JzorJZv5FzeXHyXCBsiN8tdIdUfZ7NAoR2yrqkjGBVOJRBulmnHJqxcin4Tx0WQMcKIE9sMFIGJSXNKVn6ovoNYZVwk5Y=;3:dVsp7SMEdeona7Ri42w4wLTH7Vgnwbw8UXIKgoc0BajLOiF/pjzhxN4rqxCM0QN94l4Tylp/D8ZCbrhik5GbcW+9Or7nKz7PZgv7a8Y6Gh3WUQRTfiq/Y4UtrMrvMVYPokmW+SvT+3yRlbRxJ82KAw==;25:VqptJ7ohHgd+4c5/mPOC+VoYldbQ7fxJYbSVDwqcLB5I/oKG4LVBwAHLzsAZwwbJB5oWhyCXA6710BtqC5A0yga7XpwmF/XM4XdA5CtFw6J/u2d6U5qmTlmSTvhzm2Y/WX1kAYFv2m9yF4pbCj8rf8QpSFftgkDml+mTw7MO7rnAT1A1D9INIyGjVLdwrWMg7mCwiCurONhiCI76T6Fu8UaoUXKhGm+ty8NVndagk6j10ObUfFhdbJd9TFbE+VbMSSvn3zF2Rkti9loB5lbP4w==;4:J0QGaF5LV2A9u8N/xM6d8mOhklnXun5DPb+yoeDMv4VtFHu1ugtQ+7OrbqcudAgjfGPsjpHyKWHOrEhbqHHVdrpVVDu0XS6CqNNm3F6+UaKVdIu0zp0KbEuVOKEMzodNGt6oqz
 neOedNyUxoC3eTEBN7k+KhsDQVQra+Z+QVbL+iqsUYifL6BwgPu2Dr1/GsYFAhx3Qk526+0PBCNzHsX+zIw7PxN7ZNe4VZCa1G 
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:HE1PR06MB1338;
X-Microsoft-Antispam-PRVS: <HE1PR06MB13386EFCB7D3B85052FDD422B78E0@HE1PR06MB1338.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:HE1PR06MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR06MB1338;
X-Forefront-PRVS: 0650714AAA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(66066001)(23676002)(86362001)(450100001)(62966003)(77156002)(107886002)(5001960100002)(110136002)(87976001)(33656002)(122386002)(36756003)(46102003)(40100003)(4001350100001)(47776003)(92566002)(83506001)(50986999)(189998001)(50466002)(229853001)(2351001)(42186005)(77096005)(54356999);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR06MB1338;H:2vizcon.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR06MB1338;23:rptmqwt+KrlnMsFSuggpt2KUK58AtpngaCdfmA03NYtEi1oV70FJKdwHvWrGGE9L0i8IIk3km76WzgsxiCewTPrZzSVKJs740nwUvepktt2zvqgW7imTfeDx74Y6pa0zqebI9tMeFgxmfy2lCBh05gRTSWCk8MHwvHqLZwjG2WZz3aD3msZtdNK80vb6O5K2qHVj2UfcevO0m1vQxbMqUtIy96cdeU5hM+cKfCaCZrjEHYYAKbQAMDuLCq3ysrul1a5HXTrB4oatSS4I1L2J8hXKZuIX/cNKdmUNsmtt9WDyYgaSS/pIy2Gk/gJg/5dMvMAwaTONsq1dAsk+YrubFVVHXbDEcHDOi6CSnqjAz2c2nQG5hfWacbQPwfe4VHeOFaqs/K7Vxc2Pv0TNaabP7ffxjJ6VovbCmtbD2WPAvXOoBaN0V8yZybDVfEUIYKN0+Ga0Dcs9XDCzbc1RnubwAOv6b3TuZaOUy3I8UhiRykVKd2wfEAVY1CY+XtJuAxKVBy0zqZxYQ557Nk0+OIy4DqzHJsWrWHtE27FssU90CiK3RgQBRNA2SWyPdJh4SaOA+CnHxYRrurmICPZ8dn/crBLae7W86VxuiooXbNCBwzzPgDlfvhXweh3YDaNL2tsHlANtzuKVoiOqqze8OQxUuiXvDS1VkMvUcfOJ05ijzikMhjFBVs3WdnndlOFAi02Vjmw7RNBlE7d8bkkZoH59PRPwAGtq0FvAtYQpRiaRHgJ
 UaHS2k19heqxLmWPkTLDI0arDgTNgeyURIzhaBiVnZQ==;5:oJ0yo0ceIQCwzzWQxfaZnrxMphpGkDj1f6lX10BTnhbrzKqu4B 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR06MB1338;24:/c9vKGwJjchZfRPZ2uHBK+3FoYzKKtrjsOm5Bvdkz+c1mmSx7QvyMabLbgHy8mjnyumptNI2+M/JhWpGfsMMQYRD3stGyUOAbFRUcX/pMi4=;20:gp/WcdzdgODMFVzDJQdB+CkPyDFfePIQwYo6HtOF6xIHCWm+rsYa3LExBxShiQrIcDxGHOTtNeRy7IT05xY9Vg==
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: 2vizcon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2015 12:13:00.9221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB1338
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274672>

Hello!

I hope posting this to this mailing list is okay, this is the first ever
mail that I submit to a technical mailing list. 

When using the git branch command, git uses a '*' to denote the current
branch. Therefore, in bash this:

	$ branchName=$(git branch -q)
	$ echo $branchName

produces a directory listing, because the '*' is interpreded by the
shell. 

While an (unwieldly) workaround exists:

	$ branchName=$(git symbolic-ref -q HEAD)                                                                            
	$ branchName=${branch##refs/heads/}

it would still be nice, if there were a --current flag, that returned
only the current branch name, omitting the star:

	$ branchName=$(git branch --current -q)
	$ echo $branchName
	master
