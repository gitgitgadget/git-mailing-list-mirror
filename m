From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/5] <branch>@{publish} shorthand
Date: Wed, 8 Jan 2014 18:10:09 +0530
Message-ID: <CALkWK0=akW-CwQC7hz4Jae5Y7Vtk282dtq_HsnQ=_SHU2iJhyQ@mail.gmail.com>
References: <1389126588-3663-1-git-send-email-artagnon@gmail.com>
 <CALkWK0=g5-9r05vTkys8Tk7iv7PqPZJvMvkYsAOnN_F90Mtgxg@mail.gmail.com>
 <20140107204035.GA27932@sigill.intra.peff.net> <CALkWK0mGPhU-8vVg+xY-MGWNstxoXSU9MGQiNzyFN+-Q6Bw28A@mail.gmail.com>
 <20140107211645.GC28102@sigill.intra.peff.net> <CALkWK0=UkWEGhU6D8CQctdgTvZUUj276LSuNhSmRUMZ5mwZTeA@mail.gmail.com>
 <20140108093338.GA15659@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 08 13:40:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0sRK-0000SW-Eh
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 13:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756236AbaAHMkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 07:40:51 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:62832 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773AbaAHMku (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 07:40:50 -0500
Received: by mail-ig0-f179.google.com with SMTP id hk11so4466187igb.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 04:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=a/ANfhonn+aFYUbWAc3WWtC1xElfVTejCsiGSMfbUAU=;
        b=qXzjrHSQtdLhsxULR1FqyxyxyvJMMiPEvH07NcRJ6vcs7PkwypZIHJ9n3ComBxj2Tv
         D2ZptPPCNSwJ+u3TA8J21KjjgjC696lAyIAtnrN4VeOknFnyDz1UYUmSeF6/LDf5H57w
         JcNzuDIsM43uraI+K68YcPdnbFNT0LZvXK2oH3PBnW/KVxbP0OkRn4XdYdyxLalPkJGq
         xVYHKCdVHr5XI1+I19PudsvzunOh61RIHl2Fkb/5fHKd9+Py3IFWTxSLZlOOQH86OIFL
         Milco6nkFhOHVWyYmSk1mhli5baFYw4/Dff9oRHMkbf+QMf2FrVq+QALpAGOjmM8AKZ3
         0QVA==
X-Received: by 10.42.24.210 with SMTP id x18mr69031293icb.38.1389184849369;
 Wed, 08 Jan 2014 04:40:49 -0800 (PST)
Received: by 10.64.17.10 with HTTP; Wed, 8 Jan 2014 04:40:09 -0800 (PST)
In-Reply-To: <20140108093338.GA15659@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240213>

Jeff King wrote:
> There's a fair bit of refactoring involved. I took a stab at it and came
> up with the series below. No docs or tests, and some of the refactoring
> in remote.c feels a little weird. I can't help but feel more of the
> logic from "git push" should be shared here.
>
> But it at least works with my rudimentary examples. I'm hoping it will
> make a good starting point for you to build on. Otherwise, I may get to
> it eventually, but it's not a high priority for me right now.

Thanks; I'll see what I can do about getting it to share code with 'git push'.
