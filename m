From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Sat, 25 May 2013 18:35:47 +0700
Message-ID: <CACsJy8CW-xtXR15m80oaoex0QF5Vi2L2-kqEzOPxCY2UBmdhxw@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <CACsJy8AEkmiWP46tOBkXRkWDGO+k5YW+GJB-ak8HfTpghQP5eQ@mail.gmail.com> <CACsJy8Av8LmiefR5XFuFadZERmivZAAB9TbysFjeUSb2hzgWBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 25 13:36:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgCm4-0002Jo-EG
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 13:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275Ab3EYLgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 07:36:20 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:61639 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab3EYLgT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 07:36:19 -0400
Received: by mail-ob0-f170.google.com with SMTP id er7so6568987obc.29
        for <git@vger.kernel.org>; Sat, 25 May 2013 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=G4t0WgAJ3NgppRiNprYV8Hc3ZrJLQ6tl5fVemvp2fWM=;
        b=fXifch85YeQzkTZeUgW7zc0oVybn2iOP+PeVZnVQAboDnRi8Ivr3wKY3dUDLAwkVcQ
         Oaf9xYY1M0Il+kr0O99gvPEMmCxQ+MDHkUioJsDCs8RIYvIQ3isI9/zEkio3V6F4cQTP
         yxm15jV91CAdWRP7g/ZXX2YcLXGs61ZGkNNzTTnAXbs7LsWltEXAw6OM097qh0tMeDaA
         aiFdng9FRsvPPaTrWewEKD3FQg/BKOdNJ8cIEzJQodfomihBymq1Ew9BpltlHntwCzGt
         XqjMe5GvVTOZXAt7tg/Dhixf10/Cc0g9l6dlLgwgr1p7R4YFNOHfJnQXIwaob0tpQDku
         DqQA==
X-Received: by 10.60.149.231 with SMTP id ud7mr14133407oeb.119.1369481778857;
 Sat, 25 May 2013 04:36:18 -0700 (PDT)
Received: by 10.76.141.232 with HTTP; Sat, 25 May 2013 04:35:47 -0700 (PDT)
In-Reply-To: <CACsJy8Av8LmiefR5XFuFadZERmivZAAB9TbysFjeUSb2hzgWBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225519>

On Sat, May 25, 2013 at 1:26 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, May 25, 2013 at 5:51 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> I just had an idea that might bring pretty stuff to for-each-ref with
>> probably reasonable effort, making for-each-ref format a superset of
>> pretty. But I need to clean up my backlog first. Give me a few days, I
>> will show you something (or give up ;)
>
> And I can't get it out of my head. Might as well write it down. Check out
>
> https://github.com/pclouds/git.git for-each-ref-pretty

Ram, fetch the url above again. Its tip now is 5b4aa27 (for-each-ref:
introduce format specifier %>(*) and %<(*) - 2013-05-25). Those
changes make for-each-ref --format a superset of pretty. You can add
new %(xxx) on top and resend the whole thing to the list for review.
You can remove "branch -v/-vv" code as well or I'll add some patches
on top to do that later. I have some compatibility concerns about the
"superset" thing. But let's wait until the series hits git@vger.
--
Duy
