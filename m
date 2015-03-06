From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH] send-email: Add CCs from additional commit tags
Date: Fri, 6 Mar 2015 13:59:21 -0800
Message-ID: <1425679161-13963-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 23:32:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU0nM-0003SU-1w
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 23:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755749AbbCFWcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 17:32:31 -0500
Received: from mail-bl2on0066.outbound.protection.outlook.com ([65.55.169.66]:8816
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754313AbbCFWca (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 17:32:30 -0500
X-Greylist: delayed 1041 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Mar 2015 17:32:30 EST
Received: from BY2FFO11FD029.protection.gbl (10.1.14.31) by
 BY2FFO11HUB007.protection.gbl (10.1.14.213) with Microsoft SMTP Server (TLS)
 id 15.1.112.13; Fri, 6 Mar 2015 21:59:44 +0000
Received: from xsj-tvapsmtpgw01 (149.199.60.96) by
 BY2FFO11FD029.mail.protection.outlook.com (10.1.14.212) with Microsoft SMTP
 Server (TLS) id 15.1.112.13 via Frontend Transport; Fri, 6 Mar 2015 21:59:44
 +0000
Received: from 172-16-1-203.xilinx.com ([172.16.1.203]:41762 helo=xsj-tvapsmtp02.xilinx.com)
	by xsj-tvapsmtpgw01 with esmtp (Exim 4.63)
	(envelope-from <soren.brinkmann@xilinx.com>)
	id 1YU0Da-0005Jk-78; Fri, 06 Mar 2015 13:55:38 -0800
Received: from [127.0.0.1] (port=39337 helo=xsj-tvapsmtp02)
	by xsj-tvapsmtp02.xilinx.com with esmtp (Exim 4.63)
	(envelope-from <soren.brinkmann@xilinx.com>)
	id 1YU0HX-0002hB-Qn; Fri, 06 Mar 2015 13:59:43 -0800
Received: from [172.19.74.49] (port=36842 helo=xsjsorenbubuntu.xilinx.com)
	by xsj-tvapsmtp02 with esmtp (Exim 4.63)
	(envelope-from <soren.brinkmann@xilinx.com>)
	id 1YU0HX-0002h8-By; Fri, 06 Mar 2015 13:59:43 -0800
X-Mailer: git-send-email 2.3.1.2.g90df61e.dirty
X-TM-AS-MML: disable
X-TM-AS-Product-Ver: IMSS-7.1.0.1679-7.5.0.1018-21380.002
X-TM-AS-Result: No--6.441-7.0-31-10
X-imss-scan-details: No--6.441-7.0-31-10
X-TMASE-MatchedRID: yvDAzrttxFW71D3eW4MsP5UJP7vFynrRtZN20SHV1TSyviDTFB4Ln9/9
	N6lK9KH6lTJXKqh1ne2b7quYRXJ/JsFeWQ9rEC3V/c0+LJTMrN2w3bSBLOCKsiejgKDUPU+kPH1
	YQV8stCdrpI/D8jslP4Ay6p60ZV62fJ5/bZ6npdg7AFczfjr/7E2bAORjTG0LWNhp6fjzTgqoft
	njKuiODqzW+Twct4KOOpClPH3M2CQ=
X-EOPAttributedMessage: 0
Received-SPF: Fail (protection.outlook.com: domain of xilinx.com does not
 designate 149.199.60.96 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.96; helo=xsj-tvapsmtpgw01;
Authentication-Results: spf=fail (sender IP is 149.199.60.96)
 smtp.mailfrom=soren.brinkmann@xilinx.com; pobox.com; dkim=none (message not
 signed) header.d=none;
X-Forefront-Antispam-Report: CIP:149.199.60.96;CTRY:US;IPV:NLI;EFV:NLI;BMV:1;SFV:NSPM;SFS:(10009020)(6009001)(339900001)(189002)(199003)(105606002)(33646002)(110136001)(77096005)(77156002)(6806004)(64026002)(19580395003)(62966003)(19580405001)(36756003)(47776003)(71366001)(2351001)(50466002)(87936001)(50986999)(50226001)(16796002)(85426001)(229853001)(46102003)(48376002)(92566002)(86362001)(7059030)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2FFO11HUB007;H:xsj-tvapsmtpgw01;FPR:;SPF:Fail;MLV:sfv;MX:1;A:1;LANG:en;
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BY2FFO11HUB007;
X-Microsoft-Antispam-PRVS: <BY2FFO11HUB007EF6FC518508A600FC3618C1C0@BY2FFO11HUB007.protection.gbl>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(5002007);SRVR:BY2FFO11HUB007;BCL:0;PCL:0;RULEID:;SRVR:BY2FFO11HUB007;
X-Forefront-PRVS: 05079D8470
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2015 21:59:44.6721
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.96];Helo=[xsj-tvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2FFO11HUB007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264969>

Add email addresses from additional commonly used tags to the CC-list of
patches. Additional tags are:
 - Acked-by
 - Reviewed-by
 - Tested-by
 - Reported-by
 - Reviewed-and-tested-by

--suppress-cc=ack suppresses these additional CCs.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 Documentation/git-send-email.txt | 3 +++
 git-send-email.perl              | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index f248a8665e1f..1b521446ca11 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -293,6 +293,9 @@ Automating
   patch body (commit message) except for self (use 'self' for that).
 - 'sob' will avoid including anyone mentioned in Signed-off-by lines except
    for self (use 'self' for that).
+- 'ack' will avoid including anyone who acked the  patch (mentioned in
+  Acked-by, Reviewed-by, Tested-by, Reviewed-and-tested-by lines except for
+  self (use 'self' for that).
 - 'cccmd' will avoid running the --cc-cmd.
 - 'body' is equivalent to 'sob' + 'bodycc'
 - 'all' will suppress all auto cc values.
diff --git a/git-send-email.perl b/git-send-email.perl
index 3092ab356c76..18eb8a5139a4 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -407,7 +407,7 @@ my(%suppress_cc);
 if (@suppress_cc) {
 	foreach my $entry (@suppress_cc) {
 		die "Unknown --suppress-cc field: '$entry'\n"
-			unless $entry =~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc)$/;
+			unless $entry =~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc|ack)$/;
 		$suppress_cc{$entry} = 1;
 	}
 }
@@ -1452,7 +1452,7 @@ foreach my $t (@files) {
 	# Now parse the message body
 	while(<$fh>) {
 		$message .=  $_;
-		if (/^(Signed-off-by|Cc): (.*)$/i) {
+		if (/^(Signed-off-by|Cc|Acked-by|Reviewed-by|Tested-by|Reported-by|Reviewed-and-tested-by): (.*)$/i) {
 			chomp;
 			my ($what, $c) = ($1, $2);
 			chomp $c;
@@ -1462,6 +1462,7 @@ foreach my $t (@files) {
 			} else {
 				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
 				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
+				next if $suppress_cc{'ack'} and $what =~ /(Acked-by|Reviewed-by|Tested-by|Reported-by|Reviewed-and-tested-by)/i;
 			}
 			push @cc, $c;
 			printf("(body) Adding cc: %s from line '%s'\n",
-- 
2.3.1.2.g90df61e.dirty
