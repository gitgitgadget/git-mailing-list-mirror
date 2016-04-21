From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 09:36:48 -0700
Message-ID: <CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
References: <20160421113004.GA3140@aepfle.de>
	<87lh473xic.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Olaf Hering <olaf@aepfle.de>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 18:37:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atHb5-00084c-8L
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 18:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbcDUQgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 12:36:50 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:35152 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbcDUQgt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 12:36:49 -0400
Received: by mail-ig0-f195.google.com with SMTP id fn8so10914221igb.2
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 09:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=HlNma1lS8DzQoMkBvTxtHHp25yClr4Tcglr0Wl4mZk8=;
        b=Fxh60UJYab3STEGqLAaB39NJnQppsADlRNI3C9ptf+EiP1YKmuoucWPVQAtOmbN3Dd
         BQGLdgcrpHcbXT0ECgrxnYJVU5YI0f6gljYaEpYEu/R04qwaixs7+eAZ5eeKB6D+IGWE
         TUCFELghED0O7GPWynHYfZSWyyqtW9cLy1mfemd1Top/GVhPssOuW2HQaUxxNyMeN99k
         8XId19A6iEbLgHey53XmzFFZwV/aUbiEarsN9YgBGB9VY0CX4hfPZYRSbGdGwVsOsT7v
         DBLSNoZ50RWsUhQi36CMiRvmn/V60tUbSpm1Yq1XN97byO0LinOJe/XPULnmgZYNIw41
         jwxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=HlNma1lS8DzQoMkBvTxtHHp25yClr4Tcglr0Wl4mZk8=;
        b=PTuKEwV2rVbqNJbxQ+bFIdnVd9ZV+s6va1H6WSZEwEZ61pLg9+t3iY+qy9OIhFCZ6u
         zJyEYespTyKvPrxxcnigHXFMYhkbtbLG1ybl4hy2/7IOQNgSyPs5XVGBKfMxddk5D6QS
         56KIMlSOEsrs6l8jjFx5ytooMmej04SDyASrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=HlNma1lS8DzQoMkBvTxtHHp25yClr4Tcglr0Wl4mZk8=;
        b=XGSMJmvaHxyNBzlJ8xZiMCIxFZzG1zV3SfZrgFV44baW3hTLv8ct9I3hYav5Lvz/UP
         9e4Ea7kh9h1KUaZ1Ik4pdT+a2Ds+/B5zaCOhgYmBFkxRJ41nPIJALJXU7CAAt8mHQzrp
         r0HAyqV6nNcywL5NZecUkpa0qGebo/ofyS1tP30X4G7gX7dfcS61MixLsf6GV/1Ax2X1
         nYiqNuhG8xbzYfnhke1ZN50y6oVykHwRVnpx0BYvHZbZTGOoGXV5+aHwZYnhN/iz5Mf7
         4tmOknvbXOEzrX2X8p5HuecU69wmN5EsW0xSTwBPp8cB3MoIW+87c6r0Qh+61sOx0V8Z
         qoCg==
X-Gm-Message-State: AOPr4FUvgHS19OgfrCWEo0MET8VxIgk/aYNGhp5KbW1/7Q67eQRsFB+b7FAL8Z7NaYtY1o6OOtNkWtAwn2kA+Q==
X-Received: by 10.50.120.198 with SMTP id le6mr4880587igb.25.1461256608184;
 Thu, 21 Apr 2016 09:36:48 -0700 (PDT)
Received: by 10.36.2.9 with HTTP; Thu, 21 Apr 2016 09:36:48 -0700 (PDT)
In-Reply-To: <87lh473xic.fsf@linux-m68k.org>
X-Google-Sender-Auth: hz92sJ6JgkrprYiOun9YFcgkJZc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292122>

On Thu, Apr 21, 2016 at 6:24 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> The branches recently pulled by Linus contain commits with rather old
> author dates, eg 8cad489261c564d4ee1db4de4ac365af56807d8a or
> 281baf7a702693deaa45c98ef0c5161006b48257.  That will probably cause git
> describe --contains to take a different path through the history.

Nothing in git should look at author dates (except for the obvious
code that then shows the date).

The committer date is in fact used for the traversal heuristics for
some cases, but those are different and recent in the examples you
note.

This seems to be a git bug.

That commit aed06b9 can also be described as

    v3.13-rc7~9^2~14^2~42

so describing it as 'v4.6-rc1~9^2~792' is clearly not closer in any way.

However did git decide to use that further-away name? That looks odd.

I'm wondering if it's because of the new root commit we have, and that
confuses the distance calculation somehow? That came in somewhat
recently (mid March) with the GPIO pull.

       Linus
