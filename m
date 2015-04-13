From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] CodingGuidelines: updating 'rough' rule count
Date: Mon, 13 Apr 2015 01:00:11 -0400
Message-ID: <CAPig+cTgNzO5NGabOsaSZOq7Y47OBXJz9mnS-MfpoQ2MANzrng@mail.gmail.com>
References: <20150412234720.GA37658@Serenity.local>
	<CAPig+cS=xBoe-hr5Kwm0N9hBUy4bzN1NoXTcDEwz_4ZwrrXPXA@mail.gmail.com>
	<20150413042644.GA39596@Serenity.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Julian Gindi <juliangindi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 07:00:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhWTq-0005s6-4w
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 07:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbbDMFAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 01:00:14 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:35153 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbbDMFAM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 01:00:12 -0400
Received: by labbd9 with SMTP id bd9so48745931lab.2
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 22:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=POi0p+rvBis568jR0RBv+NrGdHtZ3QRe1LHv2wibjf0=;
        b=fzuQ+yEIbv9EUTi8FprK8R7Z8Vm3+akfEbGSYgO+HOzbE0pFcLRUZ8a4CfhSExfz+J
         scTt/br14KjFLB7CaBXIkQHj/P0XGfdsK92zj6/DNyAhP4T5kVrOVu2Lj3T6rw1NNkb7
         jLYbCQ9XBlMdee5wc0f7YJABKREf7x+ZBrtYk3yBKt9hx+Y6FSyHTZZ2VXvwCIiLLZen
         3deETv6cjv3vXo5Ebi9tty5M4XBST4MOrnQN1OjbewshUq7APtPEeXA2V3PhyftVADbi
         AG5WF5ESaJamCxV0+TO+NRMEQ2jCzPwKx+mMkzz/R/Qr/7wMMB55d7f3GQlLX/X32+e7
         EZqw==
X-Received: by 10.112.57.197 with SMTP id k5mr11910549lbq.102.1428901211413;
 Sun, 12 Apr 2015 22:00:11 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Sun, 12 Apr 2015 22:00:11 -0700 (PDT)
In-Reply-To: <20150413042644.GA39596@Serenity.local>
X-Google-Sender-Auth: eTkmm9NeiBKbOh3gBfrg88MBGKM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267063>

On Mon, Apr 13, 2015 at 12:26 AM, Julian Gindi <juliangindi@gmail.com> wrote:
> CodingGuidelines: updating 'rough' rule count

Imperative mood is preferred, so "update" rather than "updating":

    CodingGuidelines: update 'rough' rule count

>     Changed inaccurate count of "rough rules" from three to the more
>     generic 'a few'.

Imperative: s/Changed/Change/

> ---

Missing sign-off.

> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 0f8cccf..2dd35bd 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -1,5 +1,5 @@
>  Like other projects, we also have some guidelines to keep to the
> -code.  For Git in general, three rough rules are:
> +code.  For Git in general, a few rough rules are:

Looks better, thanks.

>   - Most importantly, we never say "It's in POSIX; we'll happily
>     ignore your needs should your system not conform to it."
> --
> 2.3.5
