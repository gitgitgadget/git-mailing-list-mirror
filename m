From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Generic filters for git archive?
Date: Wed, 09 Dec 2009 23:48:37 +0100
Message-ID: <4B202945.50200@lsrfire.ath.cx>
References: <f9d2a5e10912071706m10ed7112ob7db47cdfac510d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 23:48:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIVL7-0004JV-4G
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 23:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758520AbZLIWsp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 17:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758507AbZLIWsp
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 17:48:45 -0500
Received: from india601.server4you.de ([85.25.151.105]:46064 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758429AbZLIWsp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 17:48:45 -0500
Received: from [10.0.1.101] (p57B7F921.dip.t-dialin.net [87.183.249.33])
	by india601.server4you.de (Postfix) with ESMTPSA id EB0002F80B4;
	Wed,  9 Dec 2009 23:48:44 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <f9d2a5e10912071706m10ed7112ob7db47cdfac510d6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135004>

Am 08.12.2009 02:06, schrieb Russ Dill:
> I'm trying to add copyright headers to my source files as they are
> exported via git archive. eg:
>=20
> * $Copyright$
>=20
> to
>=20
>  * Copyright (c) 2003-2009 by Foo Bar
>  *
>  * This program is free software; you can redistribute it and/or modi=
fy it
>  * under the terms of the GNU General Public License as published by =
the
>  * Free Software Foundation; either version 2 of the License, or (at =
your
>  * option) any later version.
>  *
>  * This program is distributed in the hope that it will be useful, bu=
t
>  * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHAN=
TABILITY
>  * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public L=
icense
>  * for more details.
>  *
>  * You should have received a copy of the GNU General Public License
>  * along with this program; if not, write to the Free Software Founda=
tion,
>  * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>=20
> And properly handling things like '# $Copyright$', '// $Copyright$',
> etc. I have a sed script that does this, but no way to apply it to th=
e
> output of git archive. I tried setting up a smudge filter that would
> only smudge output on archive exports, but it doesn't appear that the
> smudge filters get run on git archive.
>=20
> I am currently running 1.6.3.3

Is the filter attribute contained in a .gitattribute file that's part o=
f
the tree you are trying to export?  If it's only in the worktree copy,
then you need to use the option --worktree-attributes to make git
archive use it.

Ren=C3=A9
