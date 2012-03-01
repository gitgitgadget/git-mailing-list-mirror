From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Running git on ARM systems
Date: Thu, 1 Mar 2012 16:47:42 +1100
Message-ID: <CAH5451=bQ=_Bn2tLRM5mBRSHA3BqMU7S=V1DxNaUeKxZ1G1XsA@mail.gmail.com>
References: <CAH5451=ngnGxpSd4+8xg1PwTSPOJ0napS+Y9KNVE_82a+n+GQQ@mail.gmail.com>
 <CAKbGBLj5EcQ=DLqhTO9FPKJGyP-tw=HyGYEgAv_7vz_0erSDMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Steven Noonan <steven@uplinklabs.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 06:48:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2ysU-0000ZD-DB
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 06:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471Ab2CAFsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 00:48:06 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:56747 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226Ab2CAFsE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 00:48:04 -0500
Received: by wejx9 with SMTP id x9so110035wej.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 21:48:02 -0800 (PST)
Received-SPF: pass (google.com: domain of andrew.ardill@gmail.com designates 10.216.135.102 as permitted sender) client-ip=10.216.135.102;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of andrew.ardill@gmail.com designates 10.216.135.102 as permitted sender) smtp.mail=andrew.ardill@gmail.com; dkim=pass header.i=andrew.ardill@gmail.com
Received: from mr.google.com ([10.216.135.102])
        by 10.216.135.102 with SMTP id t80mr1697431wei.59.1330580882959 (num_hops = 1);
        Wed, 29 Feb 2012 21:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IOHNG3O6y9gEjIL6PmkjJrjByfTrvQ8dGMQNqyWWzdg=;
        b=jcgGBTYOrrREhsP5J1/ln4teqeezUj4GNKlVa+1wSDCB+MwR8yf2MdZtSaEr5kNIFJ
         2b2YnuB/nYhtWCtWm+4zFAJqX7axVOY+JscdO+t2eMVSHKbwJk5PF+m+KuCDBKXPhBza
         ec8eYHm+36YjepMUNCW6zhhsO0i+OTgVeYth8=
Received: by 10.216.135.102 with SMTP id t80mr1363402wei.59.1330580882861;
 Wed, 29 Feb 2012 21:48:02 -0800 (PST)
Received: by 10.223.96.133 with HTTP; Wed, 29 Feb 2012 21:47:42 -0800 (PST)
In-Reply-To: <CAKbGBLj5EcQ=DLqhTO9FPKJGyP-tw=HyGYEgAv_7vz_0erSDMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191899>

On 1 March 2012 16:31, Steven Noonan <steven@uplinklabs.net> wrote:
> I've been using git on three different ARM boxes (TrimSlice,
> PandaBoard, i.MX53 Quick Start Board). It works okay, if a bit slow.
> Even on a small repository (< 1MB), git is a bit laggy, but that's
> true of most everything on those devices. It would be nice if they had
> decent SATA controllers so I could attach some small SSDs or something
> instead of relying on MicroSD or SD. I think you'll find the biggest
> problem you will run into is memory usage when repacking or garbage
> collecting, but you probably wouldn't really want to anyway (and if
> you do, move the whole .git dir to something that can handle a proper
> repack).
>
> I've never used the ARM11 processor though. My experience has been
> with the ARM7 and ARM9, where I was -extremely- memory constrained
> (4MB of RAM if I recall) and couldn't really build anything on the
> device itself, as well as the Cortex-A8 and Cortex-A9 -- which was a
> huge leap compared to the ARM7/ARM9, particularly since the newer
> devices have a couple orders of magnitude more memory.
>
> Would be curious to see how one of the Raspberry Pi devices does
> running my incomplete and silly microbenchmarking tool
> (https://github.com/tycho/cpu-test-arm)... Perhaps I'll order one when
> they're back in stock. :)
>
> Is there anything specific you wanted to know about git on such devices?

It's good to hear that git has worked on these devices. Did you
compile it for them especially, and if so what did you have to do?

The RPi will have 256M ram, which is significantly better than what
you have been working with. I think my first real goal will be to
compile git on it. Hopefully it will be flawless!

In terms of running git on these devices, are there any limitations to
the functionality, barring memory constraints?

The device will also have USB ports, and I imagine the two most common
use cases will have the working directory on SD card and on USB hard
drive. I wonder how git will perform comparatively on each.

Regards,

Andrew Ardill
