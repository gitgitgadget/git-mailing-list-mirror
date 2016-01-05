From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: "git send-email" thru Gmail incurs few minutes delay
Date: Tue, 5 Jan 2016 12:27:05 +0100
Message-ID: <CAMuHMdUZf2CLyzWVr+KUcgALejWpgEhUt1DMDBg614bKbFEXZw@mail.gmail.com>
References: <CAM_ZknWuOSbQcGvXaCDUKAJX7hR5FxJO3a8axPYS4ekyRiczCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Andrey Utkin <andrey.od.utkin@gmail.com>
To: Andrey Utkin <andrey.utkin@corp.bluecherry.net>
X-From: linux-kernel-owner@vger.kernel.org Tue Jan 05 12:27:21 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aGPln-0006jF-RK
	for glk-linux-kernel-3@plane.gmane.org; Tue, 05 Jan 2016 12:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbcAEL1I (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 5 Jan 2016 06:27:08 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36545 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbcAEL1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jan 2016 06:27:07 -0500
Received: by mail-ig0-f176.google.com with SMTP id ph11so12309015igc.1;
        Tue, 05 Jan 2016 03:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=H48qvDro46w+7U97SP2uybs3FUr92p9HAsaFUW6Un5Q=;
        b=J1q5Pqz34Anz5KMa98kt2QgK4//LiD7YxVkXRNqDVwYHlmHKAyUaYvoilLpuAbezI+
         UsI5bXLAYvfhLQeOWpEFW6PtqTowqfplkXaId5BpsVdFUTlUkE3/nNuzz/YhidglEqn1
         CDHS0XkqhNN+PpQyrtyMHZF9OBZpy7uQcRS+MQiMvu2ILDspwxiL88/MFwYYwwe3T2Il
         9fytgnTGbEcLkmF91jjvLAXZiXrSaXNJ3haVc1E2Cqrg5cAd8LJ0Idllq2jdMfSeVij+
         FMdlOR6xUEDVeSij/U401baRliwKuR30SmASHGkL1ggXW7zYa5KGyGnC/72QJvckLFtF
         anrg==
X-Received: by 10.50.50.201 with SMTP id e9mr3511854igo.10.1451993225445; Tue,
 05 Jan 2016 03:27:05 -0800 (PST)
Received: by 10.107.9.97 with HTTP; Tue, 5 Jan 2016 03:27:05 -0800 (PST)
In-Reply-To: <CAM_ZknWuOSbQcGvXaCDUKAJX7hR5FxJO3a8axPYS4ekyRiczCQ@mail.gmail.com>
X-Google-Sender-Auth: eJKaPTQe0P8Iw0pNxqe37MP936U
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283372>

On Sun, Jan 3, 2016 at 2:52 PM, Andrey Utkin
<andrey.utkin@corp.bluecherry.net> wrote:
> After "Send this email? ([y]es|[n]o|[q]uit|[a]ll): y" prompt and
> before "Password for 'smtp://XXX@gmail.com@smtp.gmail.com:587':"
> prompt I always have a delay of 2-3 minutes. It is weird! "Unsafe
> clients" are allowed in Gmail settings.
> I experience this both with @gmail.com mailbox and with gmail-based
> company domain mail.
> I noticed this happening the first time several months ago.
> Has anybody else experienced this? Any solution?
> My git version is 2.6.4.

Does it work better if you store the (preferably app-specific) password in
smtppass in .gitconfig?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
