From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [L10N] Kickoff of translation for Git 2.6.0 round 1
Date: Sat, 5 Sep 2015 21:14:18 +0800
Message-ID: <CANYiYbF3p-yHBhzyfU1WQhjRZEqjXotsQS+x5K2EbatnAGuJrw@mail.gmail.com>
References: <CANYiYbEVU7A2w999jqLQ=V35WM0WTo--RHJHW7Ocw0FfsmqmLg@mail.gmail.com>
	<2019620.IQg8023dli@cayenne>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>
X-From: git-owner@vger.kernel.org Sat Sep 05 15:14:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYDIW-0000bk-1s
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 15:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbbIENOV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Sep 2015 09:14:21 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33045 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbbIENOU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Sep 2015 09:14:20 -0400
Received: by wiclk2 with SMTP id lk2so46572447wic.0
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 06:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=x6XBKpS8LR1IFoWEh7u9LPHZ3BrRVzlCvAlbwyZDRa0=;
        b=ckUi/WA5kpsfvluy+QsRdgd+StLro/mUwAoHKwlaxSHWIS75fbpaNmy+03bUShKsRq
         L1z9DfHY2xr4/YQGtWK/ekUgRU4MOhrVWR+L7n0GhGf1ep30gBK3O89U1b0gh1FTcB7V
         6rmoOJ2gAgDTFccJVvGV1SeBccqE1j+HZalhymGZ/6RLK4/Wu0vlb66wjfd0JG6e435I
         XaHN0FnH+08rmGTRNr5Q52asvkMlsj/IKkbj8HRN3Xvf5djH86fCGijbsJx6GWKlr8Iu
         Y21wLNlKKZeUEFXLDKtZANZmyynk0RFz1NN6GCox5mNaWuK+YTgglpX87WC8iQRJMNsx
         1IWg==
X-Received: by 10.180.206.211 with SMTP id lq19mr17825177wic.81.1441458858533;
 Sat, 05 Sep 2015 06:14:18 -0700 (PDT)
Received: by 10.194.76.230 with HTTP; Sat, 5 Sep 2015 06:14:18 -0700 (PDT)
In-Reply-To: <2019620.IQg8023dli@cayenne>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277375>

2015-09-05 18:02 GMT+08:00 Jean-No=C3=ABl AVILA <jn.avila@free.fr>:
> Le samedi 5 septembre 2015, 10:17:54 Jiang Xin a =C3=A9crit :
>> Hi,
>>
>> Git v2.6.0-rc0 has been released, and it's time to start new round o=
f git
>> l10n. This time there are 123 updated messages need to be translated=
 since
>> last update:
>>
>>     l10n: git.pot: v2.6.0 round 1 (123 new, 41 removed)
>>
>>     Generate po/git.pot from v2.6.0-rc0-24-gec371ff for git v2.6.0 l=
10n
>>     round 1.
>>
>>     Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>>
>> You can get it from the usual place:
>>
>>     https://github.com/git-l10n/git-po/
>>
>> As how to update your XX.po and help to translate Git, please see
>> "Updating a XX.po file" and other sections in =E2=80=9Cpo/README" fi=
le.
>>
>> --
>> Jiang Xin
>
>
> Some new strings are not consistent with the actual set.
>
> For instance, in the "Could not ..." strings were all with capitals, =
and some
> new ones are not. Last time, I remarked strings which were almost exa=
ctly the
> same (only difference was a final dot, if I remember). Some help stri=
ngs were
> mixing different styles.

Before this update, "Could not" vs "could not" is 50:40, and now it's 5=
0:50.

    $ grep 'Could not' po/git.pot  | wc -l
    50

    $ grep 'could not' po/git.pot  | wc -l
    50

Most of them are comes from the "die*" function call (If we check the
"die*" funtion call, we can see more inconsistent leading characters).
Because it's hardly for the normal operations to fall into these code
blocks, so most people won't find this issue.  If we care, we can fix
them, but I suspect these fixes could catch up this update window.

> Some strings may be difficult to translate in some languages.

Maybe the following is not the most difficult to translate, but I also
want to point here.  Some messages have multiple specifiers,
for this case we can order the specifiers in our translation text,
such as:

    msgid   "'%s' for '%s' is not a valid timestamp"
    msgstr  "'%2$s' =E7=9A=84=E5=80=BC '%1$s' =E4=B8=8D=E6=98=AF=E4=B8=80=
=E4=B8=AA=E6=9C=89=E6=95=88=E7=9A=84=E6=97=B6=E9=97=B4=E6=88=B3"

I think the most difficult to translate messages you pointed for
this round are:

    +msgid   "'git bisect $TERM_BAD' can take only one argument."

    +msgid   "Invalid command: you're currently in a
$TERM_BAD/$TERM_GOOD bisect."

    +msgid   "You need to give me at least one $bad_syn and one $good_s=
yn "
    +        "revision.\n"
    +        "(You can use \"git bisect $bad_syn\" and \"git bisect
$good_syn\" "
    +        "for that.)"

Before we can do something to make a l10n-friendly git-bisect,
we have to leave $TERM_BAD / $TERM_GOOD / $good_syn
/ $bad_syn unchanged.


--=20
Jiang Xin
