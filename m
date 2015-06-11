From: Gabriel <gabrielperren@gmail.com>
Subject: Re: Minor issue: bad Spanish translation
Date: Thu, 11 Jun 2015 12:12:17 -0300
Message-ID: <1434035537.29259.0@smtp.gmail.com>
References: <CALBDAwCWbfH-9089Kv=ZJD1wmf076_JCS4G8wzH3BQPhGoWRig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 11 17:12:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z349d-0004pz-UF
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 17:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbbFKPMZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2015 11:12:25 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:32910 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbbFKPMY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jun 2015 11:12:24 -0400
Received: by qkhg32 with SMTP id g32so4403545qkh.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4ViwYfqlFMQ3E6+lb8qe6tV8VUnGqPKybyjJHDMoz0c=;
        b=YMgQVTtSmROMTqFftqY7/MyCqVRMSAEJuu068PSRy1xDA8HxbzDhoIV1ToQJt3fwrT
         BL6wQHIUcb7iXQY9dE3k/4Z+/6vEsBIraPLGvlPH4N4VstjilCe9uBeSngNFkA5RCdYF
         PJFS04ykxRxJc+UzqMtdj0RXijpMoCTRd84D5NQvDVKNYCRuo7y+bzzT/TpNifW3qD0Z
         nuP8zBDc/mGb25HqGNEn6JcdOTMQSsWHWawxaa/Lykh8ncaJUYEnGEdgo2qbqWBZrI0Z
         dt6u2F7PGHTnXtlFO7X5NZc2ohhM3hMGzP5ky2cBopheq4hMWCe1+TWj+r1uG7sfo5XG
         EIdQ==
X-Received: by 10.55.19.140 with SMTP id 12mr19793504qkt.64.1434035543402;
        Thu, 11 Jun 2015 08:12:23 -0700 (PDT)
Received: from [192.168.1.100] ([181.170.86.23])
        by mx.google.com with ESMTPSA id u95sm364080qge.16.2015.06.11.08.12.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jun 2015 08:12:22 -0700 (PDT)
In-Reply-To: <CALBDAwCWbfH-9089Kv=ZJD1wmf076_JCS4G8wzH3BQPhGoWRig@mail.gmail.com>
X-Mailer: geary/0.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271415>

Hi Johannes,

I tried following your instructions but I can locate the sentence where=
=20
the bad translation is. Please see here:=20
http://stackoverflow.com/questions/30783818/find-instance-of-string-in-=
git-core-with-git-grep

Any advice?

Cheers,
Gabriel

El jue, 11 de jun 2015 a las 12:10 , Gabriel Perren=20
<gabrielperren@gmail.com> escribi=C3=B3:
> Hi Johannes,
>=20
> I tried following your instructions but I can locate the sentence=20
> where the bad translation is. Please see here:=20
> http://stackoverflow.com/questions/30783818/find-instance-of-string-i=
n-git-core-with-git-grep
>=20
> Any advice?
>=20
> Cheers,
> Gabriel
>=20
> 2015-06-10 11:57 GMT-03:00 Johannes Schindelin=20
> <johannes.schindelin@gmx.de>:
>> Hi Gabriel,
>>=20
>> On 2015-06-10 16:51, Gabriel wrote:
>> > Where it says:
>> >
>> > Su rama est=C3=A1 delante de <<origin/master<< para 6 commits.
>> >
>> > it should say:
>> >
>> > Su rama est=C3=A1 delante de <<origin/master<< por 6 commits.
>> >
>> > Notice "para" --> "por".
>>=20
>> Good catch.
>>=20
>> You could earn eternal fame by cloning Git itself (e.g. via `git=20
>> clone https://github.com/git/git), finding the respective files with=
=20
>> `git grep`, patching them, making a commit and following the guide=20
>> lines in Documentation/SubmittingPatches to contribute the fix via=20
>> this mailing list[*1*]. That way, you would enter the illustrious=20
>> group of core Git developers.
>>=20
>> Ciao,
>> Johannes
>>=20
>> Footnote *1*: If you are more comfortable with GitHub's Pull=20
>> Requests than with sending patches via email, you could use=20
>> https://submitgit.herokuapp.com/ to turn a Pull Request into an=20
>> appropriately formatted mail to the mailing list.
>=20
