From: Felipe Micaroni Lalli <micaroni@walltime.info>
Subject: Re: Git feature request: mark a commit as minor
Date: Sat, 3 Oct 2015 16:52:45 -0300
Organization: Walltime
Message-ID: <5610320D.30806@walltime.info>
References: <560EF966.3000501@walltime.info>
 <20151003181222.GA2024@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gk0GtqleQ25bCHTd96hqsmQKsJX3iIGSL"
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 21:52:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiSrW-0002Mb-Ha
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 21:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbbJCTwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 15:52:50 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35338 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbbJCTwt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 15:52:49 -0400
Received: by qkap81 with SMTP id p81so56029365qka.2
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 12:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type;
        bh=X3OArK7UWh4BDzyiVWGwVH7Yier0znGJaEWzUauLPbY=;
        b=kv2E7JG/JzvviomlTvdtnANjzzDf3UMIo/vsUXaJqePPvWV9VbrIHk1CwArpMPBTT8
         BGMu11osVhfaPrmgCSOVEIEjYoZy+90Rh/kRtF9gMoonuKHPnXuu25UQnrfa6L+16bcx
         /4cQj5pvlPItzeN5+ny6EUWHmtqcJTSHot+W4KyBPQSu9zC7jP47h5Cn3fmMzczWiOxQ
         nHIoGDNg75XRGTmHYXDLSio8VJVVebUUDX1tRO1AJxrvOAGbWWRaFTx5OPTawxmWYZjd
         RGOTj3ToE6plmgrdrV6Fk2issW6saq1TfbC0xdlOCao5L4UBDfhXqFLDukUy4akvMwiX
         3mDA==
X-Gm-Message-State: ALoCoQmuj1thBA0I22T+3qS30Fg+XAscuDTTMEiywaSfzjNSDDAcOfnAqMzQZtFATsL+PjALnUHJ
X-Received: by 10.55.21.144 with SMTP id 16mr9251755qkv.28.1443901968472;
        Sat, 03 Oct 2015 12:52:48 -0700 (PDT)
Received: from [192.168.1.56] ([179.110.8.33])
        by smtp.googlemail.com with ESMTPSA id a73sm7485634qkj.27.2015.10.03.12.52.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Oct 2015 12:52:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <20151003181222.GA2024@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278984>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gk0GtqleQ25bCHTd96hqsmQKsJX3iIGSL
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

You are right. It could be useful to fix old commits (already pushed)
but it could encourage bad practices. Minor changes should be avoided,
it is an exception, not a rule.

Thank you Fredrik.


On 03/10/2015 15:12, Fredrik Gustafsson wrote:
> On Fri, Oct 02, 2015 at 06:38:46PM -0300, Felipe Micaroni Lalli wrote:
>> A minor change (also called "cosmetic") usually is a typo fix, doc
>> improvement, a little code refactoring that don't change the behavior =
etc.
>>
>> In Wikipedia we can mark an edition as "minor".
>>
>> It would be nice to have an argument like "--minor" in git-commit to
>> mark the commit as minor. Also, filter in git-log (like --hide-minor) =
to
>> hide the minor changes. The git-log could be optimized to show minor
>> commits more discreetly.
>=20
> I can see your problem and implement your suggest is a solution that
> would work. However since this is a common problem, git already has a
> solution, that is the interactive rebase.
>=20
> You can read a discussion about when to use merge and rebase here:
> http://www.mail-archive.com/dri-devel@lists.sourceforge.net/msg39091.ht=
ml
>=20
> This work method make the "minor" commits to go away. There shouldn't b=
e
> any minor, or "fixup" commits in your history (of course there's
> exception).
>=20
> Minor things should be caught in your code review process and then
> fixed, rebased and the merged again.
>=20
> Or do I miss a usecase here?
>=20


--gk0GtqleQ25bCHTd96hqsmQKsJX3iIGSL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWEDINAAoJEEwK/M/tXN4UNGwP/AnHq8owqCMBjZBDeA1AAqRg
1Usq6f5SkwtGa0uAiCGE8uTDPf7oyX0u27w10alhgcVgh7OuR0K5/E1mb19I8koF
uiD68XNUEeOlf4Lg7L63ZagcWGKmhJegat1S9FmBRbQzBKqZdFte0OANxT5WKt++
TE+ncG2G6kirlERczYhUQYP68qEaP4rUnTydgUUYpgcqB6tr0H5DBIDq/xs/oZCS
bEZOMzrYS0jOxGyrp7wyUY5sfuYo3hdiww/hJan9peQKBwq9vTcAPe4lSGTdwKiQ
U/Wpvu5riZOM08iPoBUnEXanAFa9tAhgVkiOi1ZRxgx7mYLG5BYKE8TPFvyAEsYL
ZlHX4A15fU8ALI6Q3ehfifYd4x6VjI2B6Ox/7rwGjvV0qf4jhtZ+hEECloOfiPo2
x2j68DJ+sUYuQNSirkWpCTF8lDJoF121bsEncaBCW9nUxIYKQQv2a8TaR3VZPA90
Lod1tL5M8xvSnNyle4Wvoh3rZYdkPHCIrkXXuBar91CSHqEu3GnPdmx64/xjNEV7
hmYmekIx/Ua8AKBqOszX4LzBslJBeNoHW00oCY1/PJLifFsK9mqiZENvvED5wC9Z
i6gPTCEQJ0R7snnE04s28km97Q+57rYL0Mz9AyRY3Hev2cfexkHI5NhUp22WY89b
KaXTMHjdLzeb5fuvCxW1
=bMlR
-----END PGP SIGNATURE-----

--gk0GtqleQ25bCHTd96hqsmQKsJX3iIGSL--
