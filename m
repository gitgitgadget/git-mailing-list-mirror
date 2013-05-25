From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Sat, 25 May 2013 18:24:57 +0530
Message-ID: <CALkWK0mMq9osT6yuhQuPrK=J7b63xxA7r1QVXT4X5nXu+wDouA@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <1369405177-7855-2-git-send-email-artagnon@gmail.com> <CALWbr2yuEczF-G7uJ0r-teUJrZowrY8mYm+xwJmv4+CT6NgDPA@mail.gmail.com>
 <CALkWK0=16dmz548TQoj5YKp0dai7p1dpYAdXiWnnpiQdzyYHQg@mail.gmail.com> <20130525122002.GI27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat May 25 14:55:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgE0c-0006Q1-Uh
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 14:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655Ab3EYMzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 08:55:39 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:59070 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384Ab3EYMzi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 08:55:38 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so15111606iet.28
        for <git@vger.kernel.org>; Sat, 25 May 2013 05:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ATof/sByfjC7Edjdy/nQdvlJXCukCr9w4hcIOX7lXHk=;
        b=UovBwpw7gh+M91++v+3fwiu0eLLXUy5HQTCb0qc9E/3JgB8ULtSWGMgTI7LrOELsSl
         jOJ9dS7sgGdYcVJa6a1wWTvsUSSOHeBOCiekuDbbNDlt+fTFLkuafILfTV85IDAS98W6
         u2pQQECTNQMwrXWZCwJhQpdIxyDrqUaEuf3mE+KM55AXe2x7tUY5V9uDsdNmJ5YYOcr+
         IfUfIr/68ij+QZLrDlMfSzzZOHMgHo4On9xBzHopPtUdarw5w/SFhKPV9AMMXuLf+tAM
         110N+7LKfRwtQ0BFnVm7SST2YqDBDzJ2+9tFva81sSGLzc5s5giQOKbk5yYvNGgumCJF
         fFfQ==
X-Received: by 10.50.178.198 with SMTP id da6mr1650117igc.49.1369486538070;
 Sat, 25 May 2013 05:55:38 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sat, 25 May 2013 05:54:57 -0700 (PDT)
In-Reply-To: <20130525122002.GI27005@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225527>

John Keeping wrote:
> Section 6.7.9 of the C11 standard says:
>
>     If an object that has automatic storage duration is not initialized
>     explicitly, its value is indeterminate.

Ah, thanks.  I'll initialize it to an empty string.

>> More importantly, aren't there numerous instances of this in the
>> codebase?
>
> Care to point at one?  I had a quick look and all places I inspected are
> either static or write to the array before reading it.

I'll run some Valgrind tests to see what it yields.
