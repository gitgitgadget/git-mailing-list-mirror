From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/4] Makefile: move "Platform specific tweaks" above LIB_{H,OBJS}
Date: Mon, 15 Nov 2010 17:16:39 +0100
Message-ID: <AANLkTi=_LOczM=rC4dgXd1Xtfv8t-maurYM=KEaamPj1@mail.gmail.com>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
	<1289745857-16704-2-git-send-email-avarab@gmail.com>
	<20101114172331.GA26459@burratino>
	<AANLkTinaDhXQjPC6s1eFb8HwEReW7P-ObmwRn2Hpb=O4@mail.gmail.com>
	<20101114185130.GA18385@burratino>
	<7v8w0umuz7.fsf@alter.siamese.dyndns.org>
	<20101115161122.GB16385@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 17:16:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI1ja-0007AB-Ed
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 17:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757615Ab0KOQQl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 11:16:41 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46164 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757511Ab0KOQQl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Nov 2010 11:16:41 -0500
Received: by fxm6 with SMTP id 6so1871498fxm.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 08:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BfGmlg198JTvD4rkVdJMtM4479aee/H+Qm+fnne2fiA=;
        b=EtgvNxoPHLY1+sHOt9v8FcUP6K37r+nO1tCqVaAuA8dXra/BW/WGHUCXijKmKDTv2s
         M5PI4YuBYS6fzNwyfqeci9gJ/11t7r39ANZ6u2PZjznG8FEeICO30GkcnnRWLgiPawGU
         +YxEp1wC3joDxwgAbBGwGxLR4HgrCvZtY8BAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=szw8mXa0AJb5UVOG+aV1A7Y+pKRFkDuCObGQIcox6JZPFYWVYbrgw3Wmo0w4OXPhua
         62a98iIIaueotL565d3pEj0IFEDYTsjzb/hyftcbHr/YKQ+6nv93U3mQvjEGrZLaCxMs
         eKcaF97dZEdRnpiBMygJwjYy2OPZjWNwKcy7I=
Received: by 10.223.71.199 with SMTP id i7mr5028647faj.57.1289837799784; Mon,
 15 Nov 2010 08:16:39 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Mon, 15 Nov 2010 08:16:39 -0800 (PST)
In-Reply-To: <20101115161122.GB16385@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161494>

On Mon, Nov 15, 2010 at 17:11, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> On Mon, Nov 15, 2010 at 08:07:08AM -0800, Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>>> That listing should be in a comment at the start of the
>>>> Makefile. Please submit a patch for that!
>>>
>>> How about this? =C2=A0An annoying piece of GNU makefile syntax make=
s this
>>> uglier than it needs to be (search for HACK for details).
>>>
>>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>>> ---
>>> diff --git a/Makefile b/Makefile
>>> index 1f1ce04..38edd65 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1,6 +1,8 @@
>>> =C2=A0# The default target of this Makefile is...
>>> =C2=A0all::
>>>
>>> +outline:: ; @echo "Configuration."
>>> +
>>> =C2=A0# Define V=3D1 to have a more verbose compile.
>>> =C2=A0#
>>> =C2=A0# Define SHELL_PATH to a POSIX shell if your /bin/sh is broke=
n.
>>
>> Hmm, I don't quite get what you are trying to do here. =C2=A0What go=
od does the
>> output from "make outline" do to a potential/actual developer? =C2=A0=
You can
>> learn that there are sections for "Testing rules", but then what? =C2=
=A0You
>> will look for that string in the editor or pager.
>
> I dunno. =C2=A0I wrote it because =C3=86var asked for it (and to make=
 visible
> where the trivial obstacles would lie in getting target-listing "make=
 help"
> to work, which is more interesting to me).

I just meant that we should add your comment at the top at some point.

But doing it via something like outline is probably better in the long =
term.

But let's do it in another patch series :)
