From: Andrey Utkin <andrey.utkin@corp.bluecherry.net>
Subject: Re: "git send-email" thru Gmail incurs few minutes delay
Date: Mon, 8 Feb 2016 02:22:50 +0200
Message-ID: <CAM_ZknWNZFxhz8ELf+sc1X3gO=H3F+GYuNkornhU9qouffj6Hw@mail.gmail.com>
References: <CAM_ZknWuOSbQcGvXaCDUKAJX7hR5FxJO3a8axPYS4ekyRiczCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrey Utkin <andrey.od.utkin@gmail.com>,
	Jeff Merkey <linux.mdb@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 08 01:23:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSZc4-0007sT-Qh
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 01:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbcBHAWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 19:22:52 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:34757 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627AbcBHAWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 19:22:51 -0500
Received: by mail-io0-f171.google.com with SMTP id 9so180946575iom.1
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 16:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corp-bluecherry-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XhqYAnSXMl3RbrlppEyMWudD9ytttQOoPl6xkzA4+Vg=;
        b=gnQCoT+CdzDQXVajDnhmMOwFAcvIeU4QIeGUDTVw9tNTM0WkI6DINZ39mLCn9dENlX
         xRTmqFaP8JLk+3n0jrnIWF0MBO6nd9bGHS04glUw8Frp5c8fSAH7Sgvo20toPPjItRHp
         +AK2GG+YDJyVnOGuHMgigUhCLO6ebKn+Ny9WVCJGkzpk6VqMQVxymFZBqh01BWA06vF+
         5Lj5vwAv22CBqg8ACxpDJoEU+DpXpIxGZelrN569iE9uv8MAd4a8ozQShf1cBfObzhLJ
         ygeWUHcOJn4UDQvarjiDX4NqZPmhVcpms1sJVpOEp6yNToXVFIa/+F+zFAuTA9uFpJJx
         Hi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=XhqYAnSXMl3RbrlppEyMWudD9ytttQOoPl6xkzA4+Vg=;
        b=bnQ5OaUHynQaLR4T5JZ2Fpj4iVhKR8VRDuu/mteDAok9kGSymce5vnB24D8pW0BvXB
         8wiyQLY1N5wsrLvWCRCiPVzvksrquNJBDG1cuIGq8QbxoHduXct6Ohq/hTH/ckXgRTiT
         T+FtuEgQsv/Ko6C43iqWBQMG2aKNGxQJPLjEvuJl18WZ7fc49k0No+x0kIJdvjbdfPgv
         3m92yaxtcMU8MpD04fy8UvrS/nrPbZc2wEErd+/IEllBL/JRNzPchASShVMx2vBaDSmS
         MqUXOdBK1QDviK+mpgpL1S0inuzDMHSno/BsBV6xzPHO9Edd8Pq2On64gnpdcQW7yEWw
         gIGw==
X-Gm-Message-State: AG10YOQAqv3R9iVIroJR68GUlwtjS34PK76EtcoIhaBbvO+OwXqzs8CuNHsiddHAlqgIE628siaDf2AUg+EqP/ZO
X-Received: by 10.107.9.106 with SMTP id j103mr25488448ioi.104.1454890970924;
 Sun, 07 Feb 2016 16:22:50 -0800 (PST)
Received: by 10.107.6.206 with HTTP; Sun, 7 Feb 2016 16:22:50 -0800 (PST)
In-Reply-To: <CAM_ZknWuOSbQcGvXaCDUKAJX7hR5FxJO3a8axPYS4ekyRiczCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285740>

On Sun, Jan 3, 2016 at 3:52 PM, Andrey Utkin
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

Tested more with fresh git version 2.7.1.380.g0fea050 (from git's git)
 # equery list '*' | grep -i smtp
dev-perl/Net-SMTP-SSL-1.30.0
mail-mta/ssmtp-2.64-r3

It seems the delay is caused by git-send-email trying to resolve
workstation's FQDN.
When I add "smtpdomain = localhost.localdomain" to [sendmail] section
in gitconfig, it proceeds immediately.
The same behavior (including workaround case) happens with
openmailbox.org and fastmail.com for me.
BTW "smtpEncryption = tls" in gitconfig seems to mean STARTTLS, so
using fastmail's TLS port 465 doesn't work at all, you need to use
587.
