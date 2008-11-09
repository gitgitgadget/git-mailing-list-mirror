From: Francis Galiegue <fg@one2team.com>
Subject: Re: [PATCH] git send-email: edit recipient addresses with the --compose flag
Date: Sun, 9 Nov 2008 15:13:55 +0100
Organization: One2team
Message-ID: <200811091513.55544.fg@one2team.com>
References: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Ian Hilt <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 15:15:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzB4W-00009y-GW
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 15:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbYKIOOI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2008 09:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754842AbYKIOOH
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 09:14:07 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:40214 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754838AbYKIOOG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Nov 2008 09:14:06 -0500
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id 0DC9C92C002;
	Sun,  9 Nov 2008 15:13:57 +0100 (CET)
Received: from erwin.kitchen.eel (unknown [10.8.0.6])
	by smtp.olympe.o2t (Postfix) with ESMTP id 8D4717001F;
	Sun,  9 Nov 2008 15:14:04 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100445>

Le Sunday 09 November 2008 13:59:48 Ian Hilt, vous avez =E9crit=A0:
> Sometimes specifying the recipient addresses can be tedious on the
> command-line.  This commit will allow the user to edit the recipient
> addresses in their editor of choice.
>
> Signed-off-by: Ian Hilt <ian.hilt@gmx.com>
> ---
[...]
> +	if ($c_file =3D~ /^To:\s*+(.+)\s*\nCc:/ism) {

Greedy operators are only supported with perl 5.10 or more... I think i=
t's a=20
bad idea to use them...

--=20
=46rancis Galiegue
ONE2TEAM
Ing=E9nieur syst=E8me
Mob : +33 (0) 6 83 87 78 75
Tel : +33 (0) 1 78 94 55 52
fge@one2team.com
40 avenue Raymond Poincar=E9
75116 Paris
