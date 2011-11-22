From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: Feature requset: listing of current stash in git gui
Date: Tue, 22 Nov 2011 16:19:14 +0100
Message-ID: <4ECBBD72.40101@atlas-elektronik.com>
References: <201111211100.52367.dexen.devries@gmail.com> <4ECA2D8F.4060005@atlas-elektronik.com> <30417194.1411.1321907485839.JavaMail.mobile-sync@ieja14> <-8099236111493298698@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dexen deVries <dexen.devries@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 16:19:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSs7y-0000SP-Ja
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 16:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867Ab1KVPTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Nov 2011 10:19:13 -0500
Received: from mail96.atlas.de ([194.156.172.86]:21913 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716Ab1KVPTN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 10:19:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id E27DA10074;
	Tue, 22 Nov 2011 16:19:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id eq6l65BK8iO6; Tue, 22 Nov 2011 16:19:11 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Tue, 22 Nov 2011 16:19:11 +0100 (CET)
Received: from [141.200.19.108] (as112671.atlas.de [141.200.19.108])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 3FC622718D;
	Tue, 22 Nov 2011 16:19:11 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <-8099236111493298698@unknownmsgid>
X-Enigmail-Version: 1.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185796>

Am 22.11.2011 11:24, schrieb David Aguilar:
> On Nov 21, 2011, at 4:41 AM, dexen deVries <dexen.devries@gmail.com> =
wrote:
>=20
>> On Monday 21 of November 2011 11:53:03 Stefan N=C3=A4we wrote:
>>> You can simply put the following in your ~/.gitconfig:
>>>
>>> [guitool "Stash/show"]
>>>    cmd =3D git stash show -p
>>> [guitool "Stash/list"]
>>>    cmd =3D git stash list
>>> [guitool "Stash/pop"]
>>>    cmd =3D git stash pop
>>> [guitool "Stash/drop"]
>>>    cmd =3D git stash drop
>>>    confirm =3D yes
>>
>> that's nice, but doesn't list visually the stashed changes. I'd rath=
er have a
>> listing similar to Unstanged Changes / Staged Changes, with ability =
to view
>> line-by-line diff just like for Changes.
>=20
> [blatant plug]
>=20
> git-cola has this feature.
>>
>=20
>    http://git-cola.github.com/

Yeah, right. I totally forgot about git cola.

But I guess there's no way of starting only the stash view like the 'DA=
G'=20
view, is there ?

Stefan
--=20
----------------------------------------------------------------
/dev/random says: This is a Tagline mirror><rorrim enilgaT a si sihT
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"
