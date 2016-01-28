From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Starting on a microproject for GSoC
Date: Thu, 28 Jan 2016 17:17:15 +1100
Message-ID: <CAH5451=u1MB=LJyBv+Z9e4Y5ncHktMw+oEycOWV1YXASaawMDA@mail.gmail.com>
References: <56A96380.3020308@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 07:18:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOfuT-0005ZS-3V
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 07:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932959AbcA1GR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 01:17:56 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:34891 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932605AbcA1GRz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 01:17:55 -0500
Received: by mail-io0-f177.google.com with SMTP id d63so27547267ioj.2
        for <git@vger.kernel.org>; Wed, 27 Jan 2016 22:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3R0XLF0Sn2nyQgq2Co56qbUEIuj9v629DG+VGp77knU=;
        b=LcKv53JXrOhLisg1oPK1+y3WsK2ScKkvphL8HtC1p9pPxxpfrxMKyfwn9Q7VoVvyZt
         s+2h1z+H8x39LSebPtZajxgSgqZhs5l4LA93OaiWP8+41eWcdhjjzLlSeLB2Ol9CXG5P
         Ks0VJkQc08OtNm+nKkm/Oyh8ILZlJnbm7y2W0vVhVdeep/kjIwOu6T/Ao1uMho6B3nrd
         /f2h9u//yqT8jN8Pphvj7x5XsD09grmgwHn+tq140f/kSiGjgO/gyIteHNE/2GqS057G
         IkgFMQKaNU/iY+V/LiI32V276pdt0AqIUn+VSSb06UC55eTDyP4p4iz6MPdhxFtF9yS0
         Z6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=3R0XLF0Sn2nyQgq2Co56qbUEIuj9v629DG+VGp77knU=;
        b=AQXQn6e8JnA2bONlMzTkzWoPPYfhGkzebBoc6pKJgWihg80re1hzERsA61y+hIRtd0
         e/hQLJ0j6BYWakV4+cuSINrQTmKi6tfRb1MrkwVlh2o3SJozlNqaRaob050qU2U17JSi
         XLvqNpWNvAYm1yujBRO8y5e71ORD6FNRBrnmXGwsUEGD8WJaYHOTwEnSInQCjhz66maP
         S414wZ29/MmJ7JcowUxsuvi5WwOtwQTVnUASMIawzsK0GhKlb6imr5ZQdKxJ8bmMZOST
         X6yefDGkeEpIEg8AFeo/iQYwKHhYfyORlmwpJ8iaxWXNXWYBfd5Y+kzGwdrWmtiua9B5
         87TQ==
X-Gm-Message-State: AG10YOQFhDXrpRHDOi7Afx0VB/iCyCBbJcFADs+DxjvLdTa63ltLzLIUSPiYNJXiqPjZqKy0F7sihPhtGr71xw==
X-Received: by 10.107.135.202 with SMTP id r71mr2398260ioi.129.1453961874489;
 Wed, 27 Jan 2016 22:17:54 -0800 (PST)
Received: by 10.36.72.195 with HTTP; Wed, 27 Jan 2016 22:17:15 -0800 (PST)
In-Reply-To: <56A96380.3020308@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284979>

On 28 January 2016 at 11:40, Moritz Neeb <lists@moritzneeb.de> wrote:
> I suppose just fixing/revising this would be kind
> of a too low hanging fruit?

I am in no way qualified to speak to the majority of your post, but I
can't imagine anyone refusing your work because it was 'too low
hanging fruit'.

Indeed, the general gist of getting people to start with a
microproject has always appeared to help potential applicants
understand what it takes to get a patch accepted in git. As long as
the low hanging fruit is useful (your example of polishing a patchset
to get it into master is definitely useful, assuming the patchset is
useful) then I'd say go for it.

In the worst case, if you feel your contribution was not 'meaty'
enough, there is nothing to stop you working on some other problem, or
extending the first further. That said, I do remember previous
applicants trying to do as many microprojects as possible, leaving few
for other people.

Regards,

Andrew Ardill
