From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] pull: add angle brackets to usage string
Date: Mon, 19 Oct 2015 11:27:37 -0600
Message-ID: <CAMMLpeTf93NnqPM+SaxfhsSdMg1HUiVyo5FFdiuGF9o-KQbGog@mail.gmail.com>
References: <1444962133-1266-1-git-send-email-alexhenrie24@gmail.com>
 <xmqqwpumg480.fsf@gitster.mtv.corp.google.com> <CAMMLpeQPngq-xM2vN4uX6+k5-uoOXyP3p0wgLO9LOkWxWtZBEA@mail.gmail.com>
 <xmqq4mhqg15y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 19:28:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoEE7-0005y3-Vg
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 19:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbbJSR17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 13:27:59 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35196 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbJSR16 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 13:27:58 -0400
Received: by wicll6 with SMTP id ll6so16238724wic.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NxZKaOZblG3dMdond5+jr7QLH60Kzh+uM5qHBJdfIL8=;
        b=vIUkiVQAGioG+v0mkFTtDT6x2zw2gqTW1dAqGw5R3VDUg/78EORXq423BL4jx/YUtD
         XZdfgcR7fr8TREzT1aZHn2+OVZQyOReK+Alpldvsg8x8Oad2QaEqw8Cz75iojyafjiY7
         5ZHU/CPRzht/oZM2aimYAI2SnTf6WXa4LgVisA6NRm5TSSaojebb8kHFH2oaUm1awPOS
         dpSR7KxuYj8g8XVWOi++XkrRfPkHP9emqJRkIVL7T0tJZ5rLbmCrlv2NZpOAM/bdGUq+
         oZO81yg/0b/cAH5Na8PNLXhzsz7ZJa2VrhaiW0h6tDeGLyJpOXNNUGaGKLWwAH0X3i7Y
         WfbQ==
X-Received: by 10.194.239.230 with SMTP id vv6mr33664135wjc.21.1445275677396;
 Mon, 19 Oct 2015 10:27:57 -0700 (PDT)
Received: by 10.28.16.211 with HTTP; Mon, 19 Oct 2015 10:27:37 -0700 (PDT)
In-Reply-To: <xmqq4mhqg15y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279877>

2015-10-16 11:42 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
>> 2015-10-16 10:36 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
>>> Makes sense, as all the other <placeholders> in the usage string are
>>> bracketted.
>>>
>>> Does it make sense to do this for contrib/examples, which is the
>>> historical record, though?
>>
>> I didn't know that contrib/examples was a historical record. The last
>> patch I submitted, b7447679e84ed973430ab19fce87f56857b83068, also
>> modified contrib/examples.
>
> Yes, but that fixes historical "mistake", no?
>
> With this, you are breaking historical practice by changing only one
> instance to deviate from the then-current practice of saying
> 'options' without brackets.  It is based on the point of view that
> considers anything inside <bracket> and a fixed string 'options' are
> meant to be replaced by intelligent readers, which is as valid as
> the more recent practice to consider only things inside <bracket>
> are placeholders.

OK, I see. You're saying that it's OK to fix typos and grammatical
errors in contrib/examples, but it's not okay to modernize the
scripts' designs. That's fine; standardizing placeholder syntax is
primarily for the benefit of translators, and contrib/ is not
translated, so it's not causing a problem.

-Alex
