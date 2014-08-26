From: Oliver Busch <oliver.busch@arc-aachen.de>
Subject: Re: Bug report: Author/Commit date in ISO 8601 format
Date: Tue, 26 Aug 2014 15:19:11 +0200
Message-ID: <53FC894F.9060402@arc-aachen.de>
References: <53FC3768.3090905@arc-aachen.de> <20140826130610.GG29180@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 15:19:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMGec-0005dQ-GK
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 15:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950AbaHZNTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Aug 2014 09:19:13 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56363 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895AbaHZNTN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 09:19:13 -0400
Received: from [192.168.43.193] ([194.8.202.70])
	by mrelayeu.kundenserver.de (node=mreue102) with ESMTP (Nemesis)
	id 0M57wk-1WOGg40ig2-00zEC1; Tue, 26 Aug 2014 15:19:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140826130610.GG29180@peff.net>
X-Provags-ID: V02:K0:5haXhnEM2oMvGSCOhvu1xQpTKaiwD8hEY1hXGzl46q4
 n4ddzYYETXuavxQAihiVlSh3veS9SpLhqTCdYe0IFb/VFUgVrf
 pIDC++OuKqIG3Rzr2fjZlaXLHgrsdAsRZ3pDIvQNbnr8d8Cqf4
 hix88YL16dx5qUu2iIonclyT3D+xeI969OgerMftojjWDBgMkz
 5saa35Hjydt4DEnszpS9fN0p8ByKswvVzI5+sIiWZLKO4Vibvw
 OK5j9cjkldlxGCKtZm2zVr6hjyxqxIr3GyCGIiWh2vaXZfcu31
 lkYPARaaQhzz5FlWdqQKvKtrUcvez63bSS9T8G23v1RC/xCnOb
 hr8E4Ygmop70rqW07g8PpukTK0b5cfQ2f5tyhmxat
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255902>

PS: As far as I understand it, there is no "optionality" of the "T" as=20
an indicator for the start of the time part.

Am 26.08.2014 um 15:06 schrieb Jeff King:
> On Tue, Aug 26, 2014 at 09:29:44AM +0200, Oliver Busch wrote:
>
>> I encountered the following problem: When using the date formatting =
option
>> ISO (either by setting --date=3Diso or using format:%ci for the comm=
itter
>> date), the output is formatted like this:
>>
>> 2014-08-25 17:49:43 +0200
>>
>> But according to ISO 8601, should be formatted like this (see
>> http://www.w3.org/TR/NOTE-datetime):
>>
>> 2014-08-25T17:49:43+02:00
> Yeah, it is not strictly ISO but more ISO-like (to further add
> confusion, it is mostly RFC3339, which claims to be a "profile of
> ISO8601". But we don't follow the timezone conventions there. Yeesh).
>
> Interestingly, this actually came up when the feature was added:
>
>    http://thread.gmane.org/gmane.comp.version-control.git/52414/focus=
=3D52585
>
> but there was some discussion of ISO8601's weird phrasing of "T" bein=
g
> optional.
>
>> I therefore suggest to adapt the output when using --date=3Diso or
>> format:%ci to comply 100% with the ISO 8601 specs, or at least chang=
e
>> documentation to say the output is only "ISO-like".
> I think changing the output at this point would cause backwards
> compatibility problems (not to mention that it's a lot less readable =
for
> humans).
>
> Patches welcome for a documentation update. I also think something li=
ke
> --date=3Diso8601-strict might make sense for the case of feeding the
> result to another parser.
>
> -Peff
>


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
