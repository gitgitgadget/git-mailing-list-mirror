From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 6 Jul 2015 10:46:06 -0400
Message-ID: <CAD0k6qTDpH0H-k9h+f3X8PjXpOZ7tRzv+8wvi8HALhg9DDm4Ew@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com> <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
 <CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com> <xmqqzj3f7gde.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 16:46:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC7fE-00035T-Cl
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 16:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbbGFOq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 10:46:27 -0400
Received: from mail-vn0-f54.google.com ([209.85.216.54]:41675 "EHLO
	mail-vn0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbbGFOq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 10:46:26 -0400
Received: by vnbf62 with SMTP id f62so7745869vnb.8
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=J71yAFVNEXqxdDdP0gKl27FwPqBaWnlRkrfBdzBnaJY=;
        b=FoAHGWkjaF6kzOB4sELP3YrFpIgSP4mwGqpXICv2vwQmnNNezycSXoEsTjnmeZCulx
         afH4RAyqp4nduCHlu7fihbGYk8aMirnjaO1805EiW0LXIkFJrkFzVOOfXgjhrrrmIWJV
         pTdqACaNHtf2Q2St4Ry2IJLMXB6SwSt5d+MfCy+iy8JvxJU8yI1cfqfvCsQItWrye3j6
         1WSJYfakpcCn5GWJOmDxyGryrdoLdW+JJ0N/3GQNkVLq6a///naIY75StNMqFrAhMlbF
         3X6qy5NLYMCwGganasrGk5uCtRxkS1mermi/TmpYSPeAocsZbx4q29z7b5lK4LD0vl3w
         E2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=J71yAFVNEXqxdDdP0gKl27FwPqBaWnlRkrfBdzBnaJY=;
        b=FYF16In9nng0aavcVqVUpoYEicHSXxmnPm0P0v3/uCkh79vH2MbngB435hN9q75jm0
         XF1BBOe+5yTlmux3tVRWONwRw7N18yf1sQ7iZ5qO51uLqCDaGQda3yfHmI/JdNuVAf55
         /lD0u+xzLfXI34vmdydHEB5JAm/viagpB6Fl+7bydU3RgOgCPWe6kggjdTqrVEilPqcB
         3mLH7CjUvMB127TnumGgcbIm6Y7Gqgi6EhoTrYj5/FN++47RBiU8KH/Hw4ab2WhJrnlX
         dlXo5efPrI6VbeCvynJYmTstrvOtBIKXYJSLw5TBCrKArAmTBBNNQUzfJ615DmGIlwR5
         JVQQ==
X-Gm-Message-State: ALoCoQn0dEwjyltc2gEVePE2hpxd8hajrxM8Jm927oNvMq3JEU3jFxsUJBowZ2iQLZCYsBc0kGm7
X-Received: by 10.52.230.2 with SMTP id su2mr50311188vdc.55.1436193985637;
 Mon, 06 Jul 2015 07:46:25 -0700 (PDT)
Received: by 10.52.177.6 with HTTP; Mon, 6 Jul 2015 07:46:06 -0700 (PDT)
In-Reply-To: <xmqqzj3f7gde.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273385>

On Wed, Jul 1, 2015 at 4:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Dave Borowitz <dborowitz@google.com> writes:
>
> >> I am moderately negative about this; wouldn't it make the end result
> >> cleaner to fix the implementation?
> >
> > I'm not sure I understand your suggestion. Are you saying, you would
> > prefer to make LFs optional in the push cert, for consistency with LFs
> > being optional elsewhere?
>
> Absolutely.  It is not "make" it optional, but "even though it is
> optional, the receiver has not been following the spec, and it is
> not too late to fix it".
>
> The earliest these documentation updates can hit the public is 2.6;
> by that time I'd expect the deployed receivers would be fixed with
> 2.5.1 and 2.4.7 maintenance releases.
>
> If some third-party reimplemented their client not to terminate
> with LF, they wouldn't be working correctly with the deployed
> servers right now *anyway*.  And with the more lenient receive-pack
> in 2.5.1 or 2.4.7, they will start working.
>
> And we will not change our client to drop LF termination.  So
> overall I do not see that it is too much a price to pay for
> consistency across the protocol.

Ok, I understand your proposal now, thank you. I will drop this
documentation patch from this series, and abandon
https://git.eclipse.org/r/51071 in JGit. I am not volunteering to
rewrite push cert handling in git-core though ;)

> > If LF is optional, then with that approach you might end up with a
> > section of that buffer like:
>
> I think I touched on this in my previous message.  You cannot send
> an empty line anywhere, and this is not limited to push-cert section
> of the protocol.  Strictly speaking, the wire level allows it, but I
> do not think the deployed client APIs easily lets you deal with it.
>
> So you must follow the "SHOULD terminate with LF" for an empty line,
> even when you choose to ignore the "SHOULD" in most other places.
>
> I do not think it is such a big loss, as long as it is properly
> documented.
