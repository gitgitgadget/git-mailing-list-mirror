From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: building git on Solaris
Date: Wed, 08 Sep 2010 10:16:54 -0500
Message-ID: <nMrBbfBjISeakrCCpr3u3goqKMFMLUPCXiAa8ohZrHAmY1k660aYdA@cipher.nrlssc.navy.mil>
References: <4C86A86B.1030107@bio.umass.edu> <AANLkTikvy-wUB-RFLegp7KJa_srqh97nLC03bdZDmru=@mail.gmail.com> <4C87A1DF.1020706@bio.umass.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Chris Hoogendyk <hoogendyk@bio.umass.edu>
X-From: git-owner@vger.kernel.org Wed Sep 08 17:17:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtMOZ-0004nF-U8
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 17:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839Ab0IHPRB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 11:17:01 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37265 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab0IHPRA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 11:17:00 -0400
Received: by mail.nrlssc.navy.mil id o88FGtFM008168; Wed, 8 Sep 2010 10:16:55 -0500
In-Reply-To: <4C87A1DF.1020706@bio.umass.edu>
X-OriginalArrivalTime: 08 Sep 2010 15:16:55.0085 (UTC) FILETIME=[DF3F45D0:01CB4F68]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155793>

On 09/08/2010 09:46 AM, Chris Hoogendyk wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Sep 7, 2010 at 21:02, Chris Hoogendyk <hoogendyk@bio.umass.e=
du> wrote:
>> =20
>>> Does anyone have any guidance or clues as to where I should look fr=
om here?
>>> Or how to fix this?
>>>    =20
>>
>> Call make as gmake?
>=20
> magical.
>=20
> I did an `ln -s /usr/local/bin/make /usr/local/bin/gmake` and then re=
ferenced gmake rather than make. For some reason, that got over the hum=
p. I have no clue why calling make would initially work and later in th=
e process revert to /usr/ccs/bin/make, but calling the same code via th=
e symlink name gmake works.
>=20
> Anyway, now I'm in the normal build debugging mode. Got all the way t=
hrough to building the Documentation, at which stage I now need to get =
asciidoc and python. I don't really like bloating my minimal server sys=
tems with python, but it seems I'm finally stuck, since I have faculty =
who really want to use git.
>=20
> Thanks for the clue.

There is a quick-install-doc make target.

It extracts prebuilt documentation from a branch named origin/man
in your repository.  Junio keeps this up-to-date with the
Documentation on master.  You can use it instead of trying to build
the documentation from scratch.

-Brandon
