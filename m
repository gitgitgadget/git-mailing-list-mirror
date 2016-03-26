From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [GSoC] A late proposal: a modern send-email
Date: Sat, 26 Mar 2016 17:52:29 +0800
Message-ID: <CAKqreuyN--AjjhTcTx1+Baec=j-6TJPj8Rwoxre86TJp2UMGDg@mail.gmail.com>
References: <CAKqreuyC8p9m_dgVpXCiT_hf=8qBA_5kZ5NABQGx0QDOiCBbww@mail.gmail.com>
	<xmqqzitm2zkj.fsf@gitster.mtv.corp.google.com>
	<CAKqreux1S2ioEEjPPCkyz1NJnXJ1RyiWdM5thZD607PkL0HKuQ@mail.gmail.com>
	<CAFZEwPOa3i9XTF-5ZWZXvXfAzpyFojz57JBy4_WahF0Y4Q9DWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 10:52:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajktd-0000wj-K3
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 10:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbcCZJwb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Mar 2016 05:52:31 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34559 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbcCZJwa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Mar 2016 05:52:30 -0400
Received: by mail-ob0-f172.google.com with SMTP id kf9so65792701obc.1
        for <git@vger.kernel.org>; Sat, 26 Mar 2016 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=/wcn1xkUI0y97+y00hVABOx0KAr4fGqKWrHiGaw8Ey0=;
        b=q8pizqTFbBfA3lMDVJLo0/3gd34RrIDUQxaxO1+UkUFw3xnLwNIkHboqyygDz/LdFY
         34TFGe9034dzTy7f0vVOmqQgDnwcYYbG9nS1LMdNxizlala4VOBAIyBK8XDlb2PkefiC
         f0HliZ58kInJtqX2kfU9Bewe+cG9BUd5Z4Tn8736bpTAhcuayw4zrf9iIsKYFruCXVm/
         Q2asWX9lD22zEtj+j/MSYYfIHsAREHmKvlzf6wL9N1CtGtMMB5GRZMVlYlDCkpQooXsP
         e9yHvWkjv+N2XXo4ZT2JRLGox51rNQvbD0qgVhxK7x68V1GPXYrEChXbPAC1KuBPRyzu
         eWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=/wcn1xkUI0y97+y00hVABOx0KAr4fGqKWrHiGaw8Ey0=;
        b=dZOC0/VcvtFH+0c+cKW/lvXoK9WefBkoqFHtSNDhj9ujp7zgx7KNsYwmxt/v/tgGP6
         dG84+7xvWGidFrHw0NjMrW63Ii1gS8f2ufAj29yQhn8ZE8waNDXVvxNXHRTSG7PL51nv
         OdINH4EswFmG7Fkcy+FLI4vfYel9yLChDK5Fhs2mAb90vGPtUFvt6qd2fyRvssG0jYnu
         kKhhfsji0N8nKR7m0pbTyvxRcEJa063m7EZGJqSBtFoqrlj2uqBpPNZd3g1E1OfSBCXx
         Ib0n+2HtGUjGuIZlwxf0vviJfvUX0LjPK5HPkJ9nH/nALtelPSzyLHFRCE5AVkBMLNql
         cXCw==
X-Gm-Message-State: AD7BkJI82we041IDUFs1Dgi/ZGNzv08I9swguQuqSuKgYhnltoi3owLl3FBsAv+imRILFOsf1pPDx8G1yhjdnQ==
X-Received: by 10.60.147.228 with SMTP id tn4mr8172848oeb.33.1458985949645;
 Sat, 26 Mar 2016 02:52:29 -0700 (PDT)
Received: by 10.157.27.250 with HTTP; Sat, 26 Mar 2016 02:52:29 -0700 (PDT)
In-Reply-To: <CAFZEwPOa3i9XTF-5ZWZXvXfAzpyFojz57JBy4_WahF0Y4Q9DWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289979>

2016-03-26 14:18 GMT+08:00 Pranit Bauva <pranit.bauva@gmail.com>:
> On Sat, Mar 26, 2016 at 7:43 AM, =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqu=
n@gmail.com> wrote:
>> 2016-03-26 2:16 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
>>> =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:
>>>
>>>> # Purpose
>>>> The current implementation of send-email is based on perl and has =
only
>>>> a tui, it has two problems:
>>>> - user must install a ton of dependencies before submit a single p=
atch.
>>>> - tui and parameter are both not quite friendly to new users.
>>>
>>> Is "a ton of dependencies" true?  "apt-cache show git-email"
>>> suggests otherwise.  Is "a ton of dependencies" truly a problem?
>>> "apt-get install" would resolve the dependencies for you.
>>
>> There are three perl packages needed to send patch through gmail:
>> - perl-mime-tools
>> - perl-net-smtp-ssl
>> - perl-authen-sasl
>>
>> Yes, not too many, but is it better none of them?
>
> Are you sure using a GUI does not have any dependencies?
>
>> What's more, when I try to send mails, I was first disrupted by
>> "no perl-mime-tools" then by "no perl-net-smtp-ssl or perl-authen-sa=
sl".
>> Then I think, why not just a mailto link?
>>
>>>> # Plan
>>>> So I propose to implement following:
>>>> - Allow user to send mail via a [`mailto`
>>>> link](https://en.wikipedia.org/wiki/Mailto). so that users could
>>>> complete the mail in their favorite email clients such as gmail, m=
utt,
>>>> alpine and even gmail for android through
>>>
>>> IIRC, GMail on Android is incapable of sending a "text/plain", so
>>> that part may not fly well.
>>
>> Really? As much as I known, GMail on Android is capable of sending
>> a "text/plain" while Inbox is not.
>
> How do you plan in integrating GMail on Android so that it can send
> patches which exists on your computer?

No, if you could have termux a try, you will find that it's suitable fo=
r simple
development. it has a apt, so you could have clang, neovim, tmux, cmake
and so on.

In fact, I recently use my nexus 7 with termux as a portable
development environment.
A bluetooth keyboard is needed, of course.

>>>> - Build a simple email client (maybe a web components based web ap=
p or
>>>> wxwidgets based GUI client, they are both cross-platform) which is
>>>> easy to use for sending patch without disrupting the mailbox forma=
t.
>
> I think introducing a GUI may lead to much more dependencies. Many gi=
t
> developers already have perl packages in their system but they don't
> have wxwidgets.

wxwidgets seems not a good choice. But if I build the GUI via web app,
I could import required js and css from Internet directly, so the users=
 do
not need the dependencies on their computer.

>>> I suspect it would yield a better result if the plan were to update
>>> a popular email client and make it possible to tell it to read an
>>> existing text file (i.e. mbox) without corrupting its contents.
>>> People do not have to learn a new mail client if done that way.
>>
>> Maybe a plugin? I'm not sure.
>
> You could make a plugin. That would simply things.
>
>> If above `mail-to` is implemented, user could just using any mail
>> client, but a mail client adaptive for patch would be better:
>> - Do not allow user to edit the diff part
>> - always 'plan/text'
>> - visual
