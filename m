From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Tue, 16 Apr 2013 14:04:13 -0500
Message-ID: <CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	<8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Apr 16 21:04:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USBAy-00082O-5l
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 21:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835Ab3DPTEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 15:04:16 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:41688 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab3DPTEP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 15:04:15 -0400
Received: by mail-lb0-f171.google.com with SMTP id v10so883220lbd.16
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ktdZTMEtaqOEOJs44HUdlR4h5oHXhRA35clSGT5sgao=;
        b=lIryeSJtZss0+S5RDTrhNyMiExJklaLEmR07YymbvoLcj5hw345F+Z9IVYWKe90v1P
         tBf+GUV0CrNTKeJ6n0FaVYKe7FnpPamQQGSdji1Jh2Z2rte4w6s1k4ObtNcxiRkdyQQs
         V+PzjTua/lHX/BWjMRjGUmKGaB3gL8B4HoXt3kFjL15CcWs/edXbAYZ5vVvQ/UkwqYNi
         Y2xf50982yWpCToJEg2Tw3dd9yDmZ8wUhWccxVF268cSwF/4mOJuUaXXYt2vkwA1E5F/
         FnSaFjTDmON8vvtr46S1j4UWNogfPffxIRlWxW1I4dxN4DSPjzS2LPc2qSsJAoX2iAhl
         1/pQ==
X-Received: by 10.152.105.17 with SMTP id gi17mr1819935lab.46.1366139053718;
 Tue, 16 Apr 2013 12:04:13 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Tue, 16 Apr 2013 12:04:13 -0700 (PDT)
In-Reply-To: <8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221452>

On Tue, Apr 16, 2013 at 4:59 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Clearly, that's the correct behavior. Why would anybody send a change
>> that does something other than the correct behavior?
>
> Along the same lines, why would anyone write broken code?  Nobody does,
> right?

Yes, I should change the subject to:

  transport-helper: update remote helper namespace, because that's
exactly the thing we DON'T want to do, the purpose of this patch is to
mess up everything

Suree. I'm willing and knowingly introducing a change that goes
diametrically opposite to what we want.

> If anyone reads that commit message in more than a few weeks, then it's
> because some of the code is *broken*.

That is irrelevant. Junio said the correct behavior was not described,
when if fact it clearly is. Whether or not the patch has a bug in it
is irrelevant to the fact that the correct behavior is described or
not.

> So the reader is investigating a
> situation where there must be a flaw somewhere, and trying to pin down
> the source.  Having access to the thinking behind each commit means s/he
> can more easily verify whether that thinking was correct and still
> applies.

Sure, and where is the thinking not clear? The remote helper ref is
not updated, so we do update it. How is that not clear?

> And your commit messages do nothing towards that end.

Oh, it does. You just don't understand how remote-helper works.

> A cursory look^W^Wreview of the messages in fc/remote-hg:

[skipping irrelevant comments]

I'm sorry, did you actually hit an issue that required to look at the
commit message to understand where the issue came from? No? Then I
won't bother with hypotheticals.

If you want to waste your time, by all means, rewrite all my commit
messages with essays that nobody will ever read. I'm not going to do
that for some hypothetical case that will never happen. I'm not going
to waste my time.

Cheers.

-- 
Felipe Contreras
