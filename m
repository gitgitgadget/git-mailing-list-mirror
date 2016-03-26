From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [GSoC] A late proposal: a modern send-email
Date: Sat, 26 Mar 2016 18:21:29 +0800
Message-ID: <CAKqreuz-0DMPgZKKthSQk0oBwL=6GiiT9wj2SMPS--fiwfpwGw@mail.gmail.com>
References: <CAKqreuyC8p9m_dgVpXCiT_hf=8qBA_5kZ5NABQGx0QDOiCBbww@mail.gmail.com>
	<xmqqzitm2zkj.fsf@gitster.mtv.corp.google.com>
	<CAKqreux1S2ioEEjPPCkyz1NJnXJ1RyiWdM5thZD607PkL0HKuQ@mail.gmail.com>
	<CAFZEwPOa3i9XTF-5ZWZXvXfAzpyFojz57JBy4_WahF0Y4Q9DWQ@mail.gmail.com>
	<CAKqreuyN--AjjhTcTx1+Baec=j-6TJPj8Rwoxre86TJp2UMGDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 11:21:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajlLf-0006Km-7K
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 11:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbcCZKVe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Mar 2016 06:21:34 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35027 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbcCZKVc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Mar 2016 06:21:32 -0400
Received: by mail-oi0-f42.google.com with SMTP id h6so65001231oia.2
        for <git@vger.kernel.org>; Sat, 26 Mar 2016 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=I40hEZhrINKhepzfvTbW4Nx2DE56htu+PLUfymMDyfA=;
        b=a+yHFSwvNsp6Dh30lmAs2FdaAWBoThWCAJyL4jyhVEhaRoiCUkkmOxz5eZp9hTA+dI
         sruRmT36QoImClm8iORaDhoI81/T0HNUU1kjEgiwbwWdSyLEHCBEpv9iBDZNHGuR82je
         o/IDPJOC3eBtZNi/b4V8KHlV4TJpUANb1n4n5nlDV4x5fX2Bi2FRRWLEHNfsZDIljgaz
         5Wd4Z75lcUvuI+hqOc6kUVH2QiM/frcV6FK4HLtVAGSosPARiJecw3RBwAPSD8i5f7eK
         5dw3mKXeTo0MuJmO6/s8EDmM3Abf2VRl6wCtYd1OZ+YzV+V9MiCnenfkFeFzLY9Z9JL2
         KrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=I40hEZhrINKhepzfvTbW4Nx2DE56htu+PLUfymMDyfA=;
        b=DMgguxQ6gm06d3+8uIdZFD2SkpzBCLHlciCXyUora+zOBKLQjzWYumlS3ndKtQgzpa
         6VbKaGkj6uxCh46ocuIoHKcwYRJ/MyC1n/A3+RGmT9dUGQAI09GLF7IQPr03H61EMarc
         Kiwe8exH9eUY7FjcZ5S14qUI1Sw9JPwYzAsC++yxDNzjn69P8GJpwn6kdDuw/F+UFlfj
         zxYdGXkBV2oARZTAoyIaGJvSBodA3Roq/UPVKaLlKLDtB2QCGUUL772jLD5jobzWrfed
         sTSZvC6VrHOc7+X9gKYZsVeLAlXr1tJDxwcxm8cZndHJU/8gHLhB0qQbt1st2oqvLCJx
         HBeg==
X-Gm-Message-State: AD7BkJIETRWZVQolhbI5p/UKmvxvEYLjOoCtJ7k9Try6L/yepNXjyYsnh8fYtq9phF/+QwDKavxhdr5Id4gKmQ==
X-Received: by 10.157.49.116 with SMTP id v49mr8679575otd.97.1458987689970;
 Sat, 26 Mar 2016 03:21:29 -0700 (PDT)
Received: by 10.157.27.250 with HTTP; Sat, 26 Mar 2016 03:21:29 -0700 (PDT)
In-Reply-To: <CAKqreuyN--AjjhTcTx1+Baec=j-6TJPj8Rwoxre86TJp2UMGDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289981>

2016-03-26 17:52 GMT+08:00 =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.=
com>:
> 2016-03-26 14:18 GMT+08:00 Pranit Bauva <pranit.bauva@gmail.com>:
>> On Sat, Mar 26, 2016 at 7:43 AM, =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiq=
un@gmail.com> wrote:
>>> 2016-03-26 2:16 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
>>>> =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:
>>>>
>>>>> # Purpose
>>>>> The current implementation of send-email is based on perl and has=
 only
>>>>> a tui, it has two problems:
>>>>> - user must install a ton of dependencies before submit a single =
patch.
>>>>> - tui and parameter are both not quite friendly to new users.
>>>>
>>>> Is "a ton of dependencies" true?  "apt-cache show git-email"
>>>> suggests otherwise.  Is "a ton of dependencies" truly a problem?
>>>> "apt-get install" would resolve the dependencies for you.
>>>
>>> There are three perl packages needed to send patch through gmail:
>>> - perl-mime-tools
>>> - perl-net-smtp-ssl
>>> - perl-authen-sasl
>>>
>>> Yes, not too many, but is it better none of them?
>>
>> Are you sure using a GUI does not have any dependencies?
>>
>>> What's more, when I try to send mails, I was first disrupted by
>>> "no perl-mime-tools" then by "no perl-net-smtp-ssl or perl-authen-s=
asl".
>>> Then I think, why not just a mailto link?
>>>
>>>>> # Plan
>>>>> So I propose to implement following:
>>>>> - Allow user to send mail via a [`mailto`
>>>>> link](https://en.wikipedia.org/wiki/Mailto). so that users could
>>>>> complete the mail in their favorite email clients such as gmail, =
mutt,
>>>>> alpine and even gmail for android through
>>>>
>>>> IIRC, GMail on Android is incapable of sending a "text/plain", so
>>>> that part may not fly well.
>>>
>>> Really? As much as I known, GMail on Android is capable of sending
>>> a "text/plain" while Inbox is not.
>>
>> How do you plan in integrating GMail on Android so that it can send
>> patches which exists on your computer?
>
> No, if you could have termux a try, you will find that it's suitable =
for simple
> development. it has a apt, so you could have clang, neovim, tmux, cma=
ke
> and so on.
>
> In fact, I recently use my nexus 7 with termux as a portable
> development environment.
> A bluetooth keyboard is needed, of course.

This is not applicable to all people, but It make the git more free, is=
n't it?

>>>>> - Build a simple email client (maybe a web components based web a=
pp or
>>>>> wxwidgets based GUI client, they are both cross-platform) which i=
s
>>>>> easy to use for sending patch without disrupting the mailbox form=
at.
>>
>> I think introducing a GUI may lead to much more dependencies. Many g=
it
>> developers already have perl packages in their system but they don't
>> have wxwidgets.
>
> wxwidgets seems not a good choice. But if I build the GUI via web app=
,
> I could import required js and css from Internet directly, so the use=
rs do
> not need the dependencies on their computer.
>
>>>> I suspect it would yield a better result if the plan were to updat=
e
>>>> a popular email client and make it possible to tell it to read an
>>>> existing text file (i.e. mbox) without corrupting its contents.
>>>> People do not have to learn a new mail client if done that way.
>>>
>>> Maybe a plugin? I'm not sure.
>>
>> You could make a plugin. That would simply things.
>>
>>> If above `mail-to` is implemented, user could just using any mail
>>> client, but a mail client adaptive for patch would be better:
>>> - Do not allow user to edit the diff part
>>> - always 'plan/text'
>>> - visual
