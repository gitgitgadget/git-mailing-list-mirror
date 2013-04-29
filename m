From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 12/20] remote-bzr: split marks file
Date: Sun, 28 Apr 2013 23:57:21 -0500
Message-ID: <CAMP44s22AJ574nzXiXyMxV3SUiv8xz5yokS6__4Ck6oK4DwcGg@mail.gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
	<1366938488-25425-13-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s2dzV428+_ZENg_Z5n=rnvqz1ZNAxnjsqCtLSJK-9PZZg@mail.gmail.com>
	<7v4nesvncw.fsf@alter.siamese.dyndns.org>
	<7v1u9usdag.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 06:57:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWg9i-0008JA-KM
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 06:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277Ab3D2E5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 00:57:24 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:51778 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184Ab3D2E5X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 00:57:23 -0400
Received: by mail-la0-f49.google.com with SMTP id fp13so2775966lab.8
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 21:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=eQ7fL7LbPkP9FVraByRK6/lxknCzFYnxHLirXHMrt5U=;
        b=wp+QcXWX8ReJ2nRGeFaqmH3vvAKmznGg2V5vZ8ttlja9JlKyrEp5PxIgO9k5Imso9C
         KNBDejVS5HDit2e1IzXnxewrZ5c3viwP1B66L4d8PMtjkiIyX3b4bEuzK0ekpXVLzJ6W
         Rv+h9c2AwdAETcbeFZj1FO8zMenwCp8xtFoK//M+I/aidamNi/Y4KHuStaU1ndkBFXCj
         6eXTjNLbZCwRZWCkVNL6APwALprtB/UoZjkAZo9GQTyKR1UTMAVxFScFAsw3eS4WTB1W
         jFd6pMhNFBYARIj4AHk+eScDmOU7YcjO/jhYEe/wtV5bL5ayzVJ/YMtyAIRE+aXBt5sw
         736w==
X-Received: by 10.152.20.134 with SMTP id n6mr14669921lae.19.1367211441879;
 Sun, 28 Apr 2013 21:57:21 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sun, 28 Apr 2013 21:57:21 -0700 (PDT)
In-Reply-To: <7v1u9usdag.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222765>

On Sun, Apr 28, 2013 at 1:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> And in case anybody is thinking that remote-bzr is really a too fast
>>> moving target; even if this managed to land in 'master', it's likely
>>> that people were not able to push at all, and in fact, many were not
>>> even able to clone in 1.8.2. So, hardly could be considered a
>>> regression. Nevertheless, I caught it in time.
>>
>> You didn't.  I am already way too deep into today's 1.8.3-rc0
>> integration cycle and I won't waste a couple of hours work just to
>> revert this.
>
> Oh, I was lucky ;-) I mistook this with the other 9-patch bzr
> clean-up series that I applied to 'master' for -rc0.
>
> Pushing out a tagged-tip takes a lot longer than the normal tip
> because a lot more than what people see have to happen on my end.
>
> Reverting a single patch is simple, but we do not want to do that on
> top of "Git 1.8.3-rc0" commit and move the unpublished tag to point
> at the revert.
>
> Which means pretty much everything needs to be redone (one example
> among many is that the tagname will propagate to the htmldocs and
> manpages repositories, so their unpublished histories need to be
> rewound).
>
> But I didn't have to do that in the end ;-)

Yeah, I realized you were talking about that one later on. I haven't
heard anything bad from this new branch from emacs developers, so I
think it's OK to merge it.

Cheers.

-- 
Felipe Contreras
