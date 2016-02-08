From: Jeff Merkey <linux.mdb@gmail.com>
Subject: Re: "git send-email" thru Gmail incurs few minutes delay
Date: Sun, 7 Feb 2016 17:42:45 -0700
Message-ID: <CAO6TR8UGwqtsXSoYkxgjMy34rrkHAFJ+ALf0ufSaA8uDrDmxqQ@mail.gmail.com>
References: <CAM_ZknWuOSbQcGvXaCDUKAJX7hR5FxJO3a8axPYS4ekyRiczCQ@mail.gmail.com>
	<CAM_ZknWNZFxhz8ELf+sc1X3gO=H3F+GYuNkornhU9qouffj6Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Andrey Utkin <andrey.od.utkin@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrey Utkin <andrey.utkin@corp.bluecherry.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 01:43:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSZvB-00011O-P4
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 01:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874AbcBHAmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 19:42:47 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33490 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844AbcBHAmq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 19:42:46 -0500
Received: by mail-vk0-f42.google.com with SMTP id k196so19628836vka.0
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 16:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UgrLf4/hMBUzYJHi6gpjYLaEcgvzLQt9S3r2DtjL1EQ=;
        b=jPgiaF8azgYW3rKkjdbjAnuhrekcFwBl1ggtxhwDxdqwiWUaTnuppjw/+vd8bBeqz9
         K3x/kh6xyP3Q64kLne9FWIYxvTzJqIe4WSge6gESsg954VsoKRHAt3KFq/YQM1W7uWc1
         CBnuJf2RbuikM7wXKYu2UDdMeZ239Dr6m58emOiHzkv8Y7e8xLbq5/nSVxrMEJgxwAhB
         tZZI2n5m/98UGaYyY2mQoru7zAQLwbsfH2gfhRiaMrcztj2oms6NTqHCFKgqfxGKNlP5
         fTcdpzX4uA2CYQ2GudCGrAE5sd5Jlf15w/f/KVPl+yeLuWYHwcsWYp6FlWq1DYnVryTr
         79Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UgrLf4/hMBUzYJHi6gpjYLaEcgvzLQt9S3r2DtjL1EQ=;
        b=RyUN6GUPiJIMqdfXlYO3CkjEIQxVJWOaQWJdaNwIwJynDIIEJKWJSgHMzMs8OxaXpq
         TKMyhsPZOxz7I4gHjysSpLVptV4nkVTqU4XyBnbOqKaf6NzpAGaeX0CXxxw+Xk/EKAvV
         dIpAdt+F4BxOgRnwD+Vu2kRYAxjgW1SB64Tlk+bMKLRWIwJPZAr9QLwXRXS7WoGau7T2
         VdLoe3Rs9oWwe2HWqGRN//1rJPODcXgFDPBJvRrJ8sdfAlxPPtyvQhJvfdEt1tImuap0
         hd7paxk5QZ+gA6TIbvof175Zt/l0uBVZMYI/pG5RdaLY9Nlqhd2Z4C9J8Dz80g96vA7I
         w7PA==
X-Gm-Message-State: AG10YORldCpO2aKAkvVG4NiwAe/o0DVCbC5ShlH/6MO7Dp3+0Ix/dhnmgkLIKi63L3bdiTvTZKrVt+VjAVT2zQ==
X-Received: by 10.31.156.129 with SMTP id f123mr18039851vke.40.1454892165570;
 Sun, 07 Feb 2016 16:42:45 -0800 (PST)
Received: by 10.176.2.212 with HTTP; Sun, 7 Feb 2016 16:42:45 -0800 (PST)
In-Reply-To: <CAM_ZknWNZFxhz8ELf+sc1X3gO=H3F+GYuNkornhU9qouffj6Hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285741>

On 2/7/16, Andrey Utkin <andrey.utkin@corp.bluecherry.net> wrote:
> On Sun, Jan 3, 2016 at 3:52 PM, Andrey Utkin
> <andrey.utkin@corp.bluecherry.net> wrote:
>> After "Send this email? ([y]es|[n]o|[q]uit|[a]ll): y" prompt and
>> before "Password for 'smtp://XXX@gmail.com@smtp.gmail.com:587':"
>> prompt I always have a delay of 2-3 minutes. It is weird! "Unsafe
>> clients" are allowed in Gmail settings.
>> I experience this both with @gmail.com mailbox and with gmail-based
>> company domain mail.
>> I noticed this happening the first time several months ago.
>> Has anybody else experienced this? Any solution?
>> My git version is 2.6.4.
>
> Tested more with fresh git version 2.7.1.380.g0fea050 (from git's git)
>  # equery list '*' | grep -i smtp
> dev-perl/Net-SMTP-SSL-1.30.0
> mail-mta/ssmtp-2.64-r3
>
> It seems the delay is caused by git-send-email trying to resolve
> workstation's FQDN.
> When I add "smtpdomain = localhost.localdomain" to [sendmail] section
> in gitconfig, it proceeds immediately.
> The same behavior (including workaround case) happens with
> openmailbox.org and fastmail.com for me.
> BTW "smtpEncryption = tls" in gitconfig seems to mean STARTTLS, so
> using fastmail's TLS port 465 doesn't work at all, you need to use
> 587.
>

Try this page.  Some good gmail config info.

http://kernelnewbies.org/FirstKernelPatch

Jeff
