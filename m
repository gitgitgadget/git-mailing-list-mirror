From: =?UTF-8?B?RGF2aWQgUm9kcsOtZ3VleiBkZSBEaW9z?= 
	<deivid.rodriguez@gmail.com>
Subject: Re: Ubuntu may break Git upstream translations
Date: Tue, 10 Dec 2013 11:07:27 +0100
Message-ID: <52A6E7DF.5070504@gmail.com>
References: <CANYiYbF--_51hJmp=28ucwBa6YEuUn97kTAd87POuqrD4SU5gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Paco Molinero <paco@byasl.com>,
	Dimitri John Ledkov <dmitrijs.ledkovs@canonical.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 11:07:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqKE7-0007fC-AR
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 11:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606Ab3LJKHe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Dec 2013 05:07:34 -0500
Received: from mail-bk0-f49.google.com ([209.85.214.49]:38078 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab3LJKHb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 05:07:31 -0500
Received: by mail-bk0-f49.google.com with SMTP id my13so1848417bkb.22
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 02:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=804RfKjzV2mKHtrL+5Q47pkeyTfZ2oTWBkUI0g0kZjw=;
        b=xCiXlorwbzAXEfb6r+/2Ed2yhZxYp/gNxzI2MbQBHHQlTfWcu/rbs5W/iO8sADy6dB
         BtGjIv+D33GPkmL050EaOBnu94lXBC2qOd9/+MSfGM1CpE6g44qKJ7Iz2H9tpyBoFe+E
         tSUiDQyYgfpja/RWn3PmQMTw8lxgnKQpyoPoBJpaN3z9M0kn+EE25B8JrryRmFVLs/z4
         cElO2DogwvZjGvVr7GKXpKqQgU4oQHv+Q69U286G/Z4LzTa1iwQ+MLJIvom8JorGCOJp
         qdAmCh0sDj9waXKUfCCL3KxgwDIXBDJn0kgHNJRsZ7ievhkaJwGqcwFKU0lQakFSqCMd
         jnaw==
X-Received: by 10.204.101.199 with SMTP id d7mr7364286bko.18.1386670049853;
        Tue, 10 Dec 2013 02:07:29 -0800 (PST)
Received: from [192.168.1.33] (11.Red-79-159-199.staticIP.rima-tde.net. [79.159.199.11])
        by mx.google.com with ESMTPSA id q5sm5842277bkr.5.2013.12.10.02.07.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Dec 2013 02:07:28 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:26.0) Gecko/20100101 Thunderbird/26.0
In-Reply-To: <CANYiYbF--_51hJmp=28ucwBa6YEuUn97kTAd87POuqrD4SU5gw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239131>

I agree with Jiang.

We should join translation efforts. And in this case, the best place to=
=20
do it is upstream.

El mar 10 dic 2013 10:56:19 CET, Jiang Xin escribi=C3=B3:
> Hi all,
>
> David find a typo in Spanish translations of Git, and ask me how
> to contribute, because he cannot find Spanish translations in
> Git source code. To my surprise, I cannot find either.
>
> Later I find out that David using Ubuntu (I use debian instead),
> and Ubuntu reinvent the wheel. Ubuntu has its own translation
> platform, and releases Git translations not with Git package
> itself, but releases Git translations in separate language
> specific packages. E.g. Spanish translations on Git is released
> in package "language-pack-es-base". This language specific
> package includes not only Git translations, but also translations
> of over 200 other packages.
>
> URL of Ubuntu translation homepage on Git:
>
> * https://translations.launchpad.net/ubuntu/saucy/+source/git/+pots/g=
it
>
> Version of Git in Ubuntu Saucy (13.10) is 1.8.3.2, but obviously
> the translations are based on git v1.8.0 (8 months older than
> v1.8.3.2). That's why even Ubuntu provides git translations
> in 21 different languages, but only 2 of them are 100% translated.
> We (Git upstream) provide Git translations in only 7 languages,
> but 5 of them are 100% translated now.
>
> Without context, it's hard to translate well. And contribute to
> upstream will benefit to more people than contribute to one
> specific Linux distribution.
>
> I cc this mail to Paco, the creator of Spanish translations for
> Git I found in this page:
>
> * https://translations.launchpad.net/ubuntu/saucy/+source/git/+pots/g=
it/es/+details
>
> Paco may have interest on David's question.
>
> I also send this mail to Dimitri, the owner of Git translations
> for Ubuntu, for reference.
>
> 2013/12/9 David Rodr=C3=ADguez de Dios <deivid.rodriguez@gmail.com>:
>>
>>> El lun 09 dic 2013 16:33:44 CET, Jiang Xin escribi=C3=B3:
>>>>
>>>> 2013/12/9 David Rodr=C3=ADguez de Dios <deivid.rodriguez@gmail.com=
>:
>>>>
>>>>> El lun 09 dic 2013 15:59:12 CET, Jiang Xin escribi=C3=B3:
>>>>>
>>>>>> 2013/12/9 David Rodr=C3=ADguez de Dios <deivid.rodriguez@gmail.c=
om>:
>>>>>>>
>>>>>>> Hi Jiang Xin!
>>>>>>>
>>>>>>> I want to contribute to the Spanish translation by fixing a typ=
o
>>>>>>> but I can't find the translation. Where is it?
>>>>>>
>>>>>> All available translations are in "po/" directory of Git, such a=
s
>>>>>> po/de.po, po/pt_PT.po, etc. And all l10n teams, maintainers
>>>>>>   and locations of the official repositories are listed in "po/T=
EAMS" file.
>>>>>>
>>>>>> I can't find a Spanish translation either, but there is a Portug=
uese
>>>>>> translation and the maintainer is Marco Sousa.
>>>>>>
>>>>>> I don't know how much differences between Spanish and Portuguese=
=2E
>>>>>> Maybe the typo you found is belongs to "po/pt_PT.po"?
>>>>>>
>>>>>
>>>>> No way... My "git" is translated into Spanish, that's why it
>>>>> surprises me that the translation is not there...
>>>>>
>>>>
>>>> What's your platform? version of your platform? git --version?
>>>> And what's the output message (with the typo you found)?
>>>> Maybe we could "git grep" in Git source code or google the output
>>>> message.
>>>>
>>> So
>>>
>>> $ uname -a
>>> Linux pantani 3.11.0-14-generic #21-Ubuntu SMP Tue Nov 12 17:07:40 =
UTC
>>> 2013 i686 i686 i686 GNU/Linux
>>>
>>> $ git --version
>>> git version 1.8.3.2
>>>
>>> $ locale
>>> LANG=3Des_ES.UTF-8
>>> LANGUAGE=3Des_ES
>>> LC_CTYPE=3D"es_ES.UTF-8"
>>> LC_NUMERIC=3D"es_ES.UTF-8"
>>> LC_TIME=3D"es_ES.UTF-8"
>>> LC_COLLATE=3D"es_ES.UTF-8"
>>> LC_MONETARY=3D"es_ES.UTF-8"
>>> LC_MESSAGES=3D"es_ES.UTF-8"
>>> LC_PAPER=3D"es_ES.UTF-8"
>>> LC_NAME=3D"es_ES.UTF-8"
>>> LC_ADDRESS=3D"es_ES.UTF-8"
>>> LC_TELEPHONE=3D"es_ES.UTF-8"
>>> LC_MEASUREMENT=3D"es_ES.UTF-8"
>>> LC_IDENTIFICATION=3D"es_ES.UTF-8"
>>> LC_ALL=3D
>>>
>>> I've downloaded git sources with
>>> $ apt-get source git
>>> $ apt-get source git-core
>>> ...
>>>
>>> and grep the string, nothing. I've also forked the git repo and gre=
p
>>> and nothing either.
>>>
>>> The message is
>>> msgid ""
>>> "  (use \"git checkout -- <file>...\" to discard changes in working
>>> directory)"
>>>
>> Oh, and the incorrect message I'm getting is
>>
>> #   (use =C2=ABgit checkout -- <archivo>...=C2=AB para descartar cam=
bios en le
>> directorio de trabajo)
>>
>>
>> El lun 09 dic 2013 16:45:17 CET, David Rodr=C3=ADguez de Dios escrib=
i=C3=B3:
>>
>
> --
> Jiang Xin
