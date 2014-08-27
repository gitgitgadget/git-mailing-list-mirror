From: Oliver Busch <oliver.busch@arc-aachen.de>
Subject: Re: Bug report: Author/Commit date in ISO 8601 format
Date: Wed, 27 Aug 2014 09:15:27 +0200
Message-ID: <53FD858F.7050409@arc-aachen.de>
References: <53FC3768.3090905@arc-aachen.de>	<20140826130610.GG29180@peff.net>	<53FC894F.9060402@arc-aachen.de>	<20140826133326.GA30887@peff.net>	<F8DE5B94F596455FA56956B8A865EC73@black>	<20140826142203.GA31205@peff.net> <CANgJU+UifjMJPcmC28-SrZOEUR45qQQfdM_rf-HHtkfBAMEyRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 09:15:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMXSE-0008Aw-Hk
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 09:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbaH0HPe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2014 03:15:34 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54735 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbaH0HPd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 03:15:33 -0400
Received: from [192.168.43.193] ([194.8.202.70])
	by mrelayeu.kundenserver.de (node=mreue001) with ESMTP (Nemesis)
	id 0MKhTL-1XLi6T1lUF-001z20; Wed, 27 Aug 2014 09:15:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <CANgJU+UifjMJPcmC28-SrZOEUR45qQQfdM_rf-HHtkfBAMEyRw@mail.gmail.com>
X-Provags-ID: V02:K0:FauGoFrIj4zxg7sxwWnDjYsIS2HDoO/fzls0jJSpLVN
 vJfnKtPrnbuvbVKU7i8QxgHaX9ScdJP5yCUTuLPn/iuqoza1ER
 a2qD8lcVhiM+U83RxcuyXTPM8ky37V5WHQNj70wJmBo2eFYRdS
 cc/78HW+Qxkf5vo/47a6wZks70l9bFMaz3/8CCpCHB2WTiwiHN
 +AVxoVtFs7L+QHVlMd142A/NuDqFyH3FmaXInjbJXoeKZrvxL0
 HP9NfcvHPA6wTUyHVn0IsM0LHs58u6ynpxkm859iWp6JPu3uN3
 J6/fqir8sh/m2NyYSGNXKVFuMS6K7DFniDAz2f4+NnVK3Csu4g
 xX9Tp4rdK/Vic4Iv15BUhymQH4u880T9rLbRCFtwa
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255981>

Am 26.08.2014 um 23:41 schrieb demerphq:
> On 26 August 2014 16:22, Jeff King <peff@peff.net=20
> <mailto:peff@peff.net>> wrote:
>
>     On Tue, Aug 26, 2014 at 10:10:33AM -0400, Jason Pyeron wrote:
>
>     > > But I am not sure that "omitted" means "can be replaced with =
a
>     space".
>     > > And while you can define "by mutual agreement" as "git define=
s the
>     > > format, so any consumers agree to it" that is not necessarily
>     > > useful to
>     > > somebody who wants to feed the result to an iso8601 parser
>     > > that does not
>     > > know or care about git (i.e., it shoves the conversion work
>     onto the
>     > > person in the middle).
>     >
>     > Omitted /T?/ does not mean replaced with another character.
>
>     I would agree. But that is the argument made in the thread I link=
ed
>     earlier.
>
>     I do not think there is much point in re-opening the argument, th=
ough.
>     Whatever git generates, changing the output would probably cause =
a lot
>     of pain.  We are likely better off adding a new, "real" iso8601 f=
ormat
>     option (we can even deprecate the old one, or slate it for switch=
ing,
>     but we would need a notification period).
>
>
> Just curious but when was last time anyone other than the OP in this=20
> thread saw an "iso" date/time stamp that had a "T"?
>
> I cant remember ever encountering such a system. I cant help but thin=
k=20
> the OP should just $git_date=3D~s/ /T/ and move on to more interestin=
g=20
> things. I doubt there is any real value in truly supporting the spec=20
> to the letter.  And the paucity of systems that do follow it makes me=
=20
> think that is what most people think too.
>
> Yves
>
>
> --=20
> perl -Mre=3Ddebug -e "/just|another|perl|hacker/"

I do not think that this is a matter of how often you or I see an ISO=20
date/time stamp with or without a "T". I agree that git's current outpu=
t=20
is the best solution for human readability, but it simply does not=20
comply with the standard it claims to be compliant with, which in terms=
=20
of machine readability IS a problem. Besides, it is not only the missin=
g=20
"T" (and I intentionally ignore the option of omitting it by mutual=20
agreement here), but also the space character between time and timezone=
=20
which should not be there and the missing colon in the timezone part.
And yes, I obviously can come around this issue by  refactoring the=20
string myself which is not a very hard task, but, as Jeff already=20
pointed out, this "shoves the conversion work onto the person in the=20
middle" which I consider simply bad style.

Oliver

PS: On a personal note - if you needed to create software to make a=20
living (as I do)  you would probably know that if one of your customers=
=20
is reporting a problem, telling him to use a workaround and "move on to=
=20
more interesting things" is considered bad style also. ;)

--=20

Oliver Busch, M.Eng.

Airport Research Center GmbH
Bismarckstra=C3=9Fe 61
52066 Aachen
Germany

Phone: +49 241 16843-161
=46ax: +49 241 16843-19
e-mail: Oliver.Busch@arc-aachen.de
Website: http://www.airport-consultants.com

Register Court: Amtsgericht Aachen HRB 7313
Ust-Id-No.: DE196450052

Managing Directors:
Dipl.-Ing. Tom Alexander Heuer
