From: Marius Ungureanu <marius.ungureanu@xamarin.com>
Subject: Re: [PATCH] Updated C# userdiff patterns.
Date: Sat, 26 Apr 2014 12:55:10 +0300
Message-ID: <97789B23-A375-46B1-99FD-A851A15C2D85@xamarin.com>
References: <29F78086-81B4-481F-9051-FF3EEBA9BB08@xamarin.com> <535B5BFF.40002@kdbg.org>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 11:54:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdzJc-0005r1-Rt
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 11:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbaDZJyc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Apr 2014 05:54:32 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:45496 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbaDZJya convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2014 05:54:30 -0400
Received: by mail-ee0-f43.google.com with SMTP id e53so3410408eek.30
        for <git@vger.kernel.org>; Sat, 26 Apr 2014 02:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xamarin.com; s=google;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oyHnzptd3622FvktTglhwSgJiCXzIKgRc423cY6LhuU=;
        b=TDMQaiJCa6gsailZAEB5qZvNJQNQM6O98EVj7aCBEnxmn3uGuyYcknBd81VaGnJB0r
         Vq0pEqO7SG9B/0Kg3i/JNx60cDQLQwtAdc0VeKtlfFiyJ54gNEgtdN/CgSBWjp2Y5i7f
         aT/pZi4fitTT0JXoBlhhOnOO+BCNdZ+25XvYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=oyHnzptd3622FvktTglhwSgJiCXzIKgRc423cY6LhuU=;
        b=inaELXDMe31qgjsuSRtMt018aXN3nKCQwTfuqDAGSD4YP/F9dJaNufsDnC+XF7WOvH
         WOJ4qrGUvlkcPQNFQ7FNahYrsmZxW0ooiV6ZDZL4/KTKnIHvXf1AqvbyNYk3xphabyx3
         pv/Dz7UWs5CDH3mJzcvhAbE4NeGK3+oM6OlaKjWT4unrSjfAXyI4rTYwpHqR0gAFYwuM
         neGVl3TKr3czQSPhFN5XNQnCj9Q0IOFbFnVx/zCQsDb1jZwyruXCaytcy9z606QzJ5Gh
         D67/kFFpZWHMQMCZpZgoYIK2kQGP3ccKzzdrff3azDLnx6xHzFyb49/JKLnVTdnCL7zO
         /F/A==
X-Gm-Message-State: ALoCoQnOCGZJojqaxx1+M833TiiXMM0htRzUDZqIE3cKKCR4PU4Xd8NuOYrFG547ca+mYXsjY1ZY
X-Received: by 10.14.104.135 with SMTP id i7mr17125526eeg.34.1398506069405;
        Sat, 26 Apr 2014 02:54:29 -0700 (PDT)
Received: from [192.168.1.101] ([188.26.30.123])
        by mx.google.com with ESMTPSA id m8sm32032801eeg.11.2014.04.26.02.54.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 26 Apr 2014 02:54:28 -0700 (PDT)
In-Reply-To: <535B5BFF.40002@kdbg.org>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247153>


On 26 Apr 2014, at 10:10, Johannes Sixt <j6t@kdbg.org> wrote:

> Am 26.04.2014 01:25, schrieb Marius Ungureanu:
>> New keywords: foreach, break, in, try, finally, as, is, typeof, var,
>> default, fixed, checked, unchecked, this, lock, readonly, unsafe,
>> ref, out, base, null, delegate, continue.
>>=20
>> Removed keywords: instanceof. It's only in Java.
>> Moved keywords to happen before modifier parsing, as matching a keyw=
ord
>> will stop modifiers from being matched.
>>=20
>> Added method modifiers: extern, abstract.
>>=20
>> Added properties modifiers: abstract.
>>=20
>> Added parsing of events and delegates, which are like properties, bu=
t
>> take an extra keyword.
>>=20
>> The reasoning behind adding unsafe to keywords is being also a
>> statement that can happen inline in code to mention blocks which are
>> unsafe. Also, delegates are not necessarily declared in class bodies=
,
>> but can also happen inline in other functions.
>>=20
>> Keywords are based on MSDN docs.
>>=20
>> Signed-off-by: Marius Ungureanu <marius.ungureanu@xamarin.com>
>=20
> Thanks for your contribution.
>=20
> Please write the commit message in imperative mood, and use full
> sentences, not just fragments and avoid contractions ("it's"). Also,
> don't capitalize the subject line and drop the full-stop:
>=20
>   update C# userdiff patterns
>=20
>   Add new keywords: foreach, break, ...
>=20
>   Remove keyword instanceof because it is only in Java. =85
>=20

Hey!

I=92ll fix the commit message and description.

> BTW, it is now dead easy to add test cases for userdiff patterns. Jus=
t
> drop files with content like this into t/t4018:
>=20
> ---- t/t4018/csharp-ignore-statement-keywords -----
> class Foo {
> 	public int RIGHT()
> 	{
> 		if (x)
> 		else
> 		try
> 		catch (y)
> 		...
>=20
> 		ChangeMe;
> 	}
> }
> =97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97
>=20

Great, I=92ll make another commit with adding unit tests. Thanks!

> (This I just invented, I don't do C#.) See the README file in that
> directory.
>=20
>> ---
>> userdiff.c | 12 ++++++------
>> 1 file changed, 6 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/userdiff.c b/userdiff.c
>> index fad52d6..7612c5d 100644
>> --- a/userdiff.c
>> +++ b/userdiff.c
>> @@ -133,14 +133,14 @@ PATTERNS("cpp",
>> 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lLuU]*"
>> 	 "|[-+*/<>%&^|=3D!]=3D|--|\\+\\+|<<=3D?|>>=3D?|&&|\\|\\||::|->\\*?|=
\\.\\*"),
>> PATTERNS("csharp",
>> -	 /* Keywords */
>> -	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|=
throw|catch|using)\n"
>> 	 /* Methods and constructors */
>> -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|s=
ealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]=
]+[ \t]*\\(.*\\))[ \t]*$\n"
>> -	 /* Properties */
>> -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|s=
ealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+=
)[ \t]*$\n"
>> +	 "^[ \t]*(((abstract|extern|internal|new|override|private|protecte=
d|public|sealed|static|unsafe|virtual)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]=
+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
>> +	 /* Properties, events, delegates */
>> +	 "^[ \t]*(((abstract|internal|new|override|private|protected|publi=
c|sealed|static|unsafe|virtual)[ \t]+)*((delegate|event)[ \t]+)*[][<>@.=
~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
>> 	 /* Type definitions */
>> -	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|se=
aled|abstract|partial)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$\n=
"
>> +	 "^[ \t]*(((abstract|internal|new|override|partial|private|protect=
ed|public|sealed|static|unsafe)[ \t]+)*(class|enum|interface|struct)[ \=
t]+.*)$\n"
>> +	 /* Keywords */
>> +	 "!^[ \t]*(as|base|break|case|catch|checked|continue|default|deleg=
ate|do|else|finally|fixed|for|foreach|if|in|is|lock|new|null|out|readon=
ly|ref|return|switch|this|throw|try|typeof|unchecked|unsafe|using|var|w=
hile)\n"
>> 	 /* Namespace */
>> 	 "^[ \t]*(namespace[ \t]+.*)$",
>> 	 /* -- */
>=20
> Here, you are moving keywords down, but in the commit message you say
> that you "moved keywords to happen before modifier parsing". Aren't y=
ou
> moving keywords *after* something? (Where the "modifiers" are here is
> not obvious, but that can be attributed to that I don't do C#.)
>=20

It was a typo because I was sleepy. It was intentional to move them *af=
ter*.
Modifier parsing can contain keywords, so just to be sure, I moved the
keywords after modifier parsing, so it uses the keywords as a fallback.
If this is not what should happen, please tell.

Modifiers are prefixes to methods/properties. (the pipe separated lists=
)

> BTW, I appreciate that you re-arrange keywords alphabetically. Could =
you
> do that in the commit message, too?
>=20
> =97 Hannes

I=92ll handle this too, no problem.

Thanks,
Marius
