From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v9 00/19] index-helper/watchman
Date: Tue, 10 May 2016 19:45:29 +0700
Message-ID: <CACsJy8CN_KzoFaROAksSuT1-sJgxP6zd2iJbqq-Dqq6EQyD_Vg@mail.gmail.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
 <xmqqa8jyuczj.fsf@gitster.mtv.corp.google.com> <1462832134.24478.49.camel@twopensource.com>
 <xmqqy47iswhj.fsf@gitster.mtv.corp.google.com> <xmqqtwi6svzx.fsf@gitster.mtv.corp.google.com>
 <1462835573.24478.53.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 10 14:46:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0738-0005aW-Ez
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 14:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbcEJMqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 08:46:02 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33808 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbcEJMqA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 08:46:00 -0400
Received: by mail-lf0-f44.google.com with SMTP id m64so13381522lfd.1
        for <git@vger.kernel.org>; Tue, 10 May 2016 05:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yqzYEVjDS/CTNhvypQIsBfBwL/K4c3ouQ2f5U4ckoB4=;
        b=ZbCWpc5OSclxthHR+ttqfIDMjDSQfGa81aFF8zXoR5pA+sdsi1lYlrvZF6J/WLyyyw
         AZ3qz9cgFCo0ojOs3fwcIVz8png6nFn1gASVF49n4yeeqSu3nd6pBwQWZbQWNoZ0CmTQ
         AHdhf2z3nVQvLDCg/JFVADFSp9NZ6eVfARS+Lr6Te84WqvVeZ+bW6CYqPA6QQim/UN8q
         Zj9juMLvhC8wDr81eMcAhnorx+v9iT4mFRJKD3fZR4Qj4tYmxoeJP3NLjxIsyIDS9kvu
         VGkwhdCRO+zkljLBBRIH33XmoXNBf+4toHwnPJsQgPgnL/S+o01dqApibg8nKrK/3UVC
         k8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yqzYEVjDS/CTNhvypQIsBfBwL/K4c3ouQ2f5U4ckoB4=;
        b=MuimHCnDTvzVI1qx3h0FIUPJYo9Q5HcIaLNcH+jrf4Bkm+E/eBGN+cqm650R7XK2CN
         Y8KIxPR0mHp7ldh8TPzLOQkNV5J0GJWm31komigUFpPoGKq0IAhZC8NQ+lioNQOquEkw
         xjQ0s8dXGo3hCqckZRxfzosrVSblWWoxN/wMc6EN3tNCGjdFNfJqeUKRhBjLpfR9Ri9h
         u/VE7P+eQsLcAOPlKEYzO8+jhLYtkpfmtpkxd8Dx53ehTxoN6qArQJuYlj7J42C6mB0b
         GdOPeijrxtplNLudpYybhhPtNEkRboeQszn5NYdwZOkGT0++0Q+x7WWS9DKadwWks2uS
         rhPQ==
X-Gm-Message-State: AOPr4FUS4ILT+sCF2YvmteiWWBmkAI8ZqOmTSbjmN1KMFqDT1gpeG10WwRAoM3ZiB/q/aCb8q1XO0fyizy3+bg==
X-Received: by 10.25.42.147 with SMTP id q141mr17114713lfq.94.1462884359062;
 Tue, 10 May 2016 05:45:59 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 10 May 2016 05:45:29 -0700 (PDT)
In-Reply-To: <1462835573.24478.53.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294127>

On Tue, May 10, 2016 at 6:12 AM, David Turner <dturner@twopensource.com> wrote:
> I think that's a SIGPIPE on the first git status.  Weird, since I just
> added sigpipe-avoidance code (in v8).  Does anyone have any idea why
> the sigchain stuff isn't doing what I think it is?

SIGPIPE code works. I tested with and without --detach (suspecting
fork causing problems). I even logged all sigchain_push() calls to see
if anybody else is interfering (none did, at least without watchman).
Problem is elsewhere.

There are two problems with logging code in index-helper though. The
redirecting std{out,err} to /dev/null should only be done when
--detach is given (and I' m quite sure daemonize() already takes care
of that). If --detach is used, log_warning() can't cover die(),
warning() or error(), most importantly die() for example because of
bugs. I think you can call set_die_routine() and similar, just be
careful not lead to recursive calls (die() is protected, but I dont
think error and warning are).
-- 
Duy
