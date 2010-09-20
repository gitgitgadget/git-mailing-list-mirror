From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: use base64 instead of quoted-printable in format-patch headers
 (was Re: Make format-patch produce UTF-8 `From:' header)
Date: Mon, 20 Sep 2010 13:46:40 +0000
Message-ID: <AANLkTim-vfrxGbdfXeef81uP29NSSzutHbs-yhhQtiA8@mail.gmail.com>
References: <AANLkTin_5qzDkMU_1stYZcJpfW-W7K0kxy=0K2dA7SwO@mail.gmail.com>
	<AANLkTinOa+s-28PYXHhtKr_POu2D33ibfgKDKk4Wqi=9@mail.gmail.com>
	<87y6axshmt.fsf_-_@gmail.com>
	<87mxrda6e3.fsf@windlord.stanford.edu>
	<87k4mgsj1j.fsf_-_@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Russ Allbery <rra@debian.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Stefan-W. Hahn" <stefan.hahn@s-hahn.de>,
	=?UTF-8?Q?Lukas_Sandstr=C3=B6m?= <luksan@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Himpel <chressie@googlemail.com>
To: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 15:46:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxghn-00036p-Pm
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 15:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011Ab0ITNqp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 09:46:45 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:48941 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609Ab0ITNqo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 09:46:44 -0400
Received: by pxi10 with SMTP id 10so1124322pxi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DAD6zxan37AjTTC/NMlBGZf6ahCklMT5W69E1q3U1I8=;
        b=u8vFdSfVkSZcdEpSoAWaQA6nLEATDDx/sEcmgZ3fPn9Cs+yAALBJTfyGk3gtN/iGg8
         x7KSClmHL/NfplLfV7pLuXdc3GfzoVs9L9ouxbU8vGEv2Sp2mzRBPAEnnSFIc2rvVCyV
         54sQIPeD8M4atynjLsMlM/YpejVRczNDbvZEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aM0t5TwMgwq4mFZL5+NXvsYjltcIO2I1xjSaWsvfY9M+fx9INFE2UMW+7SqpnpVN9U
         qYm3S8l5JgE8z+OsRxCbvUhpYmmYKAeLiK5/BNeI4ehO4/K3JcZ1fXSvUp5+s/KQht0b
         C3JNhrLA5pqRjtUWT6eqGvypgmN/lx0C6uWKM=
Received: by 10.114.103.8 with SMTP id a8mr9964060wac.159.1284990401191; Mon,
 20 Sep 2010 06:46:41 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 20 Sep 2010 06:46:40 -0700 (PDT)
In-Reply-To: <87k4mgsj1j.fsf_-_@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156623>

On Mon, Sep 20, 2010 at 12:20, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepne=
m@gmail.com> wrote:
> Russ Allbery <rra@debian.org> writes:
>
>> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com> writes:
>>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>>> Maybe format-patch could provide another mode to produce patches t=
hat
>>>> do not include unnecessary headers (in particular, leaving out the
>>>> difficult "From " line and using UTF-8 instead of quoted-printable=
 for
>>>> the "From: " line).
>>
>>> FWIW, the quoted-printable `From:' encoding has always annoyed me -=
- I
>>> replace it manually with my name & address in UTF-8 every time I se=
nd
>>> out a patch. What is the reason format-patch does that (and if ther=
e is
>>> a reason not to change the default, could an option to disable it b=
e
>>> provided)?
>>
>> Well, it's required if you're going to actually send the result dire=
ctly
>> as a mail message, since the RFC 5322 format requires headers be enc=
oded
>> using RFC 2047 encoding.
>
> Right... thanks for pointing that out. So the problem I'm seeing is
> actually different -- some software (including Mutt and the mailing
> list/archive software used by this list) appears to have problems wit=
h
> quoted-printable, but not with base64.
>
> To take my name as example: when I send mail from Mutt, it is encoded=
 as
> "=3D?utf-8?B?xaB0xJtww6FuIE7Em21lYw=3D=3D?=3D", i.e. base64, and both=
 Mutt and
> the vger archive seem to decode it properly, whereas the
> quoted-printable version produced by fromat-patch, i.e.
> "=3D?utf-8?q?=3DC5=3DA0t=3DC4=3D9Bp=3DC3=3DA1n=3D20N=3DC4=3D9Bmec?=3D=
" in this case, is left
> undecoded by Mutt and mis-decoded in the ML archive as far as I have
> seen. I'm not sure about other software (Gnus seems to be able to dea=
l
> with both correctly), but perhaps it would make sense to switch to
> base64 in format-patch?

The advantage of quoted-printable is the printable part. It's at least
somewhat human readable, e.g.:

    =3D?UTF-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D20Bjarma=
son?=3D

I have some chance of spotting a typo or something in there if I look
at the raw E-Mail (which I often do), but not with base64.

Are we sure we're correctly encoding quoted-printable? E.g. maybe
?UTF-8? instead of ?utf-8? would work? It seems odd that a widely used
client like Mutt would screw up such a widely used encoding.
