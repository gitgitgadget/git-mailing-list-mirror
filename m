From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] Git homepage: remove all the references to Cogito
Date: Mon, 15 Oct 2007 23:38:00 +0200
Message-ID: <20071015233800.6306e414@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: pasky@suse.cz
X-From: git-owner@vger.kernel.org Tue Oct 16 00:33:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhXdb-00014B-1F
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 23:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbXJOVh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 17:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbXJOVh5
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 17:37:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:21690 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbXJOVh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 17:37:56 -0400
Received: by ug-out-1314.google.com with SMTP id z38so970652ugc
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 14:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=E5hPplxXORAPFktVKmBa2Nk8OkthQlyd6AiFf/zyrDs=;
        b=NrCkkT1shgtKEO3XHrU5eCgKci9x9zrt5P7ZDlfqpfij/RRIQqr89H2jhuQHudOiaf4tbSJgjw4vljeILE8u7OcRNCUno7UpIKwpDmuDeFRlRYJZWZGyms0aA+Scb41wer5Lga6dRgq87hieh5pLnx4BFXhgOBRRvt+EXuOL3Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=WGu5WeEIJUhb4W16QvOIaxsoDxdkmTB3tBSmzLtiJd/HcHrgxIVLUiVPOXl1KRD/iBL/k7wQrYGSp3f7kDO90qVPyVBiZxR30HYPNWMesY8hsqj1o+Bj740MKfZBvdRfivSTVMHJIHJzphVieJtfOY1RQl/oze71ssDWHDmtE2c=
Received: by 10.66.255.7 with SMTP id c7mr8348723ugi.1192484274364;
        Mon, 15 Oct 2007 14:37:54 -0700 (PDT)
Received: from paolo-desktop ( [82.50.4.36])
        by mx.google.com with ESMTPS id i4sm2519357nfh.2007.10.15.14.37.52
        (version=SSLv3 cipher=OTHER);
        Mon, 15 Oct 2007 14:37:53 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61047>

It sounds like a good idea to remove all the references to Cogito from the git homepage since it's not longer supported.
Changes tested with a local installation of the web server lighttpd

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 index.html |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/index.html b/index.html
index 340aee0..41605ed 100644
--- a/index.html
+++ b/index.html
@@ -94,7 +94,6 @@ Junio C Hamano.</p>
 	-->
 	<br /><a href="course/stgit.html">Maintaining external patches</a>
 	<br /><a href="course/svn.html">Git for SVN users</a>
-	<br /><a href="course/cvs.html">Cogito for CVS users</a>
 	<br /><em>More to come soon...</em>
 	</tr></td>
 </table></div>
@@ -286,15 +285,6 @@ a gitweb interface, at <a href="http://repo.or.cz/">http://repo.or.cz/</a>.</p>
 
 <dl>
 
-<dt id="cogito">Cogito</dt>
-<dd>
-<a href="http://git.or.cz/cogito/">Cogito</a>
-is a popular version control system on top of Git.
-It aims at seamless user interface and ease of use, providing
-generally smoother user experience than the "raw" Git interface
-and indeed also many other version control systems. However, it
-also lacks many advanced capabilities of Git and is currently
-being slowly phased out.</dd>
 
 <dt id="stgit">StGIT</dt>
 <dd><a href="http://www.procode.org/stgit/">Stacked Git</a> provides
@@ -340,7 +330,7 @@ with help of a group of hackers 'round the net.
 It is currently maintained by
 Junio C Hamano.</p>
 
-<p>The user discussion and development of Git, Cogito and other tools related to Git
+<p>The user discussion and development of Git and other tools related to Git
 takes place on the Git mailing list - everyone is welcome to post
 bug reports, feature requests, comments and patches to
 <a href="mailto:git@vger.kernel.org">git@vger.kernel.org</a>.
-- 
1.5.3.4.206.g58ba4
