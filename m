From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Feature Request - Hide ignored files before checkout
Date: Mon, 10 Dec 2012 10:47:04 +0100
Message-ID: <CABPQNSb_ovfJ3oO0rEYd5GXU37Xvk-3mhEtX07BX1OCtoFOExA@mail.gmail.com>
References: <000301cdd4dd$f8554090$e8ffc1b0$@gmail.com> <CAH5451m-JcgLtvVER1UgvsFzemb=otG3XttR4j2s=eFnPrPyEQ@mail.gmail.com>
 <000001cdd67a$39be9d40$ad3bd7c0$@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Ardill <andrew.ardill@gmail.com>, git@vger.kernel.org
To: Matthew Ciancio <matthew.ciancio16@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 10:48:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Thzxy-0006bV-BT
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 10:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958Ab2LJJrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 04:47:46 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62387 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab2LJJrp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2012 04:47:45 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so2218270vcd.19
        for <git@vger.kernel.org>; Mon, 10 Dec 2012 01:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qv43wwYyr9W7zskjDXkER9Uzn5rngnQ4aPHuShqP9XA=;
        b=Be2pPkogdXW/fDEC5EA+aRCk8hKSCBkX6tgBJ2RqlZmrJ5QccospNOfgiYSrYzuHfB
         QwyxR/c51OJR6xLBacT7GK2aTvW4wfEayLtfnmLyKZbomWgEtO4twuZ79Se8gVEVX/r8
         2moQ4C4uIFhLn7mXgixb9bnRoUhw9c+VSDgQXBZavmGs7BADnMkpAsfaiV+RYVgCZaZU
         +DudFyWUruBs0EXwZmi9D1wFCYO5pd39eLC8UdOvLvF04wiEnoqwdfnkw8UpAnFFoCo+
         V1r0cVj2NQkRiD8s2/jz7T+Fk9beiSpLP9GtuI6PuIQZIyh4+z9T9aJ9sfREiSzcsZfO
         ahZA==
Received: by 10.220.150.14 with SMTP id w14mr8609252vcv.13.1355132864728; Mon,
 10 Dec 2012 01:47:44 -0800 (PST)
Received: by 10.58.169.106 with HTTP; Mon, 10 Dec 2012 01:47:04 -0800 (PST)
In-Reply-To: <000001cdd67a$39be9d40$ad3bd7c0$@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211253>

On Mon, Dec 10, 2012 at 3:01 AM, Matthew Ciancio
<matthew.ciancio16@gmail.com> wrote:
> Thanks for explaining that Andrew. I guess that was my intention: to have an "ignored file snapshot", but I can see now that it goes against Git's definitions and is not really needed.
>

I have played around with the idea of backing up files deleted by
git-clean in the object database, maintained by a reflog (similar to
git-stash). I did this to protect my code against my fat fingers, but
perhaps this could also have been useful in your case?

https://github.com/kusma/git/tree/work/clean-backup
