From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Removing unreachable objects in the presence of broken links?
Date: Mon, 29 Oct 2012 20:56:17 +0100
Message-ID: <CAMuHMdU5ZNFs-_TeUE4ntzCCOp85DSOyWMrjJ=yV76MSmjfxDQ@mail.gmail.com>
References: <CAMuHMdUqUtDspOP2kE9wtGEr9aJHGGBG=HRomdY6NRa8gxar4A@mail.gmail.com>
	<m2r4oiffgy.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 20:56:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSvRn-0006gM-KD
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 20:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028Ab2J2T4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 15:56:19 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62123 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877Ab2J2T4S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 15:56:18 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so5680908vcb.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 12:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=fMqnSqUrN2GUJvlXa3PZamJqHEumPaLOXVTSOQ1U7wM=;
        b=jO7w0MHsm5y0f3FmnYWhOn6ynouuP4MQDTvqFKwirggEOklBVO/OzcZD8q7HbSEkIq
         PEHDz2OYTKMi1lvFV3lAa4WDPuCTt+q2FZ4D1mPy0n303AGuSlmxIrwDxoPeo8CYc9S9
         M813W/LJGKqUMxdSx5diifWvMMcTsFyUCSOnY3ofiEZ0+Xgh6jZ1RploPb+ToCUB+IEH
         NZN3rWSptyw8SwxRWrTg2ZdzrHkEX1QaVDqYDMNtYFo9JSxm8+DIigncaakbYwQGfPuC
         gvyCudhs+xRlzMPSdBxFdLJP5BJ96x1fu4NUk/gCJAgjLoY6UbC8pqN05nsFuhykECn8
         RiTw==
Received: by 10.52.66.80 with SMTP id d16mr40394390vdt.64.1351540577670; Mon,
 29 Oct 2012 12:56:17 -0700 (PDT)
Received: by 10.58.163.166 with HTTP; Mon, 29 Oct 2012 12:56:17 -0700 (PDT)
In-Reply-To: <m2r4oiffgy.fsf@igel.home>
X-Google-Sender-Auth: 9V3YH8RY70Q0NHj9jHcY_HUwQeI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208635>

Hi Andreas,

On Sun, Oct 28, 2012 at 10:34 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
>> Is there a way to force removing unreachable objects in the presence of broken
>> links?
>
> Does it help to forcibly expire the reflogs?

You mean "git reflog expire --all --expire=0"?

After that the reflog is empty, but "git gc" still fails.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
