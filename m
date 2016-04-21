From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 10:00:47 -0700
Message-ID: <CA+55aFzk4rZFdhOjkPDqFC3_tk4BUvx4-STsY2L_tKMH2FxCCA@mail.gmail.com>
References: <20160421113004.GA3140@aepfle.de>
	<87lh473xic.fsf@linux-m68k.org>
	<CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Olaf Hering <olaf@aepfle.de>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 19:00:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atHyJ-0002Fa-4n
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 19:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbcDURAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 13:00:51 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36085 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbcDURAu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 13:00:50 -0400
Received: by mail-io0-f195.google.com with SMTP id s2so11321739iod.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 10:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=3GnKj3h1u7qJZc5rqGeplGRdteDaHbyzhoBpx+L1U88=;
        b=ftU7yyy/MBZTzfFrwyZ+slW7A1aOH2fky4svWM+XgiDG1Mn+gbD61C29qETU8FOQ9+
         AOAqd+QW+Ak1VjYcRyaCiLcN31S6s2wHpjH2DNgqyVKstQEBRmv5me9SDUG+diHwlb+A
         riKX3CEWXYfm16m23kdV2mrAjvNiFl1B/NScYAuWbHMo1Zyr+ov+oqgQXH3kl7u++OiV
         a6bi+32/yQnqAHAp0KWbQ+/Qu6aPaGfBus7mpXhrTeoJxj/jVpXtr9+7rCzWow20OA5l
         zHajNtzXj/HBxT45BrkJC9JUI0f2N8iyt693iQHxFNtqFm+8GZ24MdxYgvuln5kVlguY
         9YiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=3GnKj3h1u7qJZc5rqGeplGRdteDaHbyzhoBpx+L1U88=;
        b=EHkXXVsPco5VxCGXTcbxuc0vVm4CC/OqJnqegHXtGM4hT9IfOTcTrcSiFZg8hFKq3B
         0fX1N5snjkJW/vAcbhdJBqloyCV88ZNBAL/5yfo+OeYnvT9Youemyiv7RXh26O+8cxmF
         6xhq4uL5maiWaQdtMLk6y4S22z/WOt4H/DWRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=3GnKj3h1u7qJZc5rqGeplGRdteDaHbyzhoBpx+L1U88=;
        b=ComnXFrf8b69OSXM+prJ11WhMKFCaf+Kc4xTf21WFd7gqShwjgLIfyQ93FgPEk5NU9
         F2SS9J3rWLaueOusWR77TKI9N1hUZwNjWzc9oCCG8liir2A2akWkVJ3zl7f1XDbSeub1
         dEJxUWDvv27wDUH0K3VGT9hMUDOfc/Al7mIS9qlwOafT5kzwUnIarYbMlhFgiQguqjKt
         BmUd2J00Vg9iitabhcy5/ZvLwb+fVYNfjCMh3AklqM6+jy22BrRmbUrZRn+lNvL9hAPa
         reRMujV16GgaKMh6JQnwUEMlbQn/9uOVoM65hirRh4bw0rr8dUIhBbPNic4cFr5LXrxx
         ORZQ==
X-Gm-Message-State: AOPr4FUphlNZiSR44J0fisRXHDXgj3OgJxWxqfSFrIx20gqTnMpaVdJBzRYxLgdm9/TIri4wGv0L7kPQ7vDlJA==
X-Received: by 10.107.130.148 with SMTP id m20mr20092909ioi.137.1461258047636;
 Thu, 21 Apr 2016 10:00:47 -0700 (PDT)
Received: by 10.36.2.9 with HTTP; Thu, 21 Apr 2016 10:00:47 -0700 (PDT)
In-Reply-To: <CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
X-Google-Sender-Auth: uWudaAhaKa8LpjecsDZSY5gFgmc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292127>

On Thu, Apr 21, 2016 at 9:36 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This seems to be a git bug.
>
> That commit aed06b9 can also be described as
>
>     v3.13-rc7~9^2~14^2~42
>
> so describing it as 'v4.6-rc1~9^2~792' is clearly not closer in any way.

Hmm. I think I see what's up. The git distance function has a special
hack for preferring first-parent traversal, introduced long long ago
with commit ac076c29ae8d ("name-rev: Fix non-shortest description").

Changing that

  #define MERGE_TRAVERSAL_WEIGHT 65535

to be a smaller value makes git find the shorter path.

I do not know what the correct fix is, though.

              Linus
