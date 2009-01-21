From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH resend] bash completion: add 'rename' subcommand to git-remote
Date: Wed, 21 Jan 2009 23:59:22 +0100
Message-ID: <200901212359.23241.markus.heidelberg@web.de>
References: <200901162254.58300.markus.heidelberg@web.de> <200901201921.10223.markus.heidelberg@web.de> <7veiyxeyzr.fsf@gitster.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 00:01:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPm3t-0003Or-74
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 00:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbZAUW7P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 17:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754017AbZAUW7P
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 17:59:15 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:54039 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbZAUW7O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 17:59:14 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 08029FC0FE76;
	Wed, 21 Jan 2009 23:59:13 +0100 (CET)
Received: from [89.59.73.85] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LPm2S-0003d3-00; Wed, 21 Jan 2009 23:59:12 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <7veiyxeyzr.fsf@gitster.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18RgiKllGpsfCfCevjG0YBIi9Z3kyg4/EdBR+HS
	ZmPtgxs70fUjD4l0MYt1j7MrBk2X6NjTaVfsL1XeQo30xus23B
	F8Y+9IwIgypQmM9qhzew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106698>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
---

> > I really don't like to bother you again, but compared to the inclus=
ion
> > of the other patches, I guess you have forgotten the third try of t=
his
> > patch.
> >
> > Thus this fourth try :)
>=20
> I did not mean that I forgot by the above "I seem to have missed".
> Literally none of your three attempts seem to have reached me.

Ah, OK. With "missed" I thought you have just overlooked them.

>=A0I can
> guess what you wrote from the _included_ text in Shawn's response, bu=
t
> that is not a good/right place for me to pick up a patch from, is it?

No, it isn't.


next mail:
I just don't get it. The previous mail, I sent three a half hours ago,
didn't reach the list either. Am I doing anything wrong?  I looked at
the archives: the first two got to the list, the 3rd (with the Acked-by
from Shawn) and 4th didn't. Now this is the 5th. I can't remember any
such problems with mail delivery.


 contrib/completion/git-completion.bash |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 3ce6de2..f2d6cad 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1391,7 +1391,7 @@ _git_config ()
=20
 _git_remote ()
 {
-	local subcommands=3D"add rm show prune update"
+	local subcommands=3D"add rename rm show prune update"
 	local subcommand=3D"$(__git_find_subcommand "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -1399,7 +1399,7 @@ _git_remote ()
 	fi
=20
 	case "$subcommand" in
-	rm|show|prune)
+	rename|rm|show|prune)
 		__gitcomp "$(__git_remotes)"
 		;;
 	update)
--=20
1.6.1.227.gad9c0
