From: Jiang Xin <worldhello.net@gmail.com>
Subject: Ubuntu may break Git upstream translations
Date: Tue, 10 Dec 2013 17:56:19 +0800
Message-ID: <CANYiYbF--_51hJmp=28ucwBa6YEuUn97kTAd87POuqrD4SU5gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Paco Molinero <paco@byasl.com>,
	Dimitri John Ledkov <dmitrijs.ledkovs@canonical.com>
To: =?ISO-8859-1?Q?David_Rodr=EDguez_de_Dios?= 
	<deivid.rodriguez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 10:56:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqK3J-0007Da-FD
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 10:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab3LJJ4Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Dec 2013 04:56:24 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:48562 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab3LJJ4U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Dec 2013 04:56:20 -0500
Received: by mail-wg0-f46.google.com with SMTP id m15so4567871wgh.1
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 01:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BNiv5N5zzsEFKfIHF99AjBzvLoD2bMKcyX8bp9nWRLs=;
        b=fwFmYLHmrWd6wcXlKB0uQMpSSk4yhLhTfyrkYHrbYdh2hSR6T9ERL0jSVYjoXamSTQ
         JB1wFw1JSjghdKEYOfc7DNgzZPMEUtiW5viQ27hQU8NFFyMPBVi9C2njXQONLs2ULzQm
         CYd3P26hw4AitR/P48aU96n6bS1DIudvwrp1ZWfu/ttN+geo1zxUOh/OAjnwDdhqdnPB
         EtNKqZFDrYsb5hJSmBsIkCcuPZxIAGG/X0He8YaLckzM8NbUJnx6yOzWINc4IB+uwt6B
         n2khGnm7ViXO/zd1hd5yGLpx34tWPSS9lOmqbUJKD5jV5Tc0+MkeEN1gw2u6rRllaFSu
         h6aw==
X-Received: by 10.180.189.49 with SMTP id gf17mr18308864wic.23.1386669379240;
 Tue, 10 Dec 2013 01:56:19 -0800 (PST)
Received: by 10.216.213.207 with HTTP; Tue, 10 Dec 2013 01:56:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239130>

Hi all,

David find a typo in Spanish translations of Git, and ask me how
to contribute, because he cannot find Spanish translations in
Git source code. To my surprise, I cannot find either.

Later I find out that David using Ubuntu (I use debian instead),
and Ubuntu reinvent the wheel. Ubuntu has its own translation
platform, and releases Git translations not with Git package
itself, but releases Git translations in separate language
specific packages. E.g. Spanish translations on Git is released
in package "language-pack-es-base". This language specific
package includes not only Git translations, but also translations
of over 200 other packages.

URL of Ubuntu translation homepage on Git:

* https://translations.launchpad.net/ubuntu/saucy/+source/git/+pots/git

Version of Git in Ubuntu Saucy (13.10) is 1.8.3.2, but obviously
the translations are based on git v1.8.0 (8 months older than
v1.8.3.2). That's why even Ubuntu provides git translations
in 21 different languages, but only 2 of them are 100% translated.
We (Git upstream) provide Git translations in only 7 languages,
but 5 of them are 100% translated now.

Without context, it's hard to translate well. And contribute to
upstream will benefit to more people than contribute to one
specific Linux distribution.

I cc this mail to Paco, the creator of Spanish translations for
Git I found in this page:

* https://translations.launchpad.net/ubuntu/saucy/+source/git/+pots/git=
/es/+details

Paco may have interest on David's question.

I also send this mail to Dimitri, the owner of Git translations
for Ubuntu, for reference.

2013/12/9 David Rodr=EDguez de Dios <deivid.rodriguez@gmail.com>:
>
>> El lun 09 dic 2013 16:33:44 CET, Jiang Xin escribi=F3:
>>>
>>> 2013/12/9 David Rodr=EDguez de Dios <deivid.rodriguez@gmail.com>:
>>>
>>>> El lun 09 dic 2013 15:59:12 CET, Jiang Xin escribi=F3:
>>>>
>>>>> 2013/12/9 David Rodr=EDguez de Dios <deivid.rodriguez@gmail.com>:
>>>>>>
>>>>>> Hi Jiang Xin!
>>>>>>
>>>>>> I want to contribute to the Spanish translation by fixing a typo
>>>>>> but I can't find the translation. Where is it?
>>>>>
>>>>> All available translations are in "po/" directory of Git, such as
>>>>> po/de.po, po/pt_PT.po, etc. And all l10n teams, maintainers
>>>>>  and locations of the official repositories are listed in "po/TEA=
MS" file.
>>>>>
>>>>> I can't find a Spanish translation either, but there is a Portugu=
ese
>>>>> translation and the maintainer is Marco Sousa.
>>>>>
>>>>> I don't know how much differences between Spanish and Portuguese.
>>>>> Maybe the typo you found is belongs to "po/pt_PT.po"?
>>>>>
>>>>
>>>> No way... My "git" is translated into Spanish, that's why it
>>>> surprises me that the translation is not there...
>>>>
>>>
>>> What's your platform? version of your platform? git --version?
>>> And what's the output message (with the typo you found)?
>>> Maybe we could "git grep" in Git source code or google the output
>>> message.
>>>
>> So
>>
>> $ uname -a
>> Linux pantani 3.11.0-14-generic #21-Ubuntu SMP Tue Nov 12 17:07:40 U=
TC
>> 2013 i686 i686 i686 GNU/Linux
>>
>> $ git --version
>> git version 1.8.3.2
>>
>> $ locale
>> LANG=3Des_ES.UTF-8
>> LANGUAGE=3Des_ES
>> LC_CTYPE=3D"es_ES.UTF-8"
>> LC_NUMERIC=3D"es_ES.UTF-8"
>> LC_TIME=3D"es_ES.UTF-8"
>> LC_COLLATE=3D"es_ES.UTF-8"
>> LC_MONETARY=3D"es_ES.UTF-8"
>> LC_MESSAGES=3D"es_ES.UTF-8"
>> LC_PAPER=3D"es_ES.UTF-8"
>> LC_NAME=3D"es_ES.UTF-8"
>> LC_ADDRESS=3D"es_ES.UTF-8"
>> LC_TELEPHONE=3D"es_ES.UTF-8"
>> LC_MEASUREMENT=3D"es_ES.UTF-8"
>> LC_IDENTIFICATION=3D"es_ES.UTF-8"
>> LC_ALL=3D
>>
>> I've downloaded git sources with
>> $ apt-get source git
>> $ apt-get source git-core
>> ...
>>
>> and grep the string, nothing. I've also forked the git repo and grep
>> and nothing either.
>>
>> The message is
>> msgid ""
>> "  (use \"git checkout -- <file>...\" to discard changes in working
>> directory)"
>>
> Oh, and the incorrect message I'm getting is
>
> #   (use =ABgit checkout -- <archivo>...=AB para descartar cambios en=
 le
> directorio de trabajo)
>
>
> El lun 09 dic 2013 16:45:17 CET, David Rodr=EDguez de Dios escribi=F3=
:
>

--
Jiang Xin
