From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] docs: clarify git-branch --list behavior
Date: Thu, 31 Jan 2013 19:20:45 -0500
Message-ID: <CAPig+cT21Fx6BaD=1jT7KSBZSZkWu-A-0U+QsM2qO8g5gki=YQ@mail.gmail.com>
References: <20130131064357.GA24660@sigill.intra.peff.net>
	<20130131064545.GA25315@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Wu <lekensteyn@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 01 01:21:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U14NR-0006kH-9t
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 01:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab3BAAUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 19:20:48 -0500
Received: from mail-vb0-f47.google.com ([209.85.212.47]:38978 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab3BAAUq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 19:20:46 -0500
Received: by mail-vb0-f47.google.com with SMTP id e21so2100354vbm.6
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 16:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=500cReSmYA9x2TJD40ujttbSHN80KU6vlW9HDGaqKUo=;
        b=Ccnje50gPL9JukMgZ3ZGZypz2fZBiGd8Lm9i6EtLkY8x+da7NehJha1oT3R0qDjGHW
         lrO5iqlKFaVY24i/0WJGoTbK/u0+t14l6PhhPrlrJTjArOJtEJpbq+g9LEA9TIfXONxR
         roQqOFn0Xp+io95pR8evd1Z2UOJRLrRqJRZO8T1u5GS4L7genbP/J8vp57wuY3x2QTuO
         Jy34DiiHKsdv2vy+/Mi7q103F6P2CPxHipEWTAyozMC3qWzBwBsyn64wgUrMXjET59ns
         25/i2XzYOo0b1n+Ax8q3RVw3I1PsB/A2QExjZwzu9HooVSjLItfMFQCAE2xf8eHGZA7o
         fYLA==
X-Received: by 10.220.106.133 with SMTP id x5mr9677262vco.61.1359678045953;
 Thu, 31 Jan 2013 16:20:45 -0800 (PST)
Received: by 10.58.75.15 with HTTP; Thu, 31 Jan 2013 16:20:45 -0800 (PST)
In-Reply-To: <20130131064545.GA25315@sigill.intra.peff.net>
X-Google-Sender-Auth: j5CxeOAu7lZQZVt-dNjBcnct2bE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215191>

On Thu, Jan 31, 2013 at 1:45 AM, Jeff King <peff@peff.net> wrote:
> +If `--list` is given, or if there are no non-option arguments, existing
> +branches are listed; the current branch will be highlighted with an
> +asterisk.  Option `-r` causes the remote-tracking branches to be listed,
> +and option `-a` shows both local and remote branches. If a `<pattern>`
> +is given, it is used as a shell wildcard to restrict the output to
> +matching branches. If multiple patterns are given, a branch is shown if
> +any it is matched by any of the patterns.

s/if any it is/if it is/

-- ES
