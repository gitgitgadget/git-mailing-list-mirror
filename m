From: Vincent Zanotti <vincent.zanotti@m4x.org>
Subject: [PATCH] gitweb: correct month in date display for atom feeds
Date: Sat, 10 Nov 2007 19:55:27 +0100
Message-ID: <4735FE9F.30808@m4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 20:14:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqvn7-0005xv-3w
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 20:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbXKJTOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 14:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbXKJTOd
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 14:14:33 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:36667 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbXKJTOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 14:14:33 -0500
X-Greylist: delayed 1126 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Nov 2007 14:14:33 EST
Received: from vincent-p.m4z.org (ip-159.net-82-216-138.issy4.rev.numericable.fr [82.216.138.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id E5FCB33172
	for <git@vger.kernel.org>; Sat, 10 Nov 2007 19:55:44 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20070802 SeaMonkey/1.1.4
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Sat Nov 10 19:55:45 2007 +0100 (CET))
X-Spam-Flag: No, tests=bogofilter, spamicity=0.000167, queueID=0EF933318B
X-Org-Mail: vincent.zanotti.2004@polytechnique.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64370>

Signed-off-by: Vincent Zanotti <vincent.zanotti@m4x.org>

---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 759dff1..e788ef9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1856,7 +1856,7 @@ sub parse_date {
        $date{'mday-time'} = sprintf "%d %s %02d:%02d",
                             $mday, $months[$mon], $hour ,$min;
        $date{'iso-8601'}  = sprintf "%04d-%02d-%02dT%02d:%02d:%02dZ",
-                            1900+$year, $mon, $mday, $hour ,$min, $sec;
+                            1900+$year, 1+$mon, $mday, $hour ,$min, $sec;

        $tz =~ m/^([+\-][0-9][0-9])([0-9][0-9])$/;
        my $local = $epoch + ((int $1 + ($2/60)) * 3600);
--
1.5.3.4
