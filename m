From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH] subtree/Makefile: Standardize (esp. for packagers)
Date: Sat, 3 May 2014 22:56:25 +1000
Message-ID: <CAHYYfeGNO5QknoKkZfYy3XLNRZsVmf0WjeNGkDxH3QwPF-RsUQ@mail.gmail.com>
References: <1398304336-1879-1-git-send-email-nod.helm@gmail.com>
	<CAHYYfeGNDLVxzP6zMyJnSi8GxpQaUKGAkqaLfXbZ=8B1k7vvyQ@mail.gmail.com>
	<3cb4338e-de68-404d-86dc-70cac7e13606@email.android.com>
	<20140426072520.GB7558@sigill.intra.peff.net>
	<6a7bcc79-d9c3-4cf8-8f3b-a6a16298c221@email.android.com>
	<20140430032045.GA4613@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Sat May 03 14:56:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgZUX-0003ze-FG
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 14:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbaECM41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 08:56:27 -0400
Received: from mail-vc0-f173.google.com ([209.85.220.173]:37746 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaECM40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 08:56:26 -0400
Received: by mail-vc0-f173.google.com with SMTP id ik5so6582253vcb.18
        for <git@vger.kernel.org>; Sat, 03 May 2014 05:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nevrdgTDXJTnzZpDfxq2YgCZWRKvzwfCJWwk83JFvu0=;
        b=c4py4vLJp3/OBEyGBsPpa3zor1Ayo2oboFvuI4RruZKKMHC4f/Kmq9KlRXiZf25m+6
         eajwkXJHgFNeO46ApwmVfzJk/q1c6E3I86Hi0D89Luncli4h8CZ7BelQaF1k16S4Nvav
         Etv4LJDHXLzXmSQbyEa2OTOOVtD6ZI7VCQswZ9U/X/XobT8//NCPQvbXQYFeqK663C1N
         EqDwXSW5H+XF6gs9+h8TcisZs8dlCZt/uz2+IZq1Kdc9MaJwWBSTA9Yh7dq1BnuU9Wty
         KQ8SuOzdXTPzoGzj5VtwmRkEYgrG5pWtenZXYrb5q4RpuzQnmz3gx4d1O7ZgTskozVFi
         Je5A==
X-Received: by 10.52.93.201 with SMTP id cw9mr47136vdb.80.1399121785577; Sat,
 03 May 2014 05:56:25 -0700 (PDT)
Received: by 10.58.12.2 with HTTP; Sat, 3 May 2014 05:56:25 -0700 (PDT)
In-Reply-To: <20140430032045.GA4613@comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248044>

Matthew Ogilvie <mmogilvi_git@miniinfo.net> wrote:
> On Sun, Apr 27, 2014 at 12:35:13PM +1000, James Denholm wrote:
>> Jeff King <peff@peff.net> wrote:
> Agreed.  It also doesn't help that when subtree patches are proposed
> (especially new features instead of obvious bugs), there often seems
> to be little or no feedback from anyone.
>
> --------
> Depending on how much time you have:
>
> This may be outside the scope of work you were planning on,

While current, immediate focus is really just getting the makefile fixed
up and hopefully then have more people package subtree by default,
overall I'll very likely extend that to general work on subtree and such.

>                                                                                          but
> it might be worth grepping through old mailing list archives for
> "subtree" patches that haven't been merged, and see if there is
> anything worth revisiting/resubmitting.  I believe most of the
> following (at least) kind of languished and died, often with little
> or no real review and feedback:
>
> (...)
>
> (I don't know if these are the latest or "best" versions of these, nor
> have I really looked at them closely to decide if they are worth
> including at all.  Be sure to exameine not just the discussion around
> the specific patches, but also the other patches in each series...)

Yeah, certainly, I'll be sure to have a sticky-beak. Thanks for pointing
those out!

Regards,
James Denholm.
