From: Stefan Beller <sbeller@google.com>
Subject: Re: Bug in Quit shortcut key
Date: Wed, 10 Feb 2016 16:07:15 -0800
Message-ID: <CAGZ79kbZt1szeoEoPoeoa6Yc1sXrymPCzarkcusaXcYxOPhpnA@mail.gmail.com>
References: <CAGKvVu6OEKEmyoECP=YMD9F8BPe__mcG7sDkN_Qo1ZnqDryTjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Shikhar <shikharid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 01:07:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTen5-0000Be-7M
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 01:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbcBKAHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 19:07:17 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37543 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbcBKAHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 19:07:16 -0500
Received: by mail-ig0-f172.google.com with SMTP id 5so26233714igt.0
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 16:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jrO9m1hmAJXZP4ptYewIoVvmytdykNWj7dVucQIDJNc=;
        b=LURYPJg0y5+J9zaOaD2WRPWWWf6Ry1kQ6k8zraVTSyM360GsEZEBdkqnqv546/jPTo
         v4y2KbSBeJXOESs9qhHtC+peIIugSsEGx9DYbLfuGAtdP6OELWWSYynuFLBjtcRg+G2C
         11QJiPuvHG4nBNQzjiuOdRsTWfQE+P1UrD/N7+xKRfcjO+tXOr+3ISKkQGiH7XHpkGFK
         xctZk++UbgO6JoK+NG8FWuMSWcwGmn3Bxyb4B6N3o1irB45Zd5/72CNkF+jgNhr7AkFN
         9veJKH6/wy6/JQ1JuyLKkCiMN2nRx+lIvEyNI/MW+qittAwNjjbKUbDgoPiekFc6Y+wL
         zOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jrO9m1hmAJXZP4ptYewIoVvmytdykNWj7dVucQIDJNc=;
        b=lQP0MEPWxjEaBvuP6cJhCH9oOpuA28QmEOQlECaJsBjH/30AJxiKbRCCLFa2APMSZE
         jEO59A1hWrOuxSn7q4ZS3pQrp9yMPkye//QKqJz94sT52bzM36lb/mw2zM+uSoX+x8TT
         EMnWk73Kbx82zAT2TZQtCU5nlUpOiifv1Lb0CX0lcajgqJpqnIXBUOztw5UDaAHCSbbp
         YEiA8yEgLv7SWge3PfOfOCSo33oW8u0VmSGVj1ZT2XVp1Z+1BnirIS70xVv28bfhvk3r
         7bjv5oniA/Viq9c1IUIBRSNTh0KdX/gLxU99dwNo3JRt+PJyN9z7LuvUZ9b8wHoQtCJk
         yF8A==
X-Gm-Message-State: AG10YOTxhc9v3z7hr8j2lkZeyogXYwazMZlYVC3pKypZgFoutsJ+mifZzGTImSZp9tEQTXFwd83fgngX0eVlZZXC
X-Received: by 10.50.112.10 with SMTP id im10mr5882100igb.93.1455149235471;
 Wed, 10 Feb 2016 16:07:15 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Wed, 10 Feb 2016 16:07:15 -0800 (PST)
In-Reply-To: <CAGKvVu6OEKEmyoECP=YMD9F8BPe__mcG7sDkN_Qo1ZnqDryTjw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285942>

sO YOU ARE TALKING ABOUT GITK (oops, still had the capslock on ;)

I can confirm the bug that CTRL + Q is not working while capslocks is on.

On Wed, Feb 10, 2016 at 5:50 AM, Shikhar <shikharid@gmail.com> wrote:
> The shortcut key for quit is ctrl+q which is shown as CTRL+Q in the toolbar.
> But the shortcut key only work's when Caps Lock is OFF, it gives no
> response when caps lock is ON.
> --
> Success is not final, failure is not fatal: it is the courage to
> continue that counts.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
