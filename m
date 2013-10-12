From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: My patches
Date: Sat, 12 Oct 2013 17:33:22 -0500
Message-ID: <CAMP44s0wWiedCXX-bes5ad6S67pWtyQPcs97y8UQzyUsanMr9Q@mail.gmail.com>
References: <20131012072450.GA21165@nysa>
	<5247B8D59AAE41F3A0D8BF165D2C2BAE@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Oct 13 00:33:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VV7kZ-0004kW-7J
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 00:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab3JLWdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 18:33:24 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49893 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab3JLWdY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 18:33:24 -0400
Received: by mail-lb0-f174.google.com with SMTP id w6so4502636lbh.5
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 15:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dLK0Ew83lDCCA9ZjXppy6qDmilDMRAwlJfAmSxy/9Vw=;
        b=oNChoPOfVnQVEBPs3VXNGJ0siXQPnsNkQYTO1e5gAHh6z/PkZtsSzFMKcTZC04s53K
         gvD8s1PFaSPNNi6yqL+SxbN1eC4vD9SnQkiw3uB5knja6EADHSEVh4idT1NYz5yPTx8x
         pIXd5ds9URnLl5lfi62yptX8QXN5QGe/8IEfVRxA6xVuqsKLbRCyuAcDVEdhNkvjheAo
         xd+LFefBxr5INaYh3ZXsXK1WDuoapQvc1+A0krHtxHq4SzvF+ftf3B4PjrqeZ66ikxt5
         SBdOxWBHaSF8+rTIN9puo5CuvOPMO4/1UTAW3sgh1b8hwWr6/+c0rFwVHINxnzyLuKKQ
         dfuA==
X-Received: by 10.152.36.98 with SMTP id p2mr22953917laj.14.1381617202655;
 Sat, 12 Oct 2013 15:33:22 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sat, 12 Oct 2013 15:33:22 -0700 (PDT)
In-Reply-To: <5247B8D59AAE41F3A0D8BF165D2C2BAE@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236061>

On Sat, Oct 12, 2013 at 11:18 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Felipe Contreras" <felipe.contreras@gmail.com>
> Sent: Saturday, October 12, 2013 8:24 AM

>> Clearly, a lot of my patches have not been reviewed properly, so even
>> though they are technically correct, and would benefit users, some have
>> specifically been requested by them, and at least one would
>> significantly improve Git's user interface...
>

> Given you have put a lot of work into your 16 patch series, is there any
> particular order, or grouping that would help their review.

I ordered them in order of importance, and chance of being merged. For
example, the first patch series 'branch: improve verbose option' is
relatively simple, it improves things significantly, and other
developers have already argued this is the way to go. The last one
'sha1-name: refactor get_sha1() parsing' doesn't have much of a chance
of being merged, it's quite complicated, there isn't any particular
change that is visible to the users, and there isn't probably much
interest.

> With so many patches to consider one (the reviewer(s)) gains another task of
> simply trying to prioritise the patches (usually one can take big decisions
> by simply remebering who's series one was interested in).
>
> I expect the clean-ups and 'trivials's' can be managed separately from the
> 'improvements', which would again be separate from the "satging" and "Ruby"
> philosophical discussions.

Maybe, but the trivial patches have a higher chance of being merged
than 'Massive improvents to rebase and cherry-pick' or 'Support for
Ruby', that's why I put them first.

>>   they are going nowhere.
>
> I wouldn't expect 100% success. Every now and again one hears of the "here's
> some patches I've had in my tree for a while" that probably had the same
> early frustrations - they just feel worse the more you produce.

Yeah, I'm aware of that, I have contributed to lots of open source
projects. However, we are not talking about a couple of patches that
now and again get lost, we are talking about 160 patches, some which
have gone through several (even ten) iterations. I think that is
different.

Cheers.

-- 
Felipe Contreras
