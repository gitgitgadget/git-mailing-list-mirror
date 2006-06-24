From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Patch] trap: exit: invalid signal specification
Date: Fri, 23 Jun 2006 19:50:07 -0700
Message-ID: <7vejxf5ktc.fsf@assigned-by-dhcp.cox.net>
References: <200606240410.18334.caglar@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 04:50:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtyDv-0008N8-Jo
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 04:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933204AbWFXCuL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 23 Jun 2006 22:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933206AbWFXCuL
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 22:50:11 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:50314 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S933204AbWFXCuJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 22:50:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624025008.UTMN19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 22:50:08 -0400
To: caglar@pardus.org.tr
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22480>

> diff -ur git-1.4.0.orig/git-clone.sh git-1.4.0/git-clone.sh
> --- git-1.4.0.orig/git-clone.sh=A02006-06-10 22:41:54.000000000 +0300
> +++ git-1.4.0/git-clone.sh=A0=A0=A0=A0=A0=A02006-06-24 03:54:49.00000=
0000 +0300
> @@ -205,7 +205,7 @@
> =A0[ -e "$dir" ] && echo "$dir already exists." && usage
> =A0mkdir -p "$dir" &&
> =A0D=3D$(cd "$dir" && pwd) &&
> -trap 'err=3D$?; cd ..; rm -r "$D"; exit $err' 0
> +trap 'err=3D$?; cd ..; rm -r "$D"; EXIT $err' 0
> =A0case "$bare" in
> =A0yes)

I am not quite sure what to make out this...  Do you mean your
shell does not like the command "exit" spelled in lowercase
under Turkic locale?
