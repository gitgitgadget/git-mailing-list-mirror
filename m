From: Marius Ungureanu <marius.ungureanu@xamarin.com>
Subject: Re: [PATCH] Updated C# userdiff patterns.
Date: Sat, 26 Apr 2014 21:33:52 +0300
Message-ID: <1EA6F663-54DC-4665-A88C-8627F38B356E@xamarin.com>
References: <29F78086-81B4-481F-9051-FF3EEBA9BB08@xamarin.com> <535B5BFF.40002@kdbg.org> <97789B23-A375-46B1-99FD-A851A15C2D85@xamarin.com> <535BF1C0.7080204@kdbg.org>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 20:33:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We7PY-0008Hb-Ph
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 20:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbaDZSdK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Apr 2014 14:33:10 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:46996 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbaDZSdI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2014 14:33:08 -0400
Received: by mail-ee0-f53.google.com with SMTP id b57so3597467eek.26
        for <git@vger.kernel.org>; Sat, 26 Apr 2014 11:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xamarin.com; s=google;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=axpjQx9M1MVJk0PY3xnWvKz6e++JPEcQT/pwDJh0XHs=;
        b=m0yLi7QG68xqwqao9MRBKODDWU8Y1inaPs32SWBrbghtaEsnxyBFNpVg2IwBwIwnjY
         SRIppINGdreuxEVl3MfBtkkx+H9qKOah3Z91QItQ1yI/6UPo/w9fcHrqK7JGuqfnWwm7
         7eyPA1whpIdfpCImqwuudR925g/bGFt0WR2o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=axpjQx9M1MVJk0PY3xnWvKz6e++JPEcQT/pwDJh0XHs=;
        b=X7prB+ITVrotaNs1oE1Aob4FlTMO2uWuFrO9lTFVGN0Y1SDS/FKzjF3j3wT7i4gJk9
         3OK3+CEWsgdJH2Pe7SpGQBdpUqEzm33o3VLst5UD8DdcUKy+CKebikuZR7zxgh8aUS4h
         AdFSe2ACoGOyS9fGZ4a97b5hhrbgo6JPfjVbHuoJwJydrPCTONLYvN9LyL+xsNoOcnQA
         D3rh5PzSLGnbsY8zVCvlqWe3Wbkk4IeVgjdY9HCpHGsEHEaXabdcQxKN3unorWkwUIJP
         q8aj1THCjYOUAMRZGkG3m27tm3N3FP3YXEygAKO8mVh2qY0SaV41fC4PZRgWIvUDOnOA
         tX8A==
X-Gm-Message-State: ALoCoQkDkxxUgKJXcA3bik3RQ3iqHo41KXqaxOjMYX0isRfMApis74sL0d+qMiIaY/FC9kmglBPQ
X-Received: by 10.15.43.77 with SMTP id w53mr19719773eev.10.1398537186620;
        Sat, 26 Apr 2014 11:33:06 -0700 (PDT)
Received: from [192.168.1.101] ([188.26.30.123])
        by mx.google.com with ESMTPSA id l42sm35269583eew.19.2014.04.26.11.33.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 26 Apr 2014 11:33:05 -0700 (PDT)
In-Reply-To: <535BF1C0.7080204@kdbg.org>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247176>

On 26 Apr 2014, at 20:49, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 26.04.2014 11:55, schrieb Marius Ungureanu:
>> On 26 Apr 2014, at 10:10, Johannes Sixt <j6t@kdbg.org> wrote:
>>> Am 26.04.2014 01:25, schrieb Marius Ungureanu:
>>>> diff --git a/userdiff.c b/userdiff.c
>>>> index fad52d6..7612c5d 100644
>>>> --- a/userdiff.c
>>>> +++ b/userdiff.c
>>>> @@ -133,14 +133,14 @@ PATTERNS("cpp",
>>>> 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lLuU]*"
>>>> 	 "|[-+*/<>%&^|=3D!]=3D|--|\\+\\+|<<=3D?|>>=3D?|&&|\\|\\||::|->\\*=
?|\\.\\*"),
>>>> PATTERNS("csharp",
>>>> -	 /* Keywords */
>>>> -	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|cas=
e|throw|catch|using)\n"
>>>> 	 /* Methods and constructors */
>>>> -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual=
|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum=
:]]+[ \t]*\\(.*\\))[ \t]*$\n"
>>>> -	 /* Properties */
>>>> -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual=
|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]=
]+)[ \t]*$\n"
>>>> +	 "^[ \t]*(((abstract|extern|internal|new|override|private|protec=
ted|public|sealed|static|unsafe|virtual)[ \t]+)*[][<>@.~_[:alnum:]]+[ \=
t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
>>>> +	 /* Properties, events, delegates */
>>>> +	 "^[ \t]*(((abstract|internal|new|override|private|protected|pub=
lic|sealed|static|unsafe|virtual)[ \t]+)*((delegate|event)[ \t]+)*[][<>=
@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
>>>> 	 /* Type definitions */
>>>> -	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|=
sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$=
\n"
>>>> +	 "^[ \t]*(((abstract|internal|new|override|partial|private|prote=
cted|public|sealed|static|unsafe)[ \t]+)*(class|enum|interface|struct)[=
 \t]+.*)$\n"
>>>> +	 /* Keywords */
>>>> +	 "!^[ \t]*(as|base|break|case|catch|checked|continue|default|del=
egate|do|else|finally|fixed|for|foreach|if|in|is|lock|new|null|out|read=
only|ref|return|switch|this|throw|try|typeof|unchecked|unsafe|using|var=
|while)\n"
>>>> 	 /* Namespace */
>>>> 	 "^[ \t]*(namespace[ \t]+.*)$",
>>>> 	 /* -- */
>>=20
>> ...
>> Modifier parsing can contain keywords, so just to be sure, I moved t=
he
>> keywords after modifier parsing, so it uses the keywords as a fallba=
ck.
>> If this is not what should happen, please tell.
>=20
> For each line, patterns are are scanned in order, and the first match
> determines the outcome: If it is a negative pattern (i.e., it begins
> with an exclamation mark), the line is not a hunk header; if it is a
> positive pattern, the line is a hunk header. If no pattern matches, t=
he
> line is not a hunk header, either; it is as if the list were terminat=
ed
> by a negative catch-all pattern.
>=20
> Due to these rules, negative patterns in the list are only necessary
> when you want to make an exception to a positive pattern in the list,
> and then the negative pattern must be listed before the positive patt=
ern.
>=20
> In the csharp case, I do not see a pattern of which the keyword patte=
rn
> would make an exception (neither the old version nor your new version=
).
> Therefore, you could drop the keyword pattern entirely.
>=20
> -- Hannes
>=20

Hey!

I=92ll remove them and add as many unit tests I can. I=92ve been side t=
racked
today and I couldn=92t get to look at it. I=92ll start a new thread wit=
h the new
patch as soon as I=92m done with it.

Thanks for all the tips until now. You=92ve been of great help.

Marius