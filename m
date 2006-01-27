From: Mathieu Chouquet-Stringer <ml2news@free.fr>
Subject: Re: How to create and keep up to date a naked/bare repository?
Date: 27 Jan 2006 14:34:28 +0100
Organization: Uh?
Message-ID: <m34q3p7q1n.fsf@localhost.localdomain>
References: <7v1wyvn9pc.fsf@assigned-by-dhcp.cox.net>
	<7vd5ie735a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 27 14:35:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2Tks-0005hm-Fg
	for gcvg-git@gmane.org; Fri, 27 Jan 2006 14:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWA0NfH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 27 Jan 2006 08:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWA0NfH
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jan 2006 08:35:07 -0500
Received: from AMarseille-252-1-15-107.w83-197.abo.wanadoo.fr ([83.197.214.107]:37089
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750890AbWA0NfG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2006 08:35:06 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.5/8.13.5) with ESMTP id k0RDYWUj018365;
	Fri, 27 Jan 2006 14:34:32 +0100
Received: (from mchouque@localhost)
	by localhost.localdomain (8.13.5/8.13.5/Submit) id k0RDYSZP018362;
	Fri, 27 Jan 2006 14:34:28 +0100
X-Authentication-Warning: localhost.localdomain: mchouque set sender to ml2news@free.fr using -f
To: junkio@cox.net (Junio C Hamano)
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
In-Reply-To: <7vd5ie735a.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15181>

Thanks and sorry for making you write this long message...

junkio@cox.net (Junio C Hamano) writes:
> [...]
>  - A mirror of somebody else's work.
>=20
>    I suspect this is what you are doing.  Instead of individual
>    developers pulling directly from upstream, you would want to
>    fetch and update the bare cloned repository and have your
>    developers fetch from it.

Correct.
=20
> Let's outline how.
>=20
> What I would suggest is to arrange things like this:
>=20
>    +-------------------------------------------+
>    | Your upstream repository                  |
>    | git://git.kernel.org/pub/scm/git/git.git/ |
>    +-------------------------------------------+=20
>       |                                      ^
>       | (1)                                  | (5)
>       |                                      |
>       v                                      |
>    +-----------------+                     +----------------+
>    | Your central    |        (4)          | My development |
>    | bare repository |-------------------->| tree           |
>    +-----------------+                     +----------------+
>       |      ^
>       | (2)  | (3)
>       |      |
>       v      |
>    +------------------+
>    | Your developers' |+
>    | trees            ||+
>    +------------------+||
>      +-----------------+|
>       +-----------------+
> [...]
> Does this make sense now?

It totally does. I guess this email could end up in the Documentation
folder in some way!?

--=20
Mathieu Chouquet-Stringer
    "Le disparu, si l'on v=E9n=E8re sa m=E9moire, est plus pr=E9sent et
                 plus puissant que le vivant".
           -- Antoine de Saint-Exup=E9ry, Citadelle --
