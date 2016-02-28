From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/22] Mark more strings for translation
Date: Sun, 28 Feb 2016 07:43:27 +0700
Message-ID: <CACsJy8C_YjuR_Py6z+kYA6F8A=rmqemQkQ+2SRBW1iFAUDHT-Q@mail.gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com> <xmqq7fhqhxal.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 01:44:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZpT0-0001Fd-HS
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 01:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756852AbcB1An7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 19:43:59 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34007 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756791AbcB1An7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 19:43:59 -0500
Received: by mail-lb0-f170.google.com with SMTP id of3so63413314lbc.1
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 16:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+XqusupWzQs4c+BEeaGMQ4iGD7SSPVWzKwQN2j4iHw0=;
        b=uHILW3qbhR6I60FMNh7/Xbj4AAfvwgS28bjJ8xcr7Fl3t3Ef/D4r7ILbR+r2KraBOC
         5EICKVsL5Xij8bZ4TyotW+6uXAJW2pRHqYqxwMCHXzwcrlSmlScZCUm076ZKSl6TwYkx
         70CAM9MF0CRZB2Dl8BR6xkianO2MhDqyrtHCoAYd2QY7SoNWmB5MmNf9svplEt47IWd/
         C+EO3xe0LO7Mv8CJcXlUCqFjWbWmmOJa6lBOsd652BapxkGMrB8AfxtXXNUgwoPecQdn
         l0a57Co43jilunKjz0NR4yvj0VDlIxwfdJc3WGceGfYtj1USnH0es6MefJ+3tseSXjd0
         AXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+XqusupWzQs4c+BEeaGMQ4iGD7SSPVWzKwQN2j4iHw0=;
        b=Q/+ebJ+pWjJ+taznGXGC0718LRPfY6GI1Pz8bhmnznEygs4R+kvqVZ+NhZPH3mJqNy
         HIntu3faVr0jS9jzLhLRqxQU1shTBY9zXhlpNYy2dxb17HIleJEyzVzt8gxy//jvwii6
         N78PgfGY1iWXBN5OjL3Lh7sZUZRWu9k39UMYD0cV2V4LXAILqe/CDuTweB1auqJpbecX
         lxhvnFn5ms+KbIo2eNvAx4nq+QN0V6iec4CCJj/6b8ALRTiEC6AMnaNpgnUd8Bes0JIu
         bqXKg9KSLKSwF6B+nOsp+jyqNiZ/PmbpRf+jgrYPcVZYHRm0sCz5sexUchyGQKckq6k6
         hLSg==
X-Gm-Message-State: AD7BkJIlTSeoSjf4jCM5M/o0ygPo56Om9VUYTs0NJ27VrQw9ZhF/FgCyS7kMxoshYSe7n6lqcnbvZjSXEIkDAA==
X-Received: by 10.112.130.41 with SMTP id ob9mr3036161lbb.81.1456620237252;
 Sat, 27 Feb 2016 16:43:57 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sat, 27 Feb 2016 16:43:27 -0800 (PST)
In-Reply-To: <xmqq7fhqhxal.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287736>

On Sun, Feb 28, 2016 at 12:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> We'd still want the fixes to apply on top of relevant topics if we
> could, as the fix to the topic itself (with or without i18n fixes),
> when we discover that it has a huge flaw not desirable in v2.8.0,
> might be to revert the whole thing, though.
>
>> I'm not
>> sure if there's enough time for translators before release though.
>
> Also we need to get an Ack from the authors of commits we added in
> this cycle that these patches fix i18n bugs they introduced and make
> sure there is no "this i18n mark is not appropriate as it is a
> plumbing output (or protocol messsage) that should not be
> translated" response from them.  It won't be like I apply these
> blindly today and ask translators to start working.

Urgh.. if there are only a handful of topics (like in 'pu' and 'next'
now), I could go identify author/series manually. But there are 118
topics since 2.7.2 and my series changes about 300 strings. Hold on
tight, let me write something that blames based on diff...
-- 
Duy
