From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] transport-helper: update remote helper namespace
Date: Sun, 14 Apr 2013 10:42:47 -0500
Message-ID: <CAMP44s22N9_E4oBG0UztXE0yAkX8TmQaE9-x1_wDHqv3bvZ0EQ@mail.gmail.com>
References: <1365638832-9000-1-git-send-email-felipe.contreras@gmail.com>
	<1365638832-9000-3-git-send-email-felipe.contreras@gmail.com>
	<20130411043346.GE14551@sigill.intra.peff.net>
	<CAMP44s0FkiwPMJVhVBNa32J3rgghRZy6xDTN-YnHKcQ4Fj0BMQ@mail.gmail.com>
	<20130411050509.GC27795@sigill.intra.peff.net>
	<CAMP44s1LF46VU0E4W=r-qog3JY+Y-qyYGfkqxLEnTG8X8GoWOA@mail.gmail.com>
	<CAMP44s3+eaRbeXP0bPXMSE8Z1K_Lqyu8e1XCvudkapkTJFBWnA@mail.gmail.com>
	<7v8v4l7ils.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 17:43:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URP55-0007ZI-DE
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 17:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab3DNPmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 11:42:49 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:57414 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab3DNPmt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 11:42:49 -0400
Received: by mail-lb0-f169.google.com with SMTP id p11so3907563lbi.0
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=V2n4p5dNvKbZlluHX9aTQducb5JY1waarZUIucNel8E=;
        b=AcGSv4+df7V/zG2HiB50l7vc7MfkONyVM1Kcg1QkBpf41kfG9py3x7Gm5iYepN681r
         ArvHRYh/JFhcsFA+hb7RH0j8IkjpEKV6grBduAf1rcnGFEVZDSdml3qS8+kXL8AAmHRy
         NeyEwsZsU/MuaWz0IM4I3KBZVRoQxM+unWH8fzdoc1AK4PjKBcjct4W6WRszfbnCfwqc
         NJSjDjwVzSRk5sjza21VrbNo5mqsy2Fo0KPwyRvEuMG/Psk/wV/DgtkYR9Rqmw/VX6uC
         gZN8RmljIZ2/AbTeeXMrkJn3R+rv8Qn/XEdy37rtYxT09Jai+31NuVO5wCk8GfsNmQxX
         N+5Q==
X-Received: by 10.152.5.134 with SMTP id s6mr3876228las.24.1365954167483; Sun,
 14 Apr 2013 08:42:47 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Sun, 14 Apr 2013 08:42:47 -0700 (PDT)
In-Reply-To: <7v8v4l7ils.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221143>

On Sun, Apr 14, 2013 at 12:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Why wasn't this patch merged to 'pu'? To my knowledge nobody raised
>> any real concerns.
>
> There are many reasons not to queue _everything_ ever posted to the
> list on 'pu', and they are almost always not a deliberate rejection.
>
> The maintainer may have thought he is not the best person to judge
> changes to the area the patch touches, and may be expecting further
> comments from others, but haven't said "Comments?" and waiting for
> them to say something without being asked. Or the maintainer may
> have judged that it is likely to result in wasted work if he queues
> that version of the patch, fixing trivial nits himself, only to see
> a reroll arrive before the day's integration cycle finishes (which
> makes him run the cycle again). Or the maintainer may have been busy
> tending to other topics. Or the maintainer may have pushed the patch
> down the queue for any of the above reasons to deal with it later,
> and after having tended to others' topics, may have forgotten about
> that patch.

The world is full of possibilities, but most of them are irrelevant,
specially since 'the maintainer' is right here and can mention the
reason himself. Is there anything wrong in asking?

>> I know I said I was going
>> to update the commit message, but I don't think that reason to not put
>> it in 'pu'.
>
> For this particular case, I think that was exactly the reason why it
> is not in 'pu' today. I actually did not remember the reason when
> you asked above, until I read the above "I said I'll update".
>
> One major reason why I queue a patch that is clearly not ready for
> 'next' is because I do not want to forget about the topic and not
> because I want to keep the particular version of the patch. I do so
> especially when contributor is unlikely to come back soon. If you
> said you would come back soon, I do not even have to judge if it is
> "clearly not ready" or "it is good enough" for next, and I have to
> remember one less thing. The more I can put in "this will come back
> so I do not have to do anything" bin, not in the "queue it as-is for
> now, because it is likely that it won't be rerolled soon and I'll
> forget about it" bin, the easier for me and we as the development
> process as a whole can scale better.

Well, I'm telling you I think it's good as it is. Other people might
disagree, but if they do so, it's possibly on the basis that other
transport-helpers might not be using marks, which is something I have
said time and again is not possible, and to think it is, is a mistake.

I am willing to demonstrate the above claim beyond any reasonable
doubt to any sensible person (haven't I done so already?), so that we
can avoid these discussions again in the future, and include in the
documentation that marks are necessary, or throw a warning for the
people developing a remote helper, or something along those lines.

But if that's not what you want me to do, then what is needed to get
this patch into 'pu'? That's what I'm wondering.

Cheers.

-- 
Felipe Contreras
