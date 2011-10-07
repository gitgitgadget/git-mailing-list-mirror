From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] po/pl.po: Eliminate fuzzy translations
Date: Sat, 8 Oct 2011 00:11:14 +0200
Message-ID: <201110080011.14757.jnareb@gmail.com>
References: <CACBZZX4dP-OsrZ3wBOeSkzDFy6XBgeY=eqJUF2acyLC8W-3Vpg@mail.gmail.com> <201110032337.09975.jnareb@gmail.com> <4E8AC294.2060608@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>,
	Marcin =?utf-8?q?Cie=C5=9Blak?= <saper@saper.info>
To: Zbigniew =?utf-8?q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Sat Oct 08 00:11:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCIdV-0008UP-49
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 00:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758659Ab1JGWLQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 18:11:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46229 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364Ab1JGWLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 18:11:16 -0400
Received: by bkbzt4 with SMTP id zt4so5326060bkb.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 15:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=HSoLvW9qg3vSjdmizrPVEOK7udH9mbTHPEiWsv5E9dU=;
        b=TtDRXhftyzG7jEAf2qDsQ03MEhJsXLaCAfZcL9Urlt9eyPTykqGqYPuychZ54Eg+LX
         ECTI5GRStTv5qlfpAVMIJ9ofqG2m8YWiq8eToiuj3qYgWd4fxJy35ASdcJ6uPszTdazC
         VRnWCPmCAH/rRDsyEYBlMpNmOo5UhSIsvEJgw=
Received: by 10.223.62.19 with SMTP id v19mr13410480fah.27.1318025474759;
        Fri, 07 Oct 2011 15:11:14 -0700 (PDT)
Received: from [192.168.1.13] (abrz200.neoplus.adsl.tpnet.pl. [83.8.119.200])
        by mx.google.com with ESMTPS id n1sm14845679fad.20.2011.10.07.15.11.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Oct 2011 15:11:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4E8AC294.2060608@in.waw.pl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183116>

On Tue, 4 Oct 2011, Zbigniew J=C4=99drzejewski-Szmek wrote:
> On 10/03/2011 11:37 PM, Jakub Narebski wrote:
>>
>> +# Terminologia dla kluczowych termin=C3=B3w z Subversion:

As I probably should write in the commit message, this terminology
is taken directly from Subversion's po/pl.po file.  Subversion has
IMHO quite good Polish translation.

On the other hand no other *.po file in Git has glossary in
comments...

>> +# path - =C5=9Bcie=C5=BCka
>> +# URL - URL
>> +# file - plik
>> +# directory - katalog
>> +# update - aktualizacja
>> +# commit - zatwierdzenie, zatwierdzenie zmian
>
> This seems kind of awkward. E.g. 'initial commit' would become=20
> 'pocz=C4=85tkowe zatwierdzenie zmian' or 'pierwsze zatwierdzenie', wh=
ich just=20
> doesn't sound right. What about starting with the mercurial term=20
> 'changeset'? Git users also use 'commit' to mean 'change', so maybe
> the polish translation of this crucial term should be 'zmiana':
> 'initial commit' -- 'pocz=C4=85tkowa zmiana' or 'pierwsza zmiana'
> 'commit message' -- 'opis zmiany'

The problem is that "commit" might be a verb ('to commit'), where I thi=
nk
"zatwierdzenie zmian" is a good translation, and "commit" might also be
used as a noun ('a commit'), where I think it should be probably transl=
ated
as "wersja" (eng. version) or "zmiana" (eng. change).

Nb. it is a good idea to take into account existing Mercurial translati=
on
into Polish.
=20
>> +# version control - zarz=C4=85dzanie wersjami
>> +# repository - repozytorium
>> +# branch - odga=C5=82=C4=99zienie
>
> 'ga=C5=82=C4=85=C5=BA'? I think that's the translation which is used =
in informal=20
> conversations.

"Odga=C5=82=C4=99zienie" is what Subversion uses, but you are right tha=
t "ga=C5=82=C4=85=C5=BA"
might be better.  Though in this case the glossary cannot be marked
as coming from Subversion...
=20
>> +# tag - tag
>
> 'metka', 'etykieta' according to the dictionary. I'm aware of 'metka'
> being used in CS anywhere, but it is short, and pretty cool, IMO.

I think that "etykieta" (eng. label) has already established different
meaning in Polish computer terminology for a "goto label".

"Metka" might be a good solution (it is mainly used in Polish to mean
textile labels), though I wonder if using English term "tag" (which
in Polish is used in computer science to mean metadata tag or markup
language tag) wouldn't be better as it is already computer term.
=20
>> +# merge - =C5=82=C4=85czenie zmian
>
> '=C5=82=C4=85czenie ga=C5=82=C4=99zi'?

Well, in Subversion it is about merging changes, not branches ;-)))
=20
>> +# conflict - konflikt
>> +# property - atrybut
>> +# revision - wersja
>> +# log message - opis zmian
>> +# entry/item - element
>> +# ancestry - pochodzenie
>> +# ancestor - przodek
>> +# working copy - kopia robocza
>> +# working dir - bie=C5=BC=C4=85cy katalog
>> +# usage - wykorzystanie
>
> 'u=C5=BCycie', 'wywo=C5=82anie'?
> E.g. 'standardowe wywo=C5=82anie tego programu to: prog arg'

I'd have to check how other programs translate this.  I think
at least "usage: " in '-h' output is translated as "u=C5=BCycie: ",
though I am not sure if it is really a good translation to recommend.
=20
>> +# source - =C5=BAr=C3=B3d=C5=82owy
>> +# destination - docelowy
>> +# hook - skrypt (skrypt repozytorium)
>> +# exclude - wykluczy=C4=87
>> +# crop - obci=C4=85=C4=87
>> +# cache - pami=C4=99=C4=87 podr=C4=99czna
>> +# child - obiekt podrz=C4=99dny
>
> Standard CS term is 'ojciec' and 'syn' for 'parent/child'.

Right.
=20
>> +# obliteration - obliteracja
>
> 'wymazanie'?

Well, anyway I don't think this is needed for git translation.
=20
>> +# patch - =C5=82ata
>> +# notes - adnotacja

--=20
Jakub Narebski
Poland
