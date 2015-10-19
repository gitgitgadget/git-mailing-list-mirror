From: Andreas Amann <a.amann@ucc.ie>
Subject: Re: problem with modification time of packfiles
Date: Mon, 19 Oct 2015 20:59:15 +0100
Message-ID: <87a8re4oks.fsf@msstf091.ucc.ie>
References: <87io63503w.fsf@msstf091.ucc.ie> <20151019025727.GA23404@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Oct 19 22:13:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoGoc-0007GI-Hl
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 22:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbbJSUNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 16:13:50 -0400
Received: from mail-am1on0095.outbound.protection.outlook.com ([157.56.112.95]:34496
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751691AbbJSUNt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 16:13:49 -0400
Received: from AM3PR02CA0077.eurprd02.prod.outlook.com (10.163.180.45) by
 VI1PR02MB1008.eurprd02.prod.outlook.com (10.163.163.18) with Microsoft SMTP
 Server (TLS) id 15.1.300.14; Mon, 19 Oct 2015 19:59:19 +0000
Received: from DB3FFO11FD055.protection.gbl (2a01:111:f400:7e04::165) by
 AM3PR02CA0077.outlook.office365.com (2a01:111:e400:5365::45) with Microsoft
 SMTP Server (TLS) id 15.1.300.14 via Frontend Transport; Mon, 19 Oct 2015
 19:59:18 +0000
Authentication-Results: spf=pass (sender IP is 143.239.1.24)
 smtp.mailfrom=ucc.ie; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=permerror action=none
 header.from=ucc.ie;
Received-SPF: Pass (protection.outlook.com: domain of ucc.ie designates
 143.239.1.24 as permitted sender) receiver=protection.outlook.com;
 client-ip=143.239.1.24; helo=mail4.ucc.ie;
Received: from mail4.ucc.ie (143.239.1.24) by
 DB3FFO11FD055.mail.protection.outlook.com (10.47.217.127) with Microsoft SMTP
 Server (TLS) id 15.1.300.4 via Frontend Transport; Mon, 19 Oct 2015 19:59:18
 +0000
Received: from msstf091.ucc.ie (msstf091.ucc.ie [143.239.76.91])
	by mail4.ucc.ie (8.14.4/8.14.4) with ESMTP id t9JJxFMS024290;
	Mon, 19 Oct 2015 20:59:17 +0100
Received: by msstf091.ucc.ie (Postfix, from userid 1000)
	id 81481A406C; Mon, 19 Oct 2015 20:59:15 +0100 (IST)
In-Reply-To: <20151019025727.GA23404@vauxhall.crustytoothpaste.net>
User-Agent: Notmuch/0.20.2 (http://notmuchmail.org) Emacs/24.5.1 (x86_64-unknown-linux-gnu)
X-EOPAttributedMessage: 0
X-Microsoft-Exchange-Diagnostics: 1;DB3FFO11FD055;1:XKYSzFp/UukkXIWUaWH6brsj/qHbQjdHUeWwTeJyvVZuVBCOSyFonTaQBk0UevDk/2XXOmQxk85pwbliFy5rEQq/B1TjDwCo6NAsKUWzxWY2dFrs6qu3aiK+pU5AdCdFVkmBb1UtfKTDr5pXHp8gSbF28iUt9sfQLFMWI8hi/+9ks+kmq6LDNM4Q9w6tIu4TCD5pro05orAShu38HzQDrqoTBn6mxGLgIDXjXhnN+jhgVlwemxzI4lJW7hNbctVYpY7KYEMwDlyrWQ9F7UMtGsYmZY5Ghz5uTELuH3nG+95cIo4/l3eePlr9yp2Vfj1GvQI198qXMZ278G2ss1ChJnXfBzFkZUvHNwaJ4cRcc73RJbPTp4Z+u5uhxzlU3z3qxJqyPBZG1XCJFuJgtfNqnw==
X-Forefront-Antispam-Report: CIP:143.239.1.24;CTRY:IE;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(2980300002)(438002)(189002)(199003)(24454002)(45336002)(110136002)(189998001)(6806005)(42186005)(92566002)(4001350100001)(47776003)(64706001)(5001970100001)(5003940100001)(5007970100001)(87936001)(83506001)(40036005)(2950100001)(33646002)(36756003)(16796002)(50466002)(19580405001)(48376002)(46386002)(11100500001)(86362001)(52956003)(103686003)(19580395003)(106466001)(50986999)(54356999)(76176999)(90966002)(74482002)(46102003)(5008740100001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR02MB1008;H:mail4.ucc.ie;FPR:;SPF:Pass;PTR:mail4.ucc.ie;MX:1;A:0;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR02MB1008;2:4eNptudvU1nYrGvZ88OD4TWR7JaMYXY9QVJSOz+q9xJB/zc8EJeNctzK2/sagr2rX/9445uCW+vaS8PYbcPg3xiusU5leNat1PtZfrweuF4lRsnvQxL6AM4NvDVw7CsuPC+0kL9bUzqHG9gNxhNjAnFwG9qrUIFF2l0MIgYuXc0=;3:rcKETR5uIO+tyXJnXMriSMmmtq9k3dkZNtIFTLY/aysJslBStzk/LPAHyX+F6RWvkjzeY4uCevgcdOJkUxPGAiWVezJyTZk9i/8BMWFVcdSXNDJtdd93j9IWxHEsWX6ZUXZ9sz8UgQ3kpydFTLIY2P87Gtx3j90FoGcWUirDZaJvZqM0wz+Qu/fKlukUE1ep0Wp9sdg+um2gg+xJN83ut06fjQc3IdAEeODM43Ssenk=;25:HtMro/7UIWT3+ZrVfK7Gm+aX7jmRezvBCDny4CmH3Hlo+RVGvWzh4wArrLUxLdFd+iLHez4l3yuUmRIeznTJMiiyyZti3NsuQHR9oKeynEYIo1F1xlvHS4+p5OB0EEygjEvLU+9kCoCORHFUK4N0OypLLkvyp+SdY/fBpMbJHzA+4zrRb2K8y2Edz/bfOpIV8mOtbXknSigIsucCDweOAyDWs3nqHjHEbWpuc6g1++4xEZTiDsWcAVLbdJV3j7NK0oG6K20Eq0TnDTz6EehXTQ==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB1008;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR02MB1008;20:npp31lLyZW5okoR4cSscuvbr1EW8OjGuM2l6/JRf8aYCgV/n2Gnq6OnHVJ096zeyUL3HH5BxQE9DQx7FCDlMUxXlAI1Wladwxy/uXso4LlRUw2nDdG9aBosVSVFtb2hxB2r2tVyAXZJlZAvy7XVZEtPSRHro5kytI31IjKLbkW4MRi4kLdRs5WcEvvn5uRc4RHnXsSbwj0qcknrvHCBkskaSKyPbHFeGmDUCEeqN8ZRANubMuOsxzMmlelLCtM6Z6zGiaPZj0GKb0ryx7Lbb0xMjWlnF9Ur8SyHU6/MstoKMfrZoDZobnGMAU8BpudPOIcOMka/ziderGbkqPWqiE5wOXTlPtVd0zNc7Xmiv3ecQYSf3Rcb13NH50qERiLywGGrdGlUDBj/cPIi4JotR430Vt93vksRxM6d3Ij8hO+xcpSKf82Cz9b1Z0MEP5JrZitRmPK00qweqfVBhcjCVHzY9FeCB2AzJXEMww2uASsdYjNDGKAcORBvFkmifaL4B;4:8WN3DmI1azycyjF8F2eLKkNn7DIb5x/vta99ybuQJvj5hp3wQzGY8QhH8Qa7u9m/lhTOX9ZqggsK6pp9cLVJdqkqiDdZckOjbBw1nmZvVoXfflW/Jtak7hDmFOHL7lSogU1+JrdL4z+lr1XLZEWQjMBF14ddnzmQaQdQsSm0x2kn4/OfRthZeX4mOEHY3UTNbijX1tpUykT4SH1bT6G1D0n2w9G1FFObHfeFSkKM
 dyMEH9pflUe42W/l8oyBgdZRqTn4f4kT+F5pLzDeb0z1a45YMd1SDAjd6LZhW7FliCmHs/OkNHzibOdptXhhU5CK+zYTjv5puq 
X-Microsoft-Antispam-PRVS: <VI1PR02MB10087117B6A0A8B75AE488978F3A0@VI1PR02MB1008.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(8121501046)(5005006)(520078)(3002001);SRVR:VI1PR02MB1008;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB1008;
X-Forefront-PRVS: 07349BFAD2
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR02MB1008;23:jszVGIFP6HFxCja8v6WAg2xp1h44KIDiYteDUgoZ7?=
 =?us-ascii?Q?tgu8FUcZ0mB/AZCbEG53nIYLndUhsvT51ygbVWMCBHGIobIkVaFBJA4HQUkZ?=
 =?us-ascii?Q?BhsVLgV8HkmX/bzCAE82z/3dNj9mlqLwPmC0wAkmZrkWynG0xhA0m98FDh2h?=
 =?us-ascii?Q?bwaHfpBF1tKZSd1zbl9qdnOx88unjbC2M8rQJMEnUW3wKMxr+bPt4d5acAkP?=
 =?us-ascii?Q?Hry0Ju5MmfVct5ExTpFH3I5xHnn7PFYRMRwXK6xTm347TPoSsXwAPGWHGor9?=
 =?us-ascii?Q?hpun5yapkv8A17/xPhFfT2dco4kQKrBp1kyY9kvFHKIOKAMNta32QxhxrPAK?=
 =?us-ascii?Q?K0tpNTCgJ258nb95XaRwC21PK6/abUUdrqYCZmRQcM4VlxSfoLR/uhLO2Z7m?=
 =?us-ascii?Q?sD3D7BsEH6ExXfP4eb4uzqDWB4YOOmhGoR47cjhTJbp1XiQO8INl06r5wL+h?=
 =?us-ascii?Q?atcrYdLk+fVvTGfEyNRZbJH7nLhuc8b1n3oOg54z//oT8ugaOBR0RUH+6Zbc?=
 =?us-ascii?Q?TTeHTOHvydhhukCuH+tt9KvJpcDpmM3s+qeBXyQRdTfgR2ORd+8QqcVQ/99l?=
 =?us-ascii?Q?FNrLJal/sKVxLOi3hjB0fvnxPH9wML/PKOlIFi3/lbM0hZ/D3IzABeOe+zYK?=
 =?us-ascii?Q?74By43 
X-Microsoft-Exchange-Diagnostics: 1;VI1PR02MB1008;5:hEzZicT4Rg9Oy+T2N3lMLGv6vJEJbWlBpwOBDhNlviAmfNjHFCunUTpIOWVMrcxV6hVa012PzMDYmdeWAhlkqcH0fuCttL605Nl+OhiAnL/uPLcp2bbhFr6jZN977i8TpiK8vhH+5gfHSgBxuQZSzQ==;24:QQvu6fh6ECfYG3bSFqRkOMppuX8ElXLu5aSDpC4ayAQBA8tG2raco5ArYK2Hlp/O6cjbmohlI9DSKXr3hJsSZdspGKUACos8ns7+5SImpp4=;20:KocjHbXPuOZAGp6R248cA0E7Z1yAmdQkpJmjqLUu08shY8KMjLQC5DOw8B/CxYbG2Z2CfNHoPUySRn+0OeMQ+Q==
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ucc.ie
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2015 19:59:18.4487
 (UTC)
X-MS-Exchange-CrossTenant-Id: 46fe5ca5-866f-4e42-92e9-ed8786245545
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=46fe5ca5-866f-4e42-92e9-ed8786245545;Ip=[143.239.1.24];Helo=[mail4.ucc.ie]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB1008
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279890>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:
> On Sun, Oct 18, 2015 at 10:37:55PM +0100, Andreas Amann wrote:
>> git (2.6.1) sometimes updates the modification time of a packfile, even if it
>> has not changed at all.
>> 
>> On my system this triggers quite expensive an d unnecessary backup
>> operations, which I would prefer to avoid.  Is there a simple way to
>> keep the mtime of packfiles fixed, once they are created?
>> 
>> Apparently the undesired mtime update is done in
>> sha1_file.c:freshen_file() which is called (indirectly) by
>> write_sha1_file().  However I did not understand, why this is done.
>> 
>> Any clarification and pointers, how mtime can be kept constant would be
>> appreciated.
>
> This is required to avoid deleting items that might still be needed.
> The commit message for the commit that introduced that function is as
> follows:
>
>   write_sha1_file: freshen existing objects
>   
>   When we try to write a loose object file, we first check
>   whether that object already exists. If so, we skip the
>   write as an optimization. However, this can interfere with
>   prune's strategy of using mtimes to mark files in progress.
>   

Thank you for your answer.  However, this reasoning only applies to loose
objects and not packfiles.

My understanding is that "git prune" will not prune any pack files
(except those starting with tmp_).  Only "git repack" should do that.
Repack seems to be however mtime agnostic and therefore it does not seem
to be necessary to freshen packfiles.

It therefore seems that git freshens packfiles unnecessarily, which can
lead to expensive and unnecessary backup operations. 

Given this, would a trivial patch to remove the freshening of packfiles
be acceptable?

Alternatively, maybe it would be preferrable to use ctime instead of
mtime to mark recently used packfiles and loose objects?  This might be
more natural, as mtime is usually associated with a "modification" of
the file itself, which does not happen here.  ctime on the other hand
indicates attribute changes.  (Instead of utime() in this case chmod()
could be used to update ctime.)
