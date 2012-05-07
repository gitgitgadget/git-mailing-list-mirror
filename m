From: Mitar <mmitar@gmail.com>
Subject: Re: post-fetch, tweak-fetch hook
Date: Mon, 7 May 2012 11:11:30 +0200
Message-ID: <CAKLmikNuUB01xKSm9Skd2chXWw3BcWDHT23hqWtNBJPJfYqDKQ@mail.gmail.com>
References: <CAKLmikNaqVRb=pGUhbvVQTX2tYWT0HSS2R6Ezmico3X0rMgvYQ@mail.gmail.com>
	<201205062310.q46NAHnM022630@no.baka.org>
	<20120507072934.GC19874@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Seth Robertson <in-gitvger@baka.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 07 11:11:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRJyh-0005Sx-NR
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 11:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900Ab2EGJLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 05:11:31 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:59393 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668Ab2EGJLa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 05:11:30 -0400
Received: by vbbff1 with SMTP id ff1so617338vbb.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 02:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=105NdD57VgVvqk52yPHe6uwX9Lo61F5NFUd7fXv/M4k=;
        b=nYgEwgXuRAD/CC+IGeVwXwv8Be8iBYbf1imkVe0BERIkUis+vBbfBM0Z9q+mI5YuUq
         8AP4imMJPiQT6m64bzV8wVQqFJ16NjLwxvMBtSa3O1AKWDTRC+vuiV4auTvUPbMDQPYN
         A9nFxYHddXQt37bhuhBj+XGBrkM0uBCm4RewD/lEHVB7QxqEWy4irkJaQAD/OZqEm6Ed
         CoWq3UYGlWlygs6INavAr4/n4QxRE0hr/ca0dvv8jJAVkFIOASxR/Q3vg5gGzJc1ZBvY
         weoKvH4uHcFHKraAAgd3AOM9bQ++XSVPglH84485Xb/HrpZSjw5NY5Y55Iw5g7kv5YKd
         UpTA==
Received: by 10.220.152.205 with SMTP id h13mr3829255vcw.12.1336381890252;
 Mon, 07 May 2012 02:11:30 -0700 (PDT)
Received: by 10.52.28.13 with HTTP; Mon, 7 May 2012 02:11:30 -0700 (PDT)
In-Reply-To: <20120507072934.GC19874@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197245>

Hi!

On Mon, May 7, 2012 at 9:29 AM, Jeff King <peff@peff.net> wrote:
> I would say the "most git" thing would be to implement "fetch
> --porcelain", and use its output.

Yes, that would be also useful. It still makes two different
interfaces for probably same post-processing (after push and after
fetch), but still better than nothing, what is current state.


Mitar
