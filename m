From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Fix minor typo in hook documentation
Date: Wed, 24 Feb 2016 13:07:24 -0500
Message-ID: <CAPig+cT5aOaKRX_Lhq_Lh+Y+=N+UbyTDaEU-YxKPjKoP9+b-sQ@mail.gmail.com>
References: <CACbrkTpA5qL1aTLGG1ypX06fuyFY4GdMAa4JfjoJnGWp_=WaAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Martin Amdisen <martin.amdisen@praqma.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 19:07:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYdqZ-0003Jw-Vl
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 19:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758512AbcBXSH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 13:07:29 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35355 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758502AbcBXSHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 13:07:25 -0500
Received: by mail-vk0-f45.google.com with SMTP id e6so24532584vkh.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 10:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=iEL1OKpKbpljG/CWFcstmComawfQ1cGFi0XZHqJJ9HQ=;
        b=P9nI8Dgk3f/buStpW/nfUUstxfFMIZkbD8kxRyiGQnMxEP/a+muKfgt5aU3b1x72aw
         Yef59MTLrLDVUFyDvYhuAQGtdGJ8ioq59YZE8LuI5JU4zvy2+d6vlu6tuLw7ksUHaBg3
         HqZOvqIkJXBOipQZ+yoy27xbwDhbD38FdfzAy9ozvSr4Pge4zW9524CnFJZxs6VDg/U9
         HNIt5dRAHYc4l/pSQNWlsoQ4qDPMlJHH6vluKkPHIoI7Dp1yoC0PuD5jnKpU2isCMTnY
         wbsnszeUsJTmeYZKEI6yUqRbQJMD7QigYnghvX+YtDUXbUm5wftM+RwY7DgYfqPtfmeh
         jY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=iEL1OKpKbpljG/CWFcstmComawfQ1cGFi0XZHqJJ9HQ=;
        b=Qd5chqrxHIsRu2iPcUVIdKqPRIcnWxoXYU5ZEruKwrjrUq2Jy5YQFgoDLE8YN0Zoky
         +BsR/W04OiAGVdHDVcu/2t6BlLpPF+PgLC8emkhy8DoHGCKUBZQn1Rka7E31UvwBmrOt
         2gK7eZGYZqW6nVs9QpBEofE9BZsqeS1L4Pk4BfD23peaalv1a0JWXt6HfWFUUXOSd53a
         qpOvl8bijSaDx2mGi6aDydAdf7nZFaLW1aqR9osd3CJ5K9pS28RkTpXG9ncPfEaicQWe
         xC4OiqXEdbGHFhXI2oHhLZqf3626D6M2WHlF0pBtWT9F1l/lWibOVNlM1NijRSOPrB3d
         VGbQ==
X-Gm-Message-State: AG10YOSaeOF5sCrVsYBk5GojE97sL7MQjNIyMpKtrQqGAIqJ02lp7D9DjIFkeXXYvmsoOtNGSUELovSrwXypUA==
X-Received: by 10.31.41.14 with SMTP id p14mr34020358vkp.151.1456337244800;
 Wed, 24 Feb 2016 10:07:24 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 24 Feb 2016 10:07:24 -0800 (PST)
In-Reply-To: <CACbrkTpA5qL1aTLGG1ypX06fuyFY4GdMAa4JfjoJnGWp_=WaAA@mail.gmail.com>
X-Google-Sender-Auth: UEuM-40cJxNzv4Zg8oukFYlERtg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287213>

Thanks for the submission. See review comments below...

On Wed, Feb 24, 2016 at 7:51 AM, Martin Amdisen
<martin.amdisen@praqma.com> wrote:
> From 3f8fd9e5771791a18e89fdb1f1a681eb6fc66ad1 Mon Sep 17 00:00:00 2001
> From: Martin Mosegaard Amdisen <martin.amdisen@praqma.com>
> Date: Wed, 24 Feb 2016 08:43:07 +0100
> Subject: [PATCH] Fix minor typo in hook documentation

When you re-roll, drop these four lines. The first is only meaningful
in your own local repository, and the rest are picked up automatically
from the email envelope.

Your Signed-off-by: is missing. See Documentation/SubmittingPatches.

The patch itself looks good.

> ---
> diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
> index d847583..80ba941 100755
> --- a/templates/hooks--update.sample
> +++ b/templates/hooks--update.sample
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  #
> -# An example hook script to blocks unannotated tags from entering.
> +# An example hook script to block unannotated tags from entering.
>  # Called by "git receive-pack" with arguments: refname sha1-old sha1-new
>  #
>  # To enable this hook, rename this file to "update".
> --
