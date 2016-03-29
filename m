From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [GSoC] A late proposal: a modern send-email
Date: Wed, 30 Mar 2016 01:47:41 +0200
Message-ID: <CACBZZX4ezKtFqyC7bnNhtvcyEkXMr8_83u_p=zA0ZvqYipzNLQ@mail.gmail.com>
References: <CAKqreuyC8p9m_dgVpXCiT_hf=8qBA_5kZ5NABQGx0QDOiCBbww@mail.gmail.com>
 <xmqqzitm2zkj.fsf@gitster.mtv.corp.google.com> <CAKqreux1S2ioEEjPPCkyz1NJnXJ1RyiWdM5thZD607PkL0HKuQ@mail.gmail.com>
 <CACBZZX6q87dw6UW9z+2bAvvWu0WZcYCMD8gxW8MchHwd8Rv3kw@mail.gmail.com> <CAKqreuy0RwgxqrRf7t1AU8dM2VtkvD9gd3VnzVRe-GEieVXDNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 01:48:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al3Mo-0001hy-6G
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 01:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbcC2XsE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 19:48:04 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35475 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbcC2XsD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 19:48:03 -0400
Received: by mail-qg0-f42.google.com with SMTP id y89so26055221qge.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 16:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rnn3NPCheQhmJRbms0KNhl1mFkgNKX5NCcSLYDq7YCg=;
        b=QyYuM9AyHAxbAMl90QJ9J1Cp2IN02a46UpWbhYyb9tJ5YmEk10ckX66yzvxROKyGvB
         eUHodcSU657PB9HAse+UN2lHoa76qgvs3xtSBEUrgBP/KEi8ffHvLll6/JVje64Zn8X8
         t+4GnwlpSKJCygVf6YCfcngewP6ONgPt2zBF55BaZSDBg721I4aDIf9gpncPWAmD0UGG
         ljPcxL7XIlAHL6WuvhknkcJjD4DxAu1K/GtuYqg9mD6G8+FzUkEwyL4RGbs6vIyD04kF
         HO/aXHly0w79e0OfjoHEjKnuTU1YkHclKCcskEUctZWzSP+UDWj7o8jg83xVbTQpsMAx
         ilLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rnn3NPCheQhmJRbms0KNhl1mFkgNKX5NCcSLYDq7YCg=;
        b=UN/IBly+wyAobx546Caj+TxKyqcgizMwDxNTKfjX19C2xBUGUVxwvtu/n9F4ONLIwy
         i5d58ySmdwkXf4gSR+X4dN2Fm6pa7nqhwP+mILiT0uY0BKVx1Og8WeQkH033tGP1luvk
         KslFmytTyH6Oa19/JkknEdcwV917qsOENXcrkr+KGRRkxkNooh3Rla7AfAt2pDmxnbO2
         SxkgxUSS3IHFDYCQAP5+uqQ+pfHTYQnMobF/FAMTHDxIS5P4KFOMUJUF1yvkNK2tAcPw
         coj4RHJDiEx9/bu7fBBYMo9+6+bZ1S+W2sUZMTHTBB4f2i4H7sbq/s7z7y2hhA3xQCvK
         YWjw==
X-Gm-Message-State: AD7BkJIZcpm72VXWTALgYc1UJjqMcW5gyjJTMuRGuZaDd7phS2tIDJC0HbFVFFCex1GPL0sCRR/QL9d1arbhTA==
X-Received: by 10.140.106.228 with SMTP id e91mr6224430qgf.75.1459295281394;
 Tue, 29 Mar 2016 16:48:01 -0700 (PDT)
Received: by 10.55.77.82 with HTTP; Tue, 29 Mar 2016 16:47:41 -0700 (PDT)
In-Reply-To: <CAKqreuy0RwgxqrRf7t1AU8dM2VtkvD9gd3VnzVRe-GEieVXDNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290225>

On Tue, Mar 29, 2016 at 6:17 AM, =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@=
gmail.com> wrote:
> 2016-03-29 0:49 GMT+08:00 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <ava=
rab@gmail.com>:
>> On Sat, Mar 26, 2016 at 3:13 AM, =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiq=
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
>>>
>>> What's more, when I try to send mails, I was first disrupted by
>>> "no perl-mime-tools" then by "no perl-net-smtp-ssl or perl-authen-s=
asl".
>>> Then I think, why not just a mailto link?
>>
>> I think your proposal should clarify a bit who these users are that
>> find it too difficult to install these perl module dependencies. Use=
rs
>> on OSX & Windows I would assume, because in the case of Linux distro=
s
>> getting these is the equivalent of an apt-get command away.
>
> In fact, I'm not familiar with the build for OSX or Windows.

The core of your proposal rests on the assumption that
git-send-email's implementation is problematic because it has a "ton
of dependencies", and that this must be dealt with by implementing an
alternate E-Mail transport method.

But you don't go into how this is a practical issue for users exactly,
which is the rest of the proposal. I.e. "make it friendly for users".
Let's leave the question of creating an E-Mail GUI that's shipped with
Git aside.

Correct me if I'm wrong but don't we basically have 4 kinds of users
using git-send-email:

1) Those who get it from a binary Windows package (is it even packaged =
there?)
2) Also a binary package, but for for OSX
3) Users installing it via their Linux distribution's package system
4) Users building it from source on Windows/OSX/Linux.

I'm in group #3 myself for the purposes of using git-send-email and
have never had issues with its dependencies because my distro's
package management takes care of it for me.

I don't know what the status is of packaging it is on #1 and #2, but
that's what I'm asking about in my question, if this becomes a
non-issue for those two groups (if it isn't already) isn't this
question of dependencies a non-issue?

I.e. why does it matter if git-send-email has N dependencies if those
N are either packaged with the common Windows/OSX packages that most
users use, or installed as dependencies by their *nix distro?

 Group #4 is small enough and likely to be a git.git contributor or
distro package maintainer anyway that this issue doesn't matter for
them.

>> If installing these dependencies is hard for users perhaps a better
>> thing to focus on is altering the binary builds on Git for platforms
>> that don't have package systems to include these dependencies.
>
> Why `mailto` not a good choice? I'm confusing.

I'm not saying having this mailto: method you're proposing isn't good
in itself, I think it would be very useful to be able to magically
open git-send-email output in your favorite E-Mail client for editing
before sending it off like you usually send E-Mail.

Although I must say I'd be seriously surprised if the likes of git
formatted patches survive contact with popular E-Mail clients when the
body is specified via the body=3D* parameter, given that we're sending
pretty precisely formatted content and most mailers are very eager to
wrap lines or otherwise munge input.

I'm mainly trying to get to the bottom of this dependency issue you're
trying to solve.

>> In this case it would mean shipping a statically linked OpenSSL sinc=
e
>> that's what these perl SSL packages eventually depend on.
