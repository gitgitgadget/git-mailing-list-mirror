From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: fix interactive rebase message
Date: Wed, 2 Mar 2016 19:49:11 +0100
Message-ID: <CAN0XMOLrO98XB9DN39=bZpXUyTtUz0y-HuTxDGFBJ3nRR9z3_A@mail.gmail.com>
References: <1456940183-6712-1-git-send-email-ralf.thielow@gmail.com>
	<CAGZ79kZA0rC87yJGHB8NaS0aR6fvWJQsBaw998dRySYhBgrD7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	Magnus G <magnus.goerlitz@googlemail.com>
To: Stefan Beller <sbeller@google.com>,
	Phillip Sz <phillip.szelat@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 19:49:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abBpl-000433-Vd
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 19:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195AbcCBStN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2016 13:49:13 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34253 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbcCBStN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2016 13:49:13 -0500
Received: by mail-lf0-f48.google.com with SMTP id l13so29138977lfb.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 10:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=k7sg4s5kW+dfXUWLNkrIQ5+MHpccjzLMI1qf1/O7il8=;
        b=pRI0lY/N+i0zX7aEBstHeK/oe67jysoqN/tgIEgHbBKYU/tkr0h9i4sDZe86LMgbEA
         MODFRVByfPgyviZVMtCShWBsu2Y2H5HXv07Bkfc6HRjhVwAnqkoWZN6ulttykx1fw43I
         uZK0W5Y/eNCCAniQU4j83A7caW2YHM5ar5TNlx0IRFDSISBOsOV2A1zHAYGACmsDNEil
         gl9ylh6uWP8yCk2f9y74CB19hd/1ZbqDxUYyyG9OSGLisQANzQm8cUMFUsxBnGFRf+Vt
         /UVdmYHSu3JbVqRF4/Xyu+KX7hWO4jJCD5XxIUPFmOW6yUQEZ2UN3h6yyRrmYJE7DEXb
         dxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=k7sg4s5kW+dfXUWLNkrIQ5+MHpccjzLMI1qf1/O7il8=;
        b=P3lWV1dcHq9ZB8qWa98ECpRoz+eeySBrCuelFQLGs0iytyHOqGcqrAL1A3ORQBRTj+
         kfU51b2VV/tvLLZVrtEVN182Yw2Gh/jUBl0IUQwqRdh4kpU7UQSJ7InLNyvYzX+a4HDK
         hV0L6GwSitaIdCk4qtwLjsK5UxHdN/HqQlaeUBrGqNFJ5oJIfND4zf1M7l7XOUcdSR+K
         dIKptM8ggpe3SeuOM5g+W5p0agaLFlYqxD2Q2AnAHfR1bU9NTyi8dNMFHhyO3LYrxVju
         3QIkKoCfbYSfO0hkDTxmHb6lPmA45xHv93eo3EzfkRDQ0nuOc3siOxi4EKdVuQswdKfb
         9eeg==
X-Gm-Message-State: AD7BkJK40YNF8/+h1BYi0Gf+jmbw4PpNZnMxVJPxPCAL41A6P0JBLWHIemO2TGlDcOgsSryzlHp4HK3BdKGaNA==
X-Received: by 10.25.26.83 with SMTP id a80mr11023668lfa.36.1456944551258;
 Wed, 02 Mar 2016 10:49:11 -0800 (PST)
Received: by 10.25.18.207 with HTTP; Wed, 2 Mar 2016 10:49:11 -0800 (PST)
In-Reply-To: <CAGZ79kZA0rC87yJGHB8NaS0aR6fvWJQsBaw998dRySYhBgrD7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288143>

Am 2. M=C3=A4rz 2016 um 18:46 schrieb Stefan Beller <sbeller@google.com=
>:
> On Wed, Mar 2, 2016 at 9:36 AM, Ralf Thielow <ralf.thielow@gmail.com>=
 wrote:
>> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>> ---
>>  po/de.po | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/po/de.po b/po/de.po
>> index 8c5f05d..07b4456 100644
>> --- a/po/de.po
>> +++ b/po/de.po
>> @@ -1950,8 +1950,8 @@ msgstr "Keine Kommandos ausgef=C3=BChrt."
>>  #, c-format
>>  msgid "Last command done (%d command done):"
>>  msgid_plural "Last commands done (%d commands done):"
>> -msgstr[0] "Letztes Kommando ausgef=C3=BChrt (%d Kommando ausgef=C3=BC=
hrt):"
>> -msgstr[1] "Letzte Kommandos ausgef=C3=BChrt (%d Kommandos ausgef=C3=
=BChrt):"
>> +msgstr[0] "Zuletzt ausgef=C3=BChrtes Kommando (%d Kommando ausgef=C3=
=BChrt):"
>> +msgstr[1] "Zuletzt ausgef=C3=BChrte Kommandos (%d Kommandos ausgef=C3=
=BChrt):"
>
> Ist "Kommando" generell akzeptiert in der deutschen Uebersetzung?
> Intuitive haette ich jetzt
>
>     Zuletzt ausgef=C3=BChrter Befehl (%d Befehl ausgef=C3=BChrt):
>
> erwartet.
>
> thanks,
> Stefan
>

Looking at the standard translations in Ubuntu [1],
"command" is supposed to be translated as "Befehl" if
it's the first part in the command line (the actual command)
and "Kommando" if it's the second part (a subcommand).

Currently we almost always translate as "Kommando", which,
following this guidance, is only partially correct.
In this case here I'd interpret it as "Befehl", too.

I personally am happy to go this way.  However, this should
be done in a separate patch that updates the whole translation.

Phillip, you're by far more experienced with other translations
than me, what do you think?

[1]
https://wiki.ubuntu.com/UbuntuGermanTranslators/Standard%C3%BCbersetzun=
gen

>
>>
>>  #: wt-status.c:1119
>>  #, c-format
>> --
>> 2.8.0.rc0.140.gf92f5fe
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
