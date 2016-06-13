From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] Document the 'svn propset' command.
Date: Mon, 13 Jun 2016 19:54:32 +0530
Message-ID: <CAFZEwPNGz18uyLT62PsR-ybF32KJPb5PssQXJXuA4eWUFtPXnw@mail.gmail.com>
References: <20160612191550.GA14160@elvis.mu.org> <CAFZEwPM5qnzw7RCUwOkJFo+U982kVGU8_3GUTXvHAypKtvEgTQ@mail.gmail.com>
 <81a197e2-7e0e-176a-c934-0e5f95cfda83@freebsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Joseph Pecoraro <pecoraro@apple.com>,
	David Fraser <davidf@sjsoft.com>
To: Alfred Perlstein <alfred@freebsd.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 16:25:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCSnR-0005C7-LV
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 16:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424006AbcFMOYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 10:24:50 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:32896 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424075AbcFMOYd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 10:24:33 -0400
Received: by mail-yw0-f176.google.com with SMTP id g20so127215742ywb.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IhR2//uJLca7ZYNYxsj82TuZYMrHal/UP/9EfYyk8NU=;
        b=u3PM63Zvm3IhoHJOyV/jRT6Q+85W/qJ0I4B1rGkbowrzyXpiBPXNMaxVog3EVlB6Jb
         oVbiDV43qdpiMWkzKe1vq3N+6yml7qJRchwXDKuveEJUbVUJ2M9fpkySxyOOKzaQN75t
         Y5cZTsBxzS/cPkWf4PH0aHlHF+fJjBDJAzVvfG1JP6cIzsdfk5TleKk+dwvncZ65QcZv
         CEcO0AbL3WGZejRqhiZg5D7Yiof93oH9GNqERyLzljRNeIw9zaatWWJOhqfboSXB5o8U
         S02Riqjm39UCTxSwj1edCnCtHhgp/8IS0/0Oodd12t4148Iu7/ifM7ZV5trT0sIs4iPm
         T+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IhR2//uJLca7ZYNYxsj82TuZYMrHal/UP/9EfYyk8NU=;
        b=lmuOODyrthwgPzcSxcwdmaTUju7Cu5K/DJw1xeJUJ1xYBNXIjBHhESIDJ0su4kBM2p
         V+jaxapUpQsr2xBpbnp339x4CZQpn7IeXlklR4fOy/qZDNnre3lkOEH0Enrmi4UbQ3PF
         aIhaWAHJaBfZuxQpoH26kWEM6R77WxNxoE8FKqmEj6AnV9asLQUexErlW47s/LcNVM1z
         nOEq5wBo55Es9/cRoxWiw3bcclHTnC3avWIp8Du3aMO8MEFPzGHqtrvVDCK1V7e4Rerm
         yOeREZLeBGlyshP/XxB6ReiOVZdc9c+wi/xMrl91lP7209hhbGCdpHbYfemUUt0D7rx8
         FTSA==
X-Gm-Message-State: ALyK8tKXxNedODtoag/FSfb7qW9f+YEg3AjSNF9efZSNGP++tR3Fs4UZTlcxTf/kK9hTl4u34V+j9h/45Coyjw==
X-Received: by 10.129.164.145 with SMTP id b139mr9213573ywh.171.1465827872751;
 Mon, 13 Jun 2016 07:24:32 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Mon, 13 Jun 2016 07:24:32 -0700 (PDT)
In-Reply-To: <81a197e2-7e0e-176a-c934-0e5f95cfda83@freebsd.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297191>

Hey Alfred,

On Mon, Jun 13, 2016 at 6:22 PM, Alfred Perlstein <alfred@freebsd.org> wrote:
> Thank you Pranit.  I thought that "signed off by" is used once someone
> approved my patch as opposed to when it's in "proposal" stage.  This was my
> first email with a patch for this issue, who should/could I have used for
> "signoff"?

Signoff is used to indicate that you are OKAY with releasing your
patch according to git's license. For more details see the
Documentation/SubmittingPatches[1]. To summarize you will have to add
this in the end :

   Signed-off-by: Alfred Perlstein <alfred@freebsd.org>

Though I will still recommend you to go through [1] properly.

Regards,
Pranit Bauva
