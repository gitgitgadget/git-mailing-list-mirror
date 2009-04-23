From: Francis Galiegue <fge@one2team.com>
Subject: Re: [EGit PATCH] IgnoreAction to add to .gitignore files
Date: Thu, 23 Apr 2009 14:27:29 +0200
Organization: One2team
Message-ID: <200904231427.29832.fge@one2team.com>
References: <20090423115042.743E6D9CDC@apple.int.bandlem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: alex.blewitt@gmail.com, git@vger.kernel.org,
	robin.rosenberg@dewire.com, spearce@spearce.org
To: Alex Blewitt <alex@bandlem.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 14:29:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwy3H-0007eo-Fe
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 14:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbZDWM1e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 08:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756146AbZDWM1d
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 08:27:33 -0400
Received: from ns35774.ovh.net ([213.251.185.197]:54311 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756195AbZDWM1c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 08:27:32 -0400
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id 66B1592C002;
	Thu, 23 Apr 2009 14:27:23 +0200 (CEST)
Received: from erwin.olympe.o2t (erwin.olympe.o2t [192.168.1.21])
	by smtp.olympe.o2t (Postfix) with ESMTP id 518DA2F2C3;
	Thu, 23 Apr 2009 14:27:30 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090423115042.743E6D9CDC@apple.int.bandlem.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117336>

Le jeudi 23 avril 2009, Alex Blewitt a =E9crit=A0:
> diff --git a/org.spearce.egit.ui/plugin.properties=20
b/org.spearce.egit.ui/plugin.properties
> index 523a959..be3b40c 100644
> --- a/org.spearce.egit.ui/plugin.properties
> +++ b/org.spearce.egit.ui/plugin.properties
> @@ -52,10 +52,12 @@ FetchAction_tooltip=3DFetch from another reposito=
ry
>  PushAction_label=3D&Push To...
>  PushAction_tooltip=3DPush to another repository
> =20
> +IgnoreAction_label=3DAdd to .git&ignore...
> +IgnoreAction_tooltip=3DIgnore the selected resources
> +
>  GitActions_label=3DGit
>  GitMenu_label=3D&Git
> =20

The label and tooltip are too "git-specific", IMHO. I'd rather see:

IgnoreAction_label=3D&Ignore file(s) for commits...
IgnoreAction_tooltip=3DThe selected file(s) will not be included by def=
ault in=20
your commits. However, you may force the include of these files in a co=
mmit=20
by explicitly adding them via "Team->Add" [or whatever the label is].
\n\nSelecting files to ignore by this mechanism will automatically add =
one or=20
more files named .gitignore in your next commit.

--=20
=46rancis Galiegue
ONE2TEAM
Ing=E9nieur syst=E8me
Mob : +33 (0) 683 877 875
Tel : +33 (0) 178 945 552
fge@one2team.com
40 avenue Raymond Poincar=E9
75116 Paris
