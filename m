From: Mathieu Chouquet-Stringer <ml2news@free.fr>
Subject: Re: How to create and keep up to date a naked/bare repository?
Date: 26 Jan 2006 19:27:30 +0100
Organization: Uh?
Message-ID: <m34q3q9759.fsf@localhost.localdomain>
References: <7v1wyvn9pc.fsf@assigned-by-dhcp.cox.net>
	<7v64o7fac1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 19:28:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2BqY-0003x3-VP
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 19:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWAZS1t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 26 Jan 2006 13:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWAZS1t
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 13:27:49 -0500
Received: from AMarseille-252-1-93-193.w86-202.abo.wanadoo.fr ([86.202.148.193]:27874
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S932395AbWAZS1s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 13:27:48 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.5/8.13.5) with ESMTP id k0QIRWcL000967;
	Thu, 26 Jan 2006 19:27:32 +0100
Received: (from mchouque@localhost)
	by localhost.localdomain (8.13.5/8.13.5/Submit) id k0QIRV0O000964;
	Thu, 26 Jan 2006 19:27:31 +0100
X-Authentication-Warning: localhost.localdomain: mchouque set sender to ml2news@free.fr using -f
To: junkio@cox.net (Junio C Hamano)
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
In-Reply-To: <7v64o7fac1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15171>

junkio@cox.net (Junio C Hamano) writes:
> It sounds like you are not telling fetch to update the refs you
> track from outside.  Perhaps, this may help (untested):
>=20
> 	$ GIT_DIR=3D/pub/scm/git/git.git git fetch \
>         	--update-head-ok $remote master:master

I guess I'm a little bit confused here as I'm not quite sure what I'm
trying to accomplish...

Here's what I ran:
% GIT_DIR=3D. git fetch \
--update-head-ok git://www.kernel.org/pub/scm/git/git master:master

Isn't git supposed to fetch master:origin as my remotes/origin file
contains (I actually tried both and refs/heads/origin and refs/heads/ma=
ster
have the same value):

URL: git://www.kernel.org/pub/scm/git/git.git
Pull: master:origin
Pull: todo:todo
Pull: html:html
Pull: maint:maint
Pull: man:man
Pull: pu:pu

So it knows about the repository and the ref spec so all I need would b=
e
the --update-head-ok flag then, no?

--=20
Mathieu Chouquet-Stringer
    "Le disparu, si l'on v=E9n=E8re sa m=E9moire, est plus pr=E9sent et
                 plus puissant que le vivant".
           -- Antoine de Saint-Exup=E9ry, Citadelle --
