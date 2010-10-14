From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Stable ab/i18n branch
Date: Thu, 14 Oct 2010 21:18:49 +0000
Message-ID: <AANLkTi=LEzQu5_EyJ_ncRmsHfufG=AnEv9+eTQuqh5W7@mail.gmail.com>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
	<AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
	<20101014200027.GA18813@burratino>
	<AANLkTim-2V_XtWVLFbWS_A-0rFNmuDvtR58aanxKL-O2@mail.gmail.com>
	<20101014205413.GD28958@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 23:19:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6VCc-0005bA-CX
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 23:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200Ab0JNVSw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 17:18:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45353 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756170Ab0JNVSv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 17:18:51 -0400
Received: by fxm4 with SMTP id 4so27296fxm.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 14:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gl+TWQOEvJywyeeHlA7f+Bvg3KsHu5Kdei8ad4qvxU8=;
        b=wFC9RBeQcgjaHP8AGmNOvECi82g6DUO9AK+y2wNpID7vbZKYpPKOyO5l8vHiKzrXLs
         P42hbG9kRdPDFZppx4yd/StcArvq9D3sqCeQEbC0vSZ58ykvi1hCMJk/3iQHnGZk0psG
         vo2jeLU9TTe+PHCB27X8zERGmLrvuIVrUeEGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YXLwxMc6Z+oVhoe1t5gIXbgnbyBz649s39z5ne5fUW9bdKKCs7ljoCKCUQnv/pm0wb
         uPqwaomH/L5/WGg0EQ72HfNQW01GswXYxaptecFaWwE03jjSkbJR690WtJaQj89EWI63
         5kr36/xZ+QWE6SxDobQhRBkVS6WalfX3MM71Q=
Received: by 10.103.231.20 with SMTP id i20mr853822mur.13.1287091129494; Thu,
 14 Oct 2010 14:18:49 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Thu, 14 Oct 2010 14:18:49 -0700 (PDT)
In-Reply-To: <20101014205413.GD28958@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159076>

On Thu, Oct 14, 2010 at 20:54, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> I could do that, but I've been hoping that it just gets picked up fo=
r
>> the `next -> master` process of git.git itself and *that* becomes th=
e
>> stable target.
>>
>> But I have no idea what's going on at the other end, i.e. there's no
>> comments about it in the "What's cooking in git.git" posts or
>> elsewhere. So it's hard to know whether something like this is neede=
d.
>
> Probably it is a difference in culture between e.g. the Linux kernel
> and other projects. =C2=A0In the world I'll stereotype as the Linux k=
ernel
> world, forks are considered good! =C2=A0Developments everyone agrees =
is
> good in the long run (like the Linux realtime tree) are not
> necessarily merged, for years even, the justification being that
> until the _immediate_ benefits for Linus outweigh the risks for Linus=
,
> it just doesn't make sense to merge.
>
> This avoids bloat and bugs from code that is not being used by anyone=
,
> while allowing development to continue to happen.
>
> Now git.git is not the Linux kernel. =C2=A0In particular, Junio provi=
des
> the extra service of a working "proposed updates" branch, including
> changes that are not necessarily to be part of the next release. =C2=A0=
But
> the underlying principle is the same: until there is an _immediate_
> benefit to including a feature in releases that does not outweigh
> the downsides, it just does not happen.
>
> What that means: interested parties need to start testing the l10n
> code. =C2=A0There should be a reliable upstream for users of this
> feature and ideally that should not be Junio unless he wants to (and
> =C3=86var, I think you have been doing a good job of that, just sayin=
g it's
> valuable). =C2=A0The code's not going to get into shape otherwise.

There's definitely a chicken & egg problem here. Unlike what you'd get
in the case of Linux this isn't an unstable device driver that
somebody needs. It's just something that optionally makes life easier
for people that pretty much by definition don't follow this mailing
list.

So it's hard to build an upstream of users. With all other free
software programs that happens by the canonical upstream version of
the program being internationalized. The distros then picking up that
version and give it to end users.

So what I've tried to do to make this acceptable for inclusion in core
is to make this whole thing a no-op unless it's explicitly
requested.

You can skip it altogether with NO_GETTEXT=3DYesPlease, and even with
NO_GETTEXT=3D it won't get used unless you've explicitly set LANGUAGE=3D=
,
or LC_*=3D variables accordingly.

Maybe I could do something to make it even less intrusive, e.g. have a
core.i18n=3Dyes config variable. But I haven't gotten any feedback on
that so I've kept the current scheme of making it behave like pretty
much every other internationalized program out there.

>> It's been about as ready as it's ever going to get for about a month
>> now.
>
> I hope not! =C2=A0e.g. the LC_CTYPE problems have not been resolved (=
and yes,
> that would be a regression for people using the it_IT.UTF-8 locale).

The LC_CTYPE problems I'm aware of were worked around in this patch:

    gettext.c: work around us not using setlocale(LC_CTYPE, "")

While that's not a perfect solution I think it's the best we're going
to get for the time being. I'm pretty convinced that if I tried to
make git itself LC_CTYPE-safe as part of this already huge series it'd
never get merged. Having messages with question marks from strerror()
on certain platforms is an OK compromise in my opinion.

Are there any other LC_CTYPE related issues I'm overlooking?

>> I'm starting to get the feeling that there isn't much interest in i1=
8n
>> support at all.
>
> I'm interested in it, at least.

That's good to hear.
