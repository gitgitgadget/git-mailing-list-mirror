From: Phil Hord <phil.hord@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Fri, 19 Apr 2013 17:07:47 -0400
Message-ID: <CABURp0pyAEppU7JL350vKtFQu_qBJ6YbzXTud+L7eEoPByGvYA@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org> <CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
 <7vip3npet0.fsf@alter.siamese.dyndns.org> <CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
 <8761zm4wzg.fsf@linux-k42r.v.cablecom.net> <CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
 <CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
 <CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
 <CABURp0riKhJ1p+06aKMCnBiupg3LyVCky5XRcPNLyaJDTkip9Q@mail.gmail.com> <CAMP44s2Yb+fSWYw0S7WuS-MEjKaSsnvndFw4ryZ8_Og6ioFcTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 23:08:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTIXX-0001X9-El
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 23:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224Ab3DSVIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 17:08:10 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:54786 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369Ab3DSVIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 17:08:09 -0400
Received: by mail-vc0-f171.google.com with SMTP id ha12so4312981vcb.2
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 14:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZUtQWrL3k+nKsI+Sya4BwhuAb4YGWTwJUuFYsFHbsKc=;
        b=GltUwXokgQU4gBcY5kdACzBWemMBZjtmhB3PUOQ21FagWwkxOajgdUmF/NfkDe7XeT
         6u3kn4yi+NYpPuSGIhs5uABV4hmJGT/kYlb2q6CQllYAe1Pv8IlY4ilWUbWZ7U2Lh9vJ
         BCGm8PfQuoLq6fNnNYmVwvnadqFebFNoYFwUo9kmtQZ3/6gg+5L6QiDtbPQUt6xVIxOD
         HNH5Cbk4lQrpuRWuLXTFkngpouPgIthnPTdnhZiuuEsFKT3YHZTGR1iqOIDynGqD/mvK
         jK+LK9+Tv3HQWP0ol8dTznyoR7en5WLf+UMMqqKxB6EnB4QDfB8lk/28DfWzI3MugfNP
         i55w==
X-Received: by 10.58.96.72 with SMTP id dq8mr12656137veb.49.1366405688056;
 Fri, 19 Apr 2013 14:08:08 -0700 (PDT)
Received: by 10.58.219.34 with HTTP; Fri, 19 Apr 2013 14:07:47 -0700 (PDT)
In-Reply-To: <CAMP44s2Yb+fSWYw0S7WuS-MEjKaSsnvndFw4ryZ8_Og6ioFcTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221820>

On Thu, Apr 18, 2013 at 7:48 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Apr 18, 2013 at 3:06 PM, Phil Hord <phil.hord@gmail.com> wrote:
>> On Wed, Apr 17, 2013 at 2:50 PM, Felipe Contreras
>
>>> Yes please. Show me one of the instances where you hit a bisect with
>>> any of the remote-hg commits mentioned above by Thomas Rast.
>>
>> I made no such claim.  In fact, I have never bisected to any
>> remote-hg-related commit.  I fail to see the relevance of this
>> qualifier, though.
>
> Here, this is what you said:
>
> You:
>> Me:
>>> [skipping irrelevant comments]
>>>
>>> I'm sorry, did you actually hit an issue that required to look at the
>>> commit message to understand where the issue came from? No? Then I
>>> won't bother with hypotheticals.
>>>
>>> If you want to waste your time, by all means, rewrite all my commit
>>> messages with essays that nobody will ever read. I'm not going to do
>>> that for some hypothetical case that will never happen. I'm not going
>>> to waste my time.
>>
>> This is not a hypothetical.
>
> If something is not hypothetical, it's real, which means it actually
> happened, but then you said you never made the claim that it did. So
> what is it?

My claim:

   I bisected to a commit whose commit message helped me deduce its entirety.


Your fanciful interpretation, which I denied:

  "Show me one of the instances where you hit a bisect with
  any of the remote-hg commits mentioned above by Thomas Rast."


I have never bisected to any commit related to remote-hg, and neither
did I ever claim to.  I do not know where you got such a ridiculous
qualifier as this to append to my statement.


> Either it did happen, or it didn't;

It did.  Where "it" is my actual claim, that I bisected to a commit
whose commit message helped me deduce its entirety.

But also, it didn't, where "it" is your preposterous interpretation of
my interest and/or experiences with remote-hg commits.

You seem only to want to argue, Felipe.  I have neither time nor
interest in pig-wrestling, myself.

Phil
