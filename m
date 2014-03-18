From: Quint Guvernator <quintus.public@gmail.com>
Subject: Re: [PATCH 1/1] general style: replaces memcmp() with starts_with()
Date: Mon, 17 Mar 2014 22:33:30 -0400
Message-ID: <CALs4jVFVO8Jf-nn0PMtOYeMMKsB869KWQv8vV5kAg1itC1isiQ@mail.gmail.com>
References: <1395093144-6786-1-git-send-email-quintus.public@gmail.com>
 <1395093144-6786-2-git-send-email-quintus.public@gmail.com>
 <xmqqob14a14s.fsf@gitster.dls.corp.google.com> <CALs4jVGxmirDdO03kaKco7=NrTaXBinY=1U71=fYwX1mbqNDOA@mail.gmail.com>
 <CAPig+cRGwBV5CE3X9yGZGRNtKojCagz_F_f4Kd+S+D_qX+ZwJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 03:33:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPjqm-0005jO-It
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 03:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbaCRCdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 22:33:52 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:48836 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbaCRCdv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 22:33:51 -0400
Received: by mail-wg0-f49.google.com with SMTP id a1so5424223wgh.20
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 19:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cZhAaN44pOMbkup0Bya0GkIpUqYTGftbL59yD94GXaQ=;
        b=vVT+d4/OaWt1s8uxBAaKgqzSq4TAd2mZWa9iRa6pRzib/CZSoy/rCp8pN3916Wg3+P
         /vNmAM4jnC56eNGEdXRsgAwMTx2twkK6r223X5v94mAJbcAyl2T7UOQAgwOBP7g3amAv
         M3OncEBQ+xJq+ZRGKuSTEKf/Is6VJ+UL7yLh8sN6mDe8Z6QM8IN6h1Dku+MY/MnVG0S5
         jnaiLU1CQPq3MR4NyShTgEsPAHl9pN8VrKVZmcpZA/9EIqKeVIYf9s+N4aS76TKXZAQT
         CnCqZDGyQHNyQqbXjYF58jdHZjg7bGBlw9jjJ4jC1AiJRjv3BpdCx536vm7JpkvOsJLq
         8Gnw==
X-Received: by 10.194.48.100 with SMTP id k4mr5049693wjn.49.1395110030403;
 Mon, 17 Mar 2014 19:33:50 -0700 (PDT)
Received: by 10.216.231.138 with HTTP; Mon, 17 Mar 2014 19:33:30 -0700 (PDT)
In-Reply-To: <CAPig+cRGwBV5CE3X9yGZGRNtKojCagz_F_f4Kd+S+D_qX+ZwJw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244321>

2014-03-17 21:59 GMT-04:00 Eric Sunshine <sunshine@sunshineco.com>:
> I can't speak for Junio, but the description could be made more
> concise and to-the-point. Aside from using imperative voice, you can
> eliminate redundancy, some of which comes from repeating in prose what
> the patch itself already states more concisely and precisely, and some
> from repeating what is implied by the fact that you're making such a
> change in the first place.

Wow, thanks for the detailed review. This mail will be something to
which I can refer when making future changes.

> In the subject, "general style" is a bit unusual. This isn't just a
> stylistic change; it's intended to improve code clarity.

It felt a little awkward, but I was trying to follow our guide [1] for
commit messages. It is all right to omit the leading identifier?

[1]: https://github.com/git/git/blob/fca26a/Documentation/SubmittingPatches#L87-L116

> A patch of this nature doesn't require much more description than
> stating what it does ("replace memcmp() with starts_with()") and why
> ("improve code clarity"). The following rewrite might be sufficient:
>
>     Subject: replace memcmp() with starts_with()
>
>     starts_with() indicates the intention of the check more clearly
>     than memcmp().

This is more concise; thank you. I will adapt this as the message for
the next version of this patch. Would it be wise to mention magic
numbers, as the discussion surrounding the rationale of this patch,
especially with Junio and Michael, has centered around that?

Thank you for the feedback,
Quint
