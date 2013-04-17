From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH/RFC] l10n: de.po: translate 39 new messages
Date: Wed, 17 Apr 2013 07:49:48 +0200
Message-ID: <CAN0XMOLcNwOUPK2sYvvO_QMaJrMkH949_xZLtdyF+zFx1p4v+Q@mail.gmail.com>
References: <1366043260-3131-1-git-send-email-ralf.thielow@gmail.com>
	<87ppxuan7i.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	git <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Apr 17 07:49:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USLFj-00045s-6N
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 07:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757563Ab3DQFtu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 01:49:50 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:59479 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757179Ab3DQFtt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 01:49:49 -0400
Received: by mail-wi0-f175.google.com with SMTP id h11so79849wiv.8
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 22:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=jssh1UG4EEUWvstldgQmavQ68SS0qUkPt+pqsDGnI4c=;
        b=WU2PGSGStjcoCcyxFGB8jodaezUydT1GQvfVJIzCSw4RoxHOdU0eizfKZrw0A1XKZf
         dcAH+IW3/6xIxDG3xJ+6gR6b1KDutkuVhY8X8jxTl0lc/tKCDEFkKjFNcIq+TbarfRta
         1dTbdxv0sEpJwIpF/wEIIqU7YghBZhQ60aVsi4E4s8RyEbRxFkq6Sf57jVR5iiJuC8XS
         9UTGCt0YPaLDBZhjjPGm6VY9KfKvOwMD7jIUz5bZukfnkXlnGZeGWChVFBQLeaXnqLp2
         4TiSrSxeJy7VCVSI0JhzyI79+SfFpGRGPJkqbGLgIdCkU8d74YRaUFeCiiq9Ypa3t/qv
         e+jw==
X-Received: by 10.194.222.100 with SMTP id ql4mr8432567wjc.59.1366177788487;
 Tue, 16 Apr 2013 22:49:48 -0700 (PDT)
Received: by 10.194.31.137 with HTTP; Tue, 16 Apr 2013 22:49:48 -0700 (PDT)
In-Reply-To: <87ppxuan7i.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221510>

Hi,

Thanks for review!

2013/4/16 Thomas Rast <trast@inf.ethz.ch>:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>>  msgid "You are currently reverting commit %s."
>> -msgstr "Sie sind gerade bei einer bin=C3=A4ren Suche in Zweig '%s'.=
"
>> +msgstr "Sie kehren gerade Version '%s' um."
>
> Is revert->umkehren new?  I can see it's in the glossary, but
>

Yes, I've added it recently to the glossary. I've only checked the
glossary and didn't find it. I didn't check de.po for past usages, thou=
gh.

>   #: sequencer.c:536
>   #, c-format
>   msgid "could not revert %s... %s"
>   msgstr "Konnte %s nicht zur=C3=BCcksetzen... %s"
>
>   #: sequencer.c:1016
>   msgid "Can't revert as initial commit"
>   msgstr "Kann nicht zu initialer Version zur=C3=BCcksetzen."
>
> which I don't really like either now that you mention it -- I would
> re-translate it as 'reset'.  But either way they should be consistent=
=2E
>

I'm not sure I understand. We currently translate "reset" as "neu
setzen/umsetzen",
which is fine if it means a branch or HEAD ('git reset'), but for commi=
ts?
What about "zur=C3=BCcknehmen"?

>>  msgid "Commit %s has an untrusted GPG signature, allegedly by %s."
>> -msgstr ""
>> +msgstr "Version %s hat eine nicht vertrauensw=C3=BCrdige GPG-Signat=
ur, "
>> +"vermeintlich von %s."
>>
>>  msgid "Commit %s has a bad GPG signature allegedly by %s."
>> -msgstr ""
>> +msgstr "Version %s hat eine ung=C3=BCltige GPG-Signatur, vermeintli=
ch von %s."
>
> You could say "angeblich" instead, which is more to the point.
>

Yes. Thanks.

>>  #: git-submodule.sh:626
>> -#, fuzzy, sh-format
>> +#, sh-format
>>  msgid "Submodule '$name' ($url) unregistered for path '$sm_path'"
>> -msgstr "Unterprojekt '$name' ($url) ist f=C3=BCr Pfad '$sm_path' re=
gistriert"
>> +msgstr "Unterprojekt '$name' ($url) ist nicht f=C3=BCr Pfad '$sm_pa=
th' registriert."
>
> This is in cmd_deinit(), and the comment for the enclosing block says
>
>   # Remove the whole section so we have a clean state when
>   # the user later decides to init this submodule again
>
> So it would seem to use "unregister" as a verb, not an adjective, and
> the correct translation is
>
>   msgstr "Unterprojekt '$name' ($url) f=C3=BCr '$sm_path' deregistrie=
rt."
>
> or some such.  "Deregistriert" is not very nice; in the absence of
> context I would suggest "ausgetragen", but that problably collides wi=
th
> our use of "eintragen".  Perhaps you can go the long way for this
> isolated use and just say "aus der Konfiguration entfernt" (and
> similarly for 'register').
>

Thanks. I prefer your "aus der Konfiguration entfernt/eingetragen".

> In any case you should also add 'register' and 'unregister' to the
> glossary once you've settled on something.
>

Yes, I'll do.

> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
