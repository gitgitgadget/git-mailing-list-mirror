From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 1/2] Teach --recursive to submodule sync
Date: Fri, 26 Oct 2012 13:55:58 -0400
Message-ID: <CABURp0q0uELTS4DQ=Kqfr+8Pr-KgLcGJaBY_kJE_AiO=BZu+Bw@mail.gmail.com>
References: <507EF86C.4050807@web.de> <1351034141-2641-1-git-send-email-hordp@cisco.com>
 <1351034141-2641-2-git-send-email-hordp@cisco.com> <5089BBE1.3040107@web.de> <508AC63E.6010502@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 19:56:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRo9A-0006H8-6m
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 19:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934096Ab2JZR4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 13:56:22 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:48953 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934063Ab2JZR4U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 13:56:20 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2567416lag.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BFzD95LFI9zkAKXdgKh2zMbuJFgzhQizqEA8eGFs8O0=;
        b=MMm8BeWRNaqGZWh1MRP7V85K3fr8bCkIwxSC3fp/QGxlH/sr6BvG6qJm4Qolhh+M1A
         FXwhWiJgkfKm/nOO/HM2KOYji4BjaQ/q/PZKJUd3SXw66EOwcSDMVstJlntGuZNnKL4t
         RiMbeCNXVQmXd82DAxHPI8CjGUh9x6FM/xTSWuJyH5u1MlFQ59hklFfT9uJ+Hu7sI+S5
         VoTd7PMATSz5gkfCjSpNvLeqljfeKrtIgli87I/K1ln0BZJs6/6SyUYEW96Tl+dAI4Ko
         0wICieymbGlBn7oTEaK38Xmz3bS1bjU7MYJhm0VF+uQQ1hXjUSnY3LQs80RMEYzJ1UQ7
         MUkw==
Received: by 10.152.105.135 with SMTP id gm7mr21249324lab.22.1351274178426;
 Fri, 26 Oct 2012 10:56:18 -0700 (PDT)
Received: by 10.114.26.166 with HTTP; Fri, 26 Oct 2012 10:55:58 -0700 (PDT)
In-Reply-To: <508AC63E.6010502@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208471>

On Fri, Oct 26, 2012 at 1:19 PM, Phil Hord <hordp@cisco.com> wrote:
>
> Yes, thanks for catching that.  I think I should add a test for that
> except I notice that sync doesn't take any other flags useful for passing.

Which, of course, suggests that I should not add this
flag-propagating-machinery to submodule-sync at all. yes?

Phil
