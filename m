From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Subject: Re: Ubuntu may break Git upstream translations
Date: Tue, 10 Dec 2013 10:52:39 +0000
Message-ID: <CAA0ZMxhYounVC0_mpMmty=wbh5fPmG0+=da9pQQ9i0UnciRY8Q@mail.gmail.com>
References: <CANYiYbF--_51hJmp=28ucwBa6YEuUn97kTAd87POuqrD4SU5gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?David_Rodr=C3=ADguez_de_Dios?= 
	<deivid.rodriguez@gmail.com>, Git List <git@vger.kernel.org>,
	Paco Molinero <paco@byasl.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 11:52:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqKvr-00011A-TB
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 11:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab3LJKwq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Dec 2013 05:52:46 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:35185 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab3LJKwk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Dec 2013 05:52:40 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so7404620pbb.14
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 02:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1dCIcVLSCXWnSLg/TscuwQDjHlnW31fnTX1UKEiuY8M=;
        b=YIAPj/HErzBYE7AL7APtcgn7mTppZ2W+Jl6ljPqVnschFScpNoISdg386CXBznTAo4
         ToEhOvjmtDSsdXzzXmIe8KvkU01TenojIpFLpv60rMTTMYUb9YjcrxwIZAxVdAeflYuV
         wjNBjIzvC7d3FLugiKhxeNBriIb5IBwOpBcEow/feCmoY5Z91W6zSugSxizaE6YzkYQn
         /4160uBr42dC/Q2sy53S1Tdcs1wZ4Iycjozc2kt7SYmTOFmEvH0fb2emhaoUtkKivjFB
         tu5M2L5SqxfGJPylrGaw3gX7mCGtqqRwUV7YS8oiqnjTba/CA5SZRyZXVT4luazDOVoO
         yogA==
X-Gm-Message-State: ALoCoQluLfeQfDrm9qDpobegPW4UFh6sRxSuRjMukM98sExEBNCTJtogFPPgUU6nW6jcky0CQZkh
X-Received: by 10.68.219.72 with SMTP id pm8mr2109785pbc.164.1386672759640;
 Tue, 10 Dec 2013 02:52:39 -0800 (PST)
Received: by 10.70.19.97 with HTTP; Tue, 10 Dec 2013 02:52:39 -0800 (PST)
In-Reply-To: <CANYiYbF--_51hJmp=28ucwBa6YEuUn97kTAd87POuqrD4SU5gw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239133>

Hello all,

On Tue, Dec 10, 2013 at 9:56 AM, Jiang Xin <worldhello.net@gmail.com> w=
rote:
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

Ubuntu is a distribution which does have a wide variety of users.
Typically users use stable releases, or even LTS releases (every 2
years). Given different schedules across all projects, naturally
Ubuntu ships a snapshots across all packages available at the time. On
the other hand our users and translators expect to be able
continuously improve & provide translations across a wide snapshot of
packages. Therefore in the beginning of the Ubuntu project
translations from all core packages (those that are in the "main"
portion of the archive) were imported into the launchpad translation
component. Ubuntu translation teams can update translations using the
web interface, contributing from one string or all of them. All new
translations done in launchpad, are done under permissive BSD license
and are shared across the infrastructure, such that translators get
helpful suggestions and don't have translate the same term over again
(and/or different from how it's used across the operating system).
These translations do not require one to know version control systems,
upstream, mailing lists. But those translation updates are pushed out
automatically to the users at point releases (or more often, if
manually triggered). You can see the translation statistics for Ubuntu
12.04 LTS at [1]

All of these translations are done in good faith. Or at times by
frustrated users that cannot see something in their own language and
can't take for an answer "contribute upstream, wait for new release,
wait for that to be packaged & upgrade to new release to get them".

Naturally, maintenance cost of translations downstream is significant.
And where possible we do try to redirect translators upstream. E.g.
there are good translators links / cooperation to Debian (package
descriptions, debconf question templates), d-i, GNOME, etc.

In an ideal world there would be enough community developer to manual
handle all new translations and redirect / introduce them to
upstreams. Unfortunately that is not the case. And on behalf of the
Ubuntu project, I do apologize for any inconvenience caused. But
please do, try to understand the distribution perspective on the
overall problem with localisation and internationalization.

As usual with any Distribution originated bugs, they should be filed
with the distribution. For git package in Ubuntu that would be by
executing on the command line $ ubuntu-bug git, or via launchpad
website at http://bugs.launchpad.net/ubuntu/+source/git/+filebug?no-red=
irect
=2E Again I apologize that a distribution induced bug report arrived
direct to upstream, instead being filtered in the distribution.

About this specific template. I believe I'm listed as "the owner"
simply because i was the last one to trigger package upload, and thus
upstream translation templates import (by the looks of things by
syncing the package from Debian). Upstream translations always take
precedence.

Naturally git/master evolves, and strings are added/removed/changed
and thus translations do "bit-rot", none-the-less I hope there are
translations in launchpad that would still be relevant. An export
tarball in po/pot format can be requested for both currently
translatable git source package templates [2,3], which i have now done
and uploaded to a publically accessible location [4]. It of-course
needs further analysis / merging into git/master. Is there a
translation platform used to manage git translations? Do note that
tarballs have a mixture of upstream originated translations and
launchpad contributed. They are not my copyright, but copyright of the
respective translators, contributed under a permissive BSD license.

I'm not involved in neither Launchpad Translations nor Ubuntu
Translations. I am simply a Debian Developer and an Ubuntu Core
Developer. I will get in touch with our translation & community
coordinators to see how it is best to forward translations to git
upstream.

In general, any technical inquiries about Ubuntu project can be
directed to ubuntu-devel-discuss@lists.ubuntu.com [5] for a fast
response by most relevant people involved.

[1] https://translations.launchpad.net/ubuntu/precise
[2] https://translations.launchpad.net/ubuntu/saucy/+source/git/+pots/g=
it-gui/+export
[3] https://translations.launchpad.net/ubuntu/saucy/+source/git/+pots/g=
it/+export
[4] http://people.canonical.com/~xnox/git-i18n/
[5] https://lists.ubuntu.com/mailman/listinfo/ubuntu-devel-discuss

Regards,

Dimitri.

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
>>>>>>  and locations of the official repositories are listed in "po/TE=
AMS" file.
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
