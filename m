From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: use git-daemon by git://IP/path?
Date: Fri, 12 Jun 2009 16:41:01 +0200
Message-ID: <4A3268FD.7000004@dirk.my1.cc>
References: <200906121213.13365.Karlis.Repsons@gmail.com> <4A325E00.6050504@dirk.my1.cc> <20090612141602.GB14628@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>,
	Ka-rlis Repsons <karlis.repsons@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 12 16:41:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF7wT-0000dV-Iy
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 16:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757985AbZFLOlF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 10:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755667AbZFLOlD
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 10:41:03 -0400
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:57163 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402AbZFLOlC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 10:41:02 -0400
Received: from [84.176.67.51] (helo=[192.168.2.100])
	by smtprelay09.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1MF7wr-0005iO-D2; Fri, 12 Jun 2009 16:41:42 +0200
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090612141602.GB14628@coredump.intra.peff.net>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121426>

Am 12.06.2009 16:16 schrieb Jeff King:
> On Fri, Jun 12, 2009 at 03:54:08PM +0200, Dirk S=C3=BCsserott wrote:
>=20
>>> Also, in general, how can it be set up, that >1 people have a write=
=20
>>> access to the same repository? Only by using the same login?=20
>> Have a look at the "--shared" option of "git init". That's supposed =
to =20
>=20
> I have also had good experiences with POSIX ACLs for sharing
> repositories:
>=20
>   setfacl -R -m d:u:$user:rwX -m u:$user:rwX /path/to/repo
>=20
> which gets rid of dealing with group management.  Of course your
> filesystem has to support them. :)

That's the best way, of course. We use it at work to have 'release'
repositories where only a dedicated maintainer and his deputy can
push to. Our developers push to their 'public' repos and the maintainer
then pulls their changes and pushes them to 'release' -- just like Juni=
o=20
does here :-)

     Dirk
