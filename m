From: Jeff Merkey <linux.mdb@gmail.com>
Subject: Re: "git send-email" thru Gmail incurs few minutes delay
Date: Sun, 3 Jan 2016 08:59:14 -0700
Message-ID: <CAO6TR8UzKR=cXu-bgf4HfBwNKrmMx-Ucha-nHUA3ranw2AoxgA@mail.gmail.com>
References: <CAM_ZknWuOSbQcGvXaCDUKAJX7hR5FxJO3a8axPYS4ekyRiczCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org, Andrey Utkin <andrey.od.utkin@gmail.com>
To: Andrey Utkin <andrey.utkin@corp.bluecherry.net>
X-From: linux-kernel-owner@vger.kernel.org Sun Jan 03 17:00:10 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aFl4i-0002XS-Lc
	for glk-linux-kernel-3@plane.gmane.org; Sun, 03 Jan 2016 17:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbcACP7R (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 3 Jan 2016 10:59:17 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38552 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbcACP7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jan 2016 10:59:14 -0500
Received: by mail-ig0-f169.google.com with SMTP id mw1so92714679igb.1;
        Sun, 03 Jan 2016 07:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+vtnWzEqCySwZBZTofTjiH5p0RHCNnin0s+KM7BdY3c=;
        b=w4hAJLD549XWbCoeqqj0IPmo7FQnjsfJtP02GirYaFB9UK6m5vpeXgBwZ1SxnMyPIC
         RY1rbFHS5OFW+ijhgcOONFgQZkHf3l2ccpspAU5NwgcQYCqaVrhUmFQcDrTGlvmrHouf
         HfV47f9R4TU67KyQ/FvL0VySePoTxW65v/03wen4+HAAPBVNdl3jnDycyZEXKJvqfWf2
         Y3Osv/VjDwXus2QcwbJvVfH5qx+r2QWBRC3mRv0DzN84qnfzl2KdUEpHi+Pp7zI7auBV
         qGjtTMZqU3EN0LRJsqCXql4dhV2WG+CWlKU3gOR144k6O1mA82b81k/MfDwQF/giPiSY
         ItTw==
X-Received: by 10.50.64.146 with SMTP id o18mr73328106igs.51.1451836754191;
 Sun, 03 Jan 2016 07:59:14 -0800 (PST)
Received: by 10.79.75.69 with HTTP; Sun, 3 Jan 2016 07:59:14 -0800 (PST)
In-Reply-To: <CAM_ZknWuOSbQcGvXaCDUKAJX7hR5FxJO3a8axPYS4ekyRiczCQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283275>

On 1/3/16, Andrey Utkin <andrey.utkin@corp.bluecherry.net> wrote:
> After "Send this email? ([y]es|[n]o|[q]uit|[a]ll): y" prompt and
> before "Password for 'smtp://XXX@gmail.com@smtp.gmail.com:587':"
> prompt I always have a delay of 2-3 minutes. It is weird! "Unsafe
> clients" are allowed in Gmail settings.
> I experience this both with @gmail.com mailbox and with gmail-based
> company domain mail.
> I noticed this happening the first time several months ago.
> Has anybody else experienced this? Any solution?
> My git version is 2.6.4.
>
> --


Yes. I see it.  It's the gmail smtp gateway but 3 minutes is short, I
am seeing longer.  It's gmail not git.

Jeff


> Bluecherry developer.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
