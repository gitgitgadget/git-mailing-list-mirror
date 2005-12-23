From: M_ <barra_cuda@katamail.com>
Subject: [PATCH] git-show-branch: show the right things when "--heads" or "--tags" is specified
Date: Fri, 23 Dec 2005 17:35:35 +0100
Message-ID: <200512231735.36092.barra_cuda@katamail.com>
Reply-To: barra_cuda@katamail.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 23 17:30:00 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eppnm-0003sm-UR
	for gcvg-git@gmane.org; Fri, 23 Dec 2005 17:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030572AbVLWQ3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Dec 2005 11:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030579AbVLWQ3u
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Dec 2005 11:29:50 -0500
Received: from fe-3a.inet.it ([213.92.5.105]:45522 "EHLO fe-3a.inet.it")
	by vger.kernel.org with ESMTP id S1030572AbVLWQ3u (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Dec 2005 11:29:50 -0500
Received: from dial-up-mi-205.lombardiacom.it ([::ffff:212.34.225.205]) by fe-3a.inet.it via I-SMTP-5.2.3-521
	id ::ffff:212.34.225.205+NNM5qiu40t; Fri, 23 Dec 2005 17:29:48 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13995>


---

 show-branch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

26c0f04b8a370ac9943bb409b8cd5e7370263f41
diff --git a/show-branch.c b/show-branch.c
index c742246..2aeabd9 100644
--- a/show-branch.c
+++ b/show-branch.c
@@ -515,7 +515,7 @@ int main(int ac, char **av)
        if (all_heads + all_tags)
                snarf_refs(all_heads, all_tags);

-       if (ac) {
+       if (ac + all_heads + all_tags) {
                while (0 < ac) {
                        append_one_rev(*av);
                        ac--; av++;
--
1.0.0b
