From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] CodingGuidelines: updating 'rough' rule count
Date: Sun, 12 Apr 2015 20:04:04 -0400
Message-ID: <CAPig+cS=xBoe-hr5Kwm0N9hBUy4bzN1NoXTcDEwz_4ZwrrXPXA@mail.gmail.com>
References: <20150412234720.GA37658@Serenity.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Julian Gindi <juliangindi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 02:04:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhRrR-0003Lj-Rr
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 02:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbbDMAEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 20:04:08 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:33688 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbbDMAEH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 20:04:07 -0400
Received: by layy10 with SMTP id y10so45902851lay.0
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 17:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=shSIhxhZPKEoHHW0kb7mIn3T7xeIQFO/MeC8Y/zRoEg=;
        b=LZ+1lzzYOlA8r5d7knyG5z1G4fuUgOy/mFLEEYupDOgV6JQQWT45QOhlgjSfcRYJs9
         zpQX7rlmJIIP3rXGmfImoXE55n+J/SY9i1C2xHe6Pue6zkQXU8Mec1dEQHRjcbhqMOeS
         kRM3/R1o3RDJ2KWQ+jM1s6AcvsfwNpYbe1cK1nknodxfkDpfK2f0YarTZF3hZQ7PzRGR
         qamW8a3l1BddvOLq+pYXw+AJIok4A/dlIpAtX1J7Cdx8GDrYbPj95ukgYjwCVGPNyCTJ
         ydJiWnPNehm2swVBSQ4Ir5OsS5+vZL7lKAB2EpfwblqmsYjoMAYKrDnWPH1Cb1sRpN+8
         Ebqw==
X-Received: by 10.112.57.197 with SMTP id k5mr11160479lbq.102.1428883445030;
 Sun, 12 Apr 2015 17:04:05 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Sun, 12 Apr 2015 17:04:04 -0700 (PDT)
In-Reply-To: <20150412234720.GA37658@Serenity.local>
X-Google-Sender-Auth: Qi_KUQBEach97q7scr8fL9HJCRM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267059>

On Sun, Apr 12, 2015 at 7:47 PM, Julian Gindi <juliangindi@gmail.com> wrote:
> Changed inaccurate count of "rough rules" from three to four.
>
> Signed-off-by: Julian Gindi <juliangindi@gmail.com>
> ---
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 0f8cccf..c422ecd 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -1,5 +1,5 @@
>  Like other projects, we also have some guidelines to keep to the
> -code.  For Git in general, three rough rules are:
> +code.  For Git in general, four rough rules are:

Although this change is technically accurate, this sentence is still a
potential maintenance burden. How about taking a more generic
approach, and saying something like:

    For Git, in general, the rough rules are:

?

>   - Most importantly, we never say "It's in POSIX; we'll happily
>     ignore your needs should your system not conform to it."
> --
> 2.3.5
