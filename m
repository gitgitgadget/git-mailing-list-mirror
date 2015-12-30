From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] dir.h: remove orphaned declaration
Date: Wed, 30 Dec 2015 21:40:40 +0100
Message-ID: <CAP8UFD06x9pyvuxBZzTY8pZnYUbetaX8HxJ+HtcMwfDYnCyeNA@mail.gmail.com>
References: <5684104D.6000001@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 21:40:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aENY6-0006qG-6A
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 21:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbbL3Ukn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 15:40:43 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35218 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbbL3Ukm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 15:40:42 -0500
Received: by mail-lb0-f174.google.com with SMTP id bc4so120044598lbc.2
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 12:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nz3gzApiNcS8tvVk1VUFKlOdfT9F0UMA3ohocWHvPgo=;
        b=MOqbLEU0DdxgBVDjSj340jkBuqeJNryTr76VDOfwUV1Nou9Pj4/xbc8YzlMh5vP/Vn
         1FxGouhOhZDEaqfpmdrTgB3vTnkSvQAFfPUY3WjuMUeuuIBixOAyRhnSDQN5LyUEjh5B
         j53Xa+l/gJV1y8Z0g9nI4sZXfSi7DUubm/d1w6BN2ffkTvppe0vD8fbKaXwmS2xEnzeD
         Zk08t5yDimQuEmDzQOR/xSJOjRpAloRQGo2f2OzE8D7NxtnG6aOu9/yTTwtzF7Kp0V/G
         JFzo3xCQ1uVMuhYECh3tlh/JXb1b6MbkdR5/1PNHBQQfUNKXB3/FS8DPWiaCZvjwWkd7
         4+5w==
X-Received: by 10.112.150.102 with SMTP id uh6mr23636327lbb.16.1451508040541;
 Wed, 30 Dec 2015 12:40:40 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Wed, 30 Dec 2015 12:40:40 -0800 (PST)
In-Reply-To: <5684104D.6000001@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283195>

Hi Ramsay,

On Wed, Dec 30, 2015 at 6:11 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Christian,
>
> If you need to re-roll your 'cc/untracked' branch, could you
> please squash this into your patches.
>
> You seem to have only half applied my last fixup patch! ;-)
> (I'm guessing that you had already renamed the function
> locally before I sent the fixup).

Sorry I completely overlooked your previous patch.

This patch is now squashed into my current series:

https://github.com/chriscool/git/commits/uc-notifs42

(See https://github.com/chriscool/git/commit/699cd541a863ce027e20ded1c3d7300e146ccfd5.)

Thanks,
Christian.
