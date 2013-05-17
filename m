From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Fwd: git cvsimport implications
Date: Fri, 17 May 2013 09:50:00 -0400
Message-ID: <CACPiFCLLw+m=2u8Dsw8u0cU9xrncZ0DwZ9SwOpONWydzCY2t0Q@mail.gmail.com>
References: <CAPZPVFYFL6OS2HWbF0BKNKtNsZ6CfpWmKCypGxeTs7W8-76q8Q@mail.gmail.com>
 <CAPZPVFZLDwLNazvBh5n=Jg_=CZUNz3yTme4JW2NutPgjPzwtLg@mail.gmail.com>
 <7vfvxpfbli.fsf@alter.siamese.dyndns.org> <51932A1A.4050606@alum.mit.edu>
 <CAPZPVFZTZFQrCF3gcwcff5LFm9MHhZm-DauLvfzCYrMTw4nQfA@mail.gmail.com>
 <5195F3EB.8000308@alum.mit.edu> <CACPiFCLqtSy_=1yw6mGWFhNOi=M1rrPNbD6=qpo4FOO_QywCgg@mail.gmail.com>
 <51962D52.7070200@alum.mit.edu> <20130517133457.GA11496@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Eugene Sajine <euguess@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 17 15:50:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdL3C-0006Ml-Kg
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 15:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037Ab3EQNuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 09:50:22 -0400
Received: from mail-qe0-f44.google.com ([209.85.128.44]:60608 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab3EQNuW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 09:50:22 -0400
Received: by mail-qe0-f44.google.com with SMTP id s14so2720490qeb.31
        for <git@vger.kernel.org>; Fri, 17 May 2013 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ErPEF7Rz+cEFEfL56R3rtW9WosA6J5YFJ0sdllLoR7Q=;
        b=qgb8+svEqonglumR6LWp5gEDGocOy+0WhpWZOrS84W5LBfwhrPaEBDsR9xgh47EirN
         HitbP0gqcs978kIz16ht/3WqPW9xmaP5ROZqiOKoLZtWoUJoaPb9L+7xn4sDB1SXemsQ
         veoKIpSiM2hCvpnoZirh1vBeZhx7Uz7m1oiu3kYy4/pIEVLCfzLqOKkmA0Quit5D3uSH
         7BlB4Y5UlRANFjJ3mOwKUiAAlU1PvREx96C+GG4xcdNL/biJZaRg/b5PhjZ9u0Iq9vJ1
         Rr1+tuDBgmxXhAiNtTkwfFobB5PCV+dvM9I3TAxFvLk5XCWNeWNsJU2uw/S/n4qLEfZ/
         RUVg==
X-Received: by 10.224.137.73 with SMTP id v9mr6682037qat.59.1368798621542;
 Fri, 17 May 2013 06:50:21 -0700 (PDT)
Received: by 10.49.96.201 with HTTP; Fri, 17 May 2013 06:50:00 -0700 (PDT)
In-Reply-To: <20130517133457.GA11496@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224690>

On Fri, May 17, 2013 at 9:34 AM, Andreas Krey <a.krey@gmx.de> wrote:
> On Fri, 17 May 2013 15:14:58 +0000, Michael Haggerty wrote:
> ...
>> We both know that the CVS history omits important data, and that the
>> history is mutable, etc.  So there are lots of hypothetical histories
>> that do not contradict CVS.  But some things are recorded unambiguously
>> in the CVS history, like
>>
>> * The contents at any tag or the tip of any branch (i.e., what is in the
>> working tree when you check it out).
>
> Except that the tags/branches may be made in a way that can't
> be mapped onto any commit/point of history otherwise exported,
> with branches that are done on parts of the trees first, or
> likewise tags.

Yeah, that's what I remember too.  It is perfectly fine in CVS to add
a tag to a file at a much later date than the rest of the tree. And it
happened too ("oh, I didn't have directory support/some-os checked out
when I tagged the release yesterday! let me check it out and add the
tag, nevermind that the branch has moved forward in the interim...").

I would add the long history of "cvs repository manipulation". Bad,
ugly stuff, but it happened in every major project I've seen. Mozilla,
X.org, etc.

TBH I am very glad that Michael cares deeply about the correctness,
and it leads to a much better tool. No doubt.

When discussing it with end users, I do think we have to be honest and
say that there's a fair chance that the output will not be perfect...
because what is in CVS is rather imperfect when you look at it closely
(which users aren't usually doing).

cheers,



m
--
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
