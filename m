From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Android Replies to Git List getting rejected
Date: Tue, 7 Aug 2012 17:25:02 -0400
Message-ID: <CAPZPVFZJkxK50eA+saMKLHAc=wCioTFF0PVw=Xhcrf3GpzPydA@mail.gmail.com>
References: <CAM9Z-nmEDTEN0Em-nY+y5g0kRMsNuy-pn8Lzr_mWSU7engj6JQ@mail.gmail.com>
	<50216D83.6080707@kernel.org>
	<20120807205524.GA3953@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Drew Northup <n1xim.email@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 07 23:25:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyrH7-0004nx-82
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 23:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667Ab2HGVZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 17:25:05 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36598 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659Ab2HGVZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 17:25:03 -0400
Received: by lboi8 with SMTP id i8so114508lbo.19
        for <git@vger.kernel.org>; Tue, 07 Aug 2012 14:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ed2TAm++47rsl7uCbBYKFafBpCeEtNWNjcZ7jU6OEQE=;
        b=wayYI8qd2LQ0BgyHwYk8QdufFGGJRGs1WatDfsW0fWlmUJ+S2fgJp47bfETCVF4u0B
         2Yh6uP06ElzmusJBoEAjCj6I/EfVeHvvsjaQUttKk4hO7u0tkzE3mhaDRAQLwwNXQDE0
         ek8Tl5rqc8iz6yL+SI3Fu25v/6F81VSTvNkWTnqnkiEfr4FZDv8KcLlybFEuLZiEqWw7
         rvPd8x+Nd8BszQfzh8clXv+WYpLLLnJhJIyWnGTK0zOhKGde00zwBKRdlWj5YEEHHsCW
         mwvyZWJHekjm/RfIHQj+mlksaj+5UKGiIdmF9AjBis9L9DzDRPWYvFMbeGG1vdsMN4Pq
         sy/g==
Received: by 10.112.30.41 with SMTP id p9mr7063731lbh.26.1344374702135; Tue,
 07 Aug 2012 14:25:02 -0700 (PDT)
Received: by 10.112.82.163 with HTTP; Tue, 7 Aug 2012 14:25:02 -0700 (PDT)
In-Reply-To: <20120807205524.GA3953@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203047>

On Tue, Aug 7, 2012 at 4:55 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Tue, Aug 07, 2012 at 01:33:23PM -0600, John 'Warthog9' Hawley wrote:
>> It's pretty simple: you sent HTML mail to vger.kernel.org, and it
>> explicitly rejects all HTML e-mail.  GMail, particularly from Android,
>> apparently doesn't have a way to bypass sending HTML mail (it's been a
>> much maligned bug).
>
> Yeah, sigh.  Drew, I suggest that you star the following bug:
>
> http://code.google.com/p/android/issues/detail?id=8712
>
> ... and perhaps leave a comment in the bug report that you can't
> interact with the git mailing list because of this limitation.
>
> I'm sure you know (since you indicated that you sent your e-mail via
> the web interface of Gmail), that this is at least something you can
> control in the desktop/web version of Gmail (just enable "Plain text"
> mode) --- but it would certainly be nice if users had the choice of
> whether they wanted to participate on vger mailing lists using the
> Android application, versus the Web interface, or using Mutt or Pine
> on a Linux box.
>
> Regards,
>
>                                         - Ted
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

There were several discussions about that on the list and
unfortunately list moderators didn't pay enough attention to it.
Android Gmail sends totally valid multipart message that has HTML and
plain-text part.
List being unable to process those correctly and cut off HTML part is
a limitation.
I personally feel that i could and would be more active on the list if
not for this limitation.

<rant>
Don't want to accept HTML messages - fine. But don't tell me which
program to use for my email, especially when I'm sending totally valid
message, so take my plain text message part and use it.
</rant>

Thanks,
Eugene
