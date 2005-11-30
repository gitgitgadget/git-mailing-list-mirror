From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] SVN import: Use one log call
Date: Wed, 30 Nov 2005 03:46:10 +0100
Message-ID: <20051130024610.GX20418@kiste.smurf.noris.de>
References: <pan.2005.11.29.07.13.02.145977@smurf.noris.de> <7vhd9vdx1o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 03:47:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhI0D-0004qR-Im
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 03:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVK3CrX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 29 Nov 2005 21:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVK3CrX
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 21:47:23 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:26295 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1750815AbVK3CrW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 21:47:22 -0500
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EhHz2-00031b-4w; Wed, 30 Nov 2005 03:46:48 +0100
Received: (nullmailer pid 1231 invoked by uid 501);
	Wed, 30 Nov 2005 02:46:11 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd9vdx1o.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12981>

Hi,

Junio C Hamano:
> $ git svnimport -v -i -t photocat http://127.0.0.1/svn/private main/s=
ources
> ...
> 1500: Unrecognized path: /main/sources/photocat/db/catalog.sql

Hmmm, "git-svnimport -T main/sources" should work. Somewhat.

>>/
>>   utils/
>>      calc/
>>         trunk/
>>         tags/
>>         branches/
>>      calendar/
>>         trunk/
>>         tags/
>>         branches/
>>      =E2=80=A6

>                                       but I wonder if we want to
> support importing from "utils" level.
>=20
That'd require somewhat more flexible support for reordering the
repository path elements than we have now, I'm afraid, thus the answer
to that particular question is "import both separately, then merge
into a common git repo if you really need to". We *can* do that, after
all. ;-)

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.nor=
is.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.nor=
is.de
 - -
You goddamn cornhuskers are all alike.
					-- Jim Thompson
