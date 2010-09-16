From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 2/2] Add Swedish translation.
Date: Thu, 16 Sep 2010 12:23:54 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1009161209500.18826@ds9.cixit.se>
References: <20100912202111.B11522FC00@perkele> <alpine.DEB.2.00.1009151124100.11791@ds9.cixit.se> <A612847CFE53224C91B23E3A5B48BAC749BFA3D12C@xmail3.se.axis.com> <201009160046.47367.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Git <git@vger.kernel.org>, Swedish <tp-sv@listor.tp-sv.se>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 13:24:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwCZk-000694-CQ
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 13:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266Ab0IPLYJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 07:24:09 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:58706 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751818Ab0IPLYI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 07:24:08 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o8GBNsnJ029992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 16 Sep 2010 13:23:54 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o8GBNsKP029988;
	Thu, 16 Sep 2010 13:23:54 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <201009160046.47367.robin.rosenberg@dewire.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 16 Sep 2010 13:23:54 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156319>

Robin Rosenberg:

>> Well, "en delvis incheckning" doesn't sound like correct Swedish...
> H=E5ller med. "delvis incheckning" =E4r inte svenska.

OK. Reluctantly changing to "partiell".

> (My comments are in swedish as it feels more natural in this context)=
=2E

While I do agree, I'm trying to reply in English since the Git list is =
in=20
English.

> Skriv om hel.
> 	Kunde inte bygga tr=E4det.

That does change the meaning. The original just reported that there was=
 an=20
error while building it, the rewritten says building it failed. I'm not=
 sure=20
there is actually any distinction here, but I'm trying to stick close t=
o the=20
original meaning of the message (even if it might be wrong).

> Dekorerade l=E5ter konstigt. "annoterade" eller "kommenterade" funkar=
=2E

Changed.

>>>>> +#: builtin/fetch.c:917
>>>>> +msgid "Fetching a group and specifying refspecs does not make se=
nse"
>>>>> +msgstr "Kan inte h=E4mta fr=E5n grupp och ange referensspecifika=
tioner"
> Ni byter mening. Den engelska texten antyder att det man f=F6rs=F6ker=
 inte kan=20
> fungera, medan =F6vers=E4ttningen betyder att operationen inte lyckad=
es den=20
> h=E4r g=E5ngen.
>
> "Det =E4r inte m=F6jligt att h=E4mta en grupp och samtidigt ange=20
> referensspecifikationer"

You are right, the translation can be misunderstood.

Shortening to "Det =E4r inte m=F6jligt att h=E4mta fr=E5n grupp och sam=
tidigt ange=20
ref.specifikationer" to fit in under 80 characters (now 79...).

> Jag lyfte medvetet bort idiotf=F6rklaringen av anv=E4ndaren.

Of course the user is an idiot, I mean, the program itself is a git, so=
 why=20
shouldn't the user be one too? :-)

>>>>> +#: builtin/grep.c:703
>>>>> +#, c-format
>>>>> +msgid "unable to grep from object of type %s"
>>>>> +msgstr "Kunde inte \"grep\" fr=E5n objekt av typen %s"
>>>> "\"grep\"" -> "greppa" ?
>>> That's a word that means something else... I don't really have any =
good
>>> idea on how to translate "grep" when used as a verb...
>> Yeah, I know... I've no better suggestion I'm afraid.
> Varf=F6r =E4ndra tempus?  s/Kunde/Kan/.

I read this as an understood "[The program was] unable to ...", and use=
 this=20
form for all translation of incomplete sentences starting with "unable"=
=2E

> "Kan inte utf=F6ra texts=F6kning i \"%s\"-objekt"

Changing to "Kunde inte utf=F6ra texts=F6kning (grep) fr=E5n objekt av =
typen %s"

> "tokigt v=E4rde f=F6r \"in-reply-to\""

Trying to keep it short, as I don't know how long the value is.

>>> "Trycka iv=E4g" sounds horrible, IMHO. I used "S=E4nd" in the git-g=
ui
>>> translation of "Push". As long as git doesn't grow a "git send"
>>> command, I think that should be OK.

> =D6vers=E4ttningarna i Git-gui =E4r prejudicerande f=F6r denna =F6ver=
s=E4ttning. Sen=20
> kanske de inte =E4r 100%-aga heller, men i s=E5 fall b=F6r b=E5de C G=
it och Git=20
> Gui =E4ndras.  Sen finns kanske ytterligare =F6vers=E4ttningar av and=
ra=20
> Git-verktyg. Personligen f=F6redrar jag nog Skicka.  Absolut inte try=
cka.

Since I have done all the three translations (git-gui, gitk, git) I can=
=20
easily fix it in all once everyone agrees. Until then I stick with what=
 I=20
have. :-)

> Myndigheternas Skrivregler. Svenska Akademien anv=E4nder "t.ex." p=E5=
 webben i
> alla fall (utan blank).

Adding the extra "."; found out I do have space for it after all.

>>>>> +#, c-format
>>>>> +msgid "Missing author: %s"
>>>>> +msgstr "Saknad f=F6rfattare: %s"

> Usch.
> "F=F6rfattare saknas i: %s"

=46ixed.

> Tag =3D etikett

While I do agree, I have never heard anyone use "etikett" for a tag in =
the=20
computer science sense (neither a HTML tag nor a VCS tag). While "tagg"=
 is=20
obviously horrible, I do use it in the translations simply because that=
 is=20
what everyone else is using.

--=20
\\// Peter - http://www.softwolves.pp.se/
