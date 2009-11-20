From: Roman Fietze <roman.fietze@telemotive.de>
Subject: [PATCH] bash completion: add space between branch name and status flags
Date: Fri, 20 Nov 2009 13:09:16 +0100
Organization: Telemotive AG
Message-ID: <200911201309.16193.roman.fietze@telemotive.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 20 13:16:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBSPK-0007tq-Vp
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 13:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbZKTMPy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Nov 2009 07:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbZKTMPy
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 07:15:54 -0500
Received: from coyote.quickmin.net ([217.14.112.24]:55392 "EHLO
	coyote.quickmin.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbZKTMPx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Nov 2009 07:15:53 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Nov 2009 07:15:53 EST
Received: (qmail 3800 invoked from network); 20 Nov 2009 13:09:17 +0100
Received: by simscan 1.4.0 ppid: 3797, pid: 3798, t: 0.0127s
         scanners: clamav: 0.95.2/m:49/d:8609
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=telemotive.de;
  b=K1om2zjX/G6ZltFW2YbV7tzMhuoVe6yClqlz+d6eLCRwS8zZDXephhn7pugCMdGqWlJtnfSt9gV4urUiq0E6l7lUuq9nT8mXU6AFuc6jaCPncBMJ946dSFDZe11PQC49yFLOjKYgfXKU4c6pYOHeUzPeVJbcjlzQPpqxgkJCyYo=  ;
Received: from mail.telemotive.de (62.206.149.210)
  by coyote.quickmin.net with SMTP; 20 Nov 2009 13:09:17 +0100
Received: from alderan.mit.telemotive.de ([192.168.5.15])
          by mail.telemotive.de (Lotus Domino Release 8.0.2FP1)
          with ESMTP id 2009112013091647-14107 ;
          Fri, 20 Nov 2009 13:09:16 +0100 
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de [192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id A4167C8158;
	Fri, 20 Nov 2009 13:09:16 +0100 (CET)
Received: by rfietze.mit.telemotive.de (Postfix, from userid 10062)
	id 694D61821A0E; Fri, 20 Nov 2009 13:09:16 +0100 (CET)
User-Agent: KMail/1.12.3 (Linux/2.6.27.37-0.1-default; KDE/4.3.3; x86_64; ; )
X-MIMETrack: Itemize by SMTP Server on muc/Telemotive(Release 8.0.2FP1|January 12, 2009) at
 20.11.2009 13:09:16,
	Serialize by Router on muc/Telemotive(Release 8.0.2FP1|January 12, 2009) at
 20.11.2009 13:09:17,
	Serialize complete at 20.11.2009 13:09:17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133341>

Hello Shawn, hello git list members,

Wouldn't it improve the readability of the bash prompt, if there would
be a space between the branch name and the status flags (dirty, stash,
untracked)?

Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
---
 contrib/completion/git-completion.bash |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-
completion.bash
index bd66639..407176b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -169,10 +169,12 @@ __git_ps1 ()
 			fi
 		fi
=20
+		local f=3D"$w$i$s$u$r"
+		f=3D${f:+ $f}
 		if [ -n "${1-}" ]; then
-			printf "$1" "$c${b##refs/heads/}$w$i$s$u$r"
+			printf "$1" "$c${b##refs/heads/}$f"
 		else
-			printf " (%s)" "$c${b##refs/heads/}$w$i$s$u$r"
+			printf " (%s)" "$c${b##refs/heads/}$f"
 		fi
 	fi
 }
--=20
1.6.4.2


Roman

--=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
