From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Update diff-highlight
Date: Sun, 21 Feb 2016 23:49:03 -0500
Message-ID: <CAPig+cRRX4k8jR02YOGTGHUnbOmhHF0oMc-6aCOWuMOpi+BG0A@mail.gmail.com>
References: <00000153072f5465-fd36f07c-e5e6-4a0f-8cf1-77be99424892-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Peter Dave Hello <hsu@peterdavehello.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 05:49:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXiQp-0004e1-DO
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 05:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbcBVEtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 23:49:06 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34181 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbcBVEtF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 23:49:05 -0500
Received: by mail-vk0-f46.google.com with SMTP id e185so119477729vkb.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 20:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KxdEyrPTPZNsK6GjEmObo+CvqVkP63eZKAau0UYcj9Q=;
        b=n/nx9d0Pd9J1soDey/mV942/DasfzZLUk2VykX3UZ/Pb8RV/WyLbDevcJ7ODXwi2Pf
         vVZhaKCFQLTlhQ5c7XIEGtMgtmbyOLJZxB7Qghfl3yEBGWC3Yrr3QQzVGlmk+hBFdp7x
         hoyswxz98bUSeSwFlLOISGS/LZ54MQl2BoWh+A96RfW5S682jx9JCx5IwxByxm96fKAM
         W82JT2EiIOqkSrdx1JVgG3RBRMBmZm7jdZX6xTlMjmqxPT9hWEThsYINMTlXjGdhr8cT
         QxVlZMxEv3FVSqfWw84KjuPPwpiT2BCvnu4llgfJUvWWJXjST2iC2QlrAovNDYSJ1TVu
         DXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=KxdEyrPTPZNsK6GjEmObo+CvqVkP63eZKAau0UYcj9Q=;
        b=OpyYxE8ltuyE1WX/NqYh+milIFs7tlZxK0h+8doizyPwnI60FQcPpuFAQlU/eN5gOf
         ok8jm0LM9GXf+a65oHs7dwSMpoOLe/atBJbQf13ZxEpZZfDd3SYc7HUTizcaSdGgEl7T
         20+h1bbZsGhIPuaBM7R+gdVvZofeIqcn6iv36T2k5CisQiSTC2lEiZ6ZYipqqyjXt94V
         +hUVXgjJA1r2RgJmU0odUfY9Vpch8Ix9jrB+s6ooAEu+SYGKQkJmdq7NDjRoYMHUk2QV
         EOhBFF92ST65UCak+n4smiY4igBTw6cq0gGbZN7kUvja/iez5sT8c1faFe7jqcoR6GIS
         K7xg==
X-Gm-Message-State: AG10YOSr1WtjY+fGjoijYuonKa2/Kr4aHfEh/7y+6UQil2DE3Vp/9X3NMdtVwpla31/lhXeNCKMpZD6+S7jFbg==
X-Received: by 10.31.47.135 with SMTP id v129mr21831822vkv.115.1456116543482;
 Sun, 21 Feb 2016 20:49:03 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 20:49:03 -0800 (PST)
In-Reply-To: <00000153072f5465-fd36f07c-e5e6-4a0f-8cf1-77be99424892-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: XQUeDpkxxMuuouWiol4udHzfNko
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286879>

On Sun, Feb 21, 2016 at 11:14 PM, Peter Dave Hello
<hsu@peterdavehello.org> wrote:
> From: Peter Dave Hello <peterdavehello@users.noreply.github.com>

This "From:" line looks suspiciously incorrect. If anything, you'd
probably want to drop the line altogether or use:

    From: Peter Dave Hello <hsu@peterdavehello.org>

> Update diff-highlight

Patches do indeed "update" the project, but this summary line isn't
telling us much about intention of this patch. Perhaps rephrase it as:

    contrib/diff-highlight: stop hard-coding perl location

> Use `#!/usr/bin/env perl` instead of `#!/usr/bin/perl`
>
> So that it can works on FreeBSD.

s/works/work/

Also, you probably want to combine those two lines into one proper
sentence rather than having one sentence plus a sentence fragment.

Your Signed-off-by: is missing.

Thanks.

> ---
>  contrib/diff-highlight/diff-highlight | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
> index ffefc31..b57b0fd 100755
> --- a/contrib/diff-highlight/diff-highlight
> +++ b/contrib/diff-highlight/diff-highlight
> @@ -1,4 +1,4 @@
> -#!/usr/bin/perl
> +#!/usr/bin/env perl
>
>  use 5.008;
>  use warnings FATAL => 'all';
>
> --
> https://github.com/git/git/pull/200
