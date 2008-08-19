From: Marcus Griep <neoeinstein@gmail.com>
Subject: Re: Dumb "continuous" commit dumb question
Date: Tue, 19 Aug 2008 00:13:39 -0400
Message-ID: <48AA4873.4040107@gmail.com>
References: <48AA4263.8090606@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig28A65A68ADC33B576C21962C"
Cc: git@vger.kernel.org
To: Pat LeSmithe <qed777@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 06:15:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVIck-0002SE-3S
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 06:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbYHSENz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 00:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbYHSENy
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 00:13:54 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:59522 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbYHSENx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 00:13:53 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2382802wri.5
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 21:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type;
        bh=dCmk8dXZah0OF1J/fQtKw0VnA0NE+WW9e9KHlLpLQ2o=;
        b=NARb7GFrNv9NNDytCeMqzdhe8xh9/rOqrxV9Ck8EKoyOUQqLACuD8Ntx+T3KTNMRwB
         WqBOsncTVix2/dMAFTn0psC8WXMcuJhDwam75jm/zexhewkh6f9yEYWBnvQgrihyHGn9
         kwXhGRBqdjboHpQnsGSQ03++1Njt85+yl/vWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        b=YaG6ce6rps4XhA4pboRBttMsXwcn6XGcBqr8wj3mkoPqKLh1T16xGw0DBCoRNacJ1j
         GVzMR3voVGzNCUndhV/61VwXpgvr6GoyRKQduqY1+8yVXWt98+HXhmDVWeAyugLTndSc
         zAepqUO51vKRy/Q5kfbc3k2A50X+CZjlJ1RsU=
Received: by 10.90.71.15 with SMTP id t15mr6800724aga.14.1219119232622;
        Mon, 18 Aug 2008 21:13:52 -0700 (PDT)
Received: from ?192.168.1.3? ( [71.174.65.78])
        by mx.google.com with ESMTPS id 7sm2666997agc.14.2008.08.18.21.13.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 21:13:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <48AA4263.8090606@gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92811>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig28A65A68ADC33B576C21962C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Pat LeSmithe wrote:
> Hello,
>=20
> Is it possible to enable git to automatically and continuously "softly"=

> commit or stage *all* changes to a [subset of] files in a repository,
> without my intervention, as they happen?  Perhaps via a daemon which
> monitors the disk for explicit file-saving?

Perhaps with a cron job running a script every minute or so.  You'd want
to verify that changes actually took place before attempting a commit.
Also, what log messages would you be providing?  Log messages can be
very important to the context of a change and the ability to later find
them.

If you're using a specific application, such as a Wiki, it may work
nicely, as log messages can be easily gleaned, and many offer post-edit
hooks that you could use to invoke git.

> Of course, I would still be able to perform explicit commits (with
> descriptive comments) and other git commands, in which case there
> probably should be smart handling of the recent soft history.  For
> example, it could simply be discarded.

You may want to use StGit as that may allow you to make such lightweight
commits easily while still allowing reordering, etc., though I am not
familiar with that application porcelain.

> I understand that I could simply remember to commit and/or branch early=

> and often.  But given that changes by an individual on a given branch
> are well-ordered by time, and that the "continuous" operation may be
> cheap in many situations, a "live" journal could be useful.
>=20
> Perhaps a better term is branch-aware undo or git with microstructure.

Obviously, my final caution is that while this is possible with some
configuration, you may lose valuable "signal" information in the "noise" =
of
commits that such a continuous operation might incur.  This low SNR may
make it more difficult to find and revert changes you didn't actually wan=
t
to happen or to glean a meaningful history of your working tree.

While in the operable borders of Git, it's outside the normal usage patte=
rns.
If you have success, let us know how it worked for you.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4


--------------enig28A65A68ADC33B576C21962C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIVAwUBSKpIfQPFruyc22R/AQIeMxAAufGw2V385ejgTZBS06sEUGZEd6axhc3i
weqlj+cveKKSaYAWz43shYe4pXJ+QTO6KRZQdMOleSmEYa2X3n/ixZTGmFWvOFxt
CPD63nT9vAxBr3hm29D5ikzopM7VfVtjz1cGCSa+4PUen0gn7JQo/egUE1j3JV1k
AhEvucDrZY9vhR2RdXCkuTN/kp4q1NQ6xauzBR8O6sh7kI6B1e9R9GbS7rxW8xjx
kIEwmE+mMy/KG7rFvUR57z9LoeH9Me549lIJp5ZTOC/EsAltMShdJiXjVmFxquJY
0xpZyO3nTIqrgTjASd5PDJvu1AuvzIcfsqh3Usm19QWqxFl7lrzm611e3OT5rGEr
fVtBOft6adkEmXgNEMEOTTlCsCYBix3/N1j20wxBIoS4ulERAqXtYZE6T68/54+y
9cA/QAoe+9agZeQER17vGdciNmVmJCdKvnLrCJIvwe2KJ2CwmnLz5r0OY50vUKGQ
TkPbKqssvtdfZHLZUZc+WPhd9fifIw2G4j/BEym3nm1ewkg+u9TN9NrpSvqFDOxQ
33fSo/nlV95gIQGj8ucVaBtTBcV0KATcP5Auf2jTsI4Xo8vo7SguX+O0iEMt0970
dzhDJYMCfN/ZBeulpmTqwHT2CVqPMWsHwRG95J3MVfjEcPqqQIcY4jM93qEjLjoU
bXZvHADiE6M=
=lzJY
-----END PGP SIGNATURE-----

--------------enig28A65A68ADC33B576C21962C--
