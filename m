From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #07; Tue, 22)
Date: Wed, 23 Apr 2014 12:43:21 +0800
Message-ID: <CANYiYbEtLqL1HStJOp66wMk-Zx=1rPb-q99UDTG+n7WLy2FrBA@mail.gmail.com>
References: <xmqq38h52c2d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 06:43:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcp2N-0004OT-D7
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 06:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbaDWEnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 00:43:23 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:44866 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbaDWEnX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 00:43:23 -0400
Received: by mail-wi0-f177.google.com with SMTP id cc10so530954wib.4
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 21:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ib1hZ8nUOOQH6O5GjgI02o+qfpNcpDYAoDr1XWEkvdg=;
        b=caUCvj+tc78AjBN/YmNA5Ckj3j936Dv+ZSW82ElFi85J9BJvUmuugJw57UYPJ5bbXg
         lEac3wYKQslUOw4zuUkkR5JKsC07Ef1GlZAjPfQpRt66vdg4kt29x+pkoN3slRMx1MOu
         UhyMezvs3kn5043mvCf36w5Q9CLI5glBBxFDajijrx3OqGlCZfg3TXbdNtvQEY6Jg5Pu
         o7fHmJvYYQr8yHN34N6VFfY//cSTVqgfZgTIY+dzL9DGZzBYuHpERRjrXgHKZcKIzAsh
         YAKPVqZtd4P00DLTLwm+p2sk0z0Y1w9z+MyDOYNlHbwHjXQgyxnp0vNXEmcph+R+kR/e
         HHXA==
X-Received: by 10.194.175.70 with SMTP id by6mr36760988wjc.3.1398228201474;
 Tue, 22 Apr 2014 21:43:21 -0700 (PDT)
Received: by 10.217.58.65 with HTTP; Tue, 22 Apr 2014 21:43:21 -0700 (PDT)
In-Reply-To: <xmqq38h52c2d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246809>

>
> * jx/blame-align-relative-time (2014-04-22) 2 commits
>  - blame: dynamic blame_date_width for different locales
>  - blame:: fix broken time_buf paddings in relative timestamp

Should substitute the double colons (in blame::) with one.

>
>  "git blame" miscounted number of columns needed to show localized
>  timestamps, resulting in jaggy left-side-edge of the source code
>  lines in its output.
>
>  Will merge to 'next' and keep it there for the remainder of the cycle.
>
>

-- 
Jiang Xin
