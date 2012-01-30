From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] completion: be nicer with zsh
Date: Mon, 30 Jan 2012 20:21:00 +0200
Message-ID: <CAMP44s1q1RuHNo5O2rMDF_YHefagaXXwxg+5Lc4DCF7mZYm20w@mail.gmail.com>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
	<1327880479-25275-2-git-send-email-felipe.contreras@gmail.com>
	<7v8vkperli.fsf@alter.siamese.dyndns.org>
	<CAMP44s0rp1EwruAwMpntcUzKS=Pbe44t7Eq0OcHdH8WF7OoUhQ@mail.gmail.com>
	<7vpqe1cbds.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 19:21:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrvqm-0000rn-7A
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 19:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133Ab2A3SVD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 13:21:03 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:35273 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753054Ab2A3SVB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 13:21:01 -0500
Received: by lagu2 with SMTP id u2so2376787lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 10:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KPnhUNWOT227Kz/bZe0NNtmS89Vc9CWuBZ1RsBy4YOw=;
        b=H/qAOF0c6uBGrhkLS2yozr3IXSsXxxMt3kjj/dtG2bKYk1PxDcXCy0RAk6/3Ql8xga
         jB0lL00E3w2vLChcI/E9rXqFpxxY47PTKzSCULSestSirvCP4u5BaBtnusdf5TU8qII5
         Xhfi72vOj8Sl4UL4t9LTPcsBFN8ETJAVNWsZc=
Received: by 10.152.131.40 with SMTP id oj8mr9754628lab.24.1327947660431; Mon,
 30 Jan 2012 10:21:00 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Mon, 30 Jan 2012 10:21:00 -0800 (PST)
In-Reply-To: <7vpqe1cbds.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189390>

On Mon, Jan 30, 2012 at 8:07 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> In any case, there's no need for ad hominem arguments; there is a
>> problem when using zsh, that's a fact.
>
> There was no ad-hominem argument at all.
>
> Read your two lines I quoted "... the code is now actually understand=
able
> (at least to me), while before it looked like voodoo", which was your
> words. =C2=A0What does it tell the reader? =C2=A0The patch author (1)=
 did not
> understand existing code (voodoo) and (2) the change is a good thing =
as a
> style/readability improvement.

I disagree. Another possibility is that the code actually looked like
voodoo (it was obfuscated). You might disagree, but the fact that one
of the main editors (the most used?) doesn't even recognize the syntax
of this code I think is pretty telling.

> I was saying that I did not want to see that in the justification, be=
cause
> (2) is not true, while (1) may be.

That's not true: (2) might be true; at least it's debatable.

> The patch as-is is a good change that works around issues with zsh's =
POSIX
> emulation, and that is sufficient-enough justification. IOW, we are i=
n
> agreement on the later half of your sentence.

So, I shall just remove that part of the explanation?

--=20
=46elipe Contreras
