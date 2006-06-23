From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Make -p --stat and --stat -p behave like
 --patch-with-stat
Date: Fri, 23 Jun 2006 15:00:49 +0300
Message-ID: <20060623150049.9d147262.tihirvon@gmail.com>
References: <20060622162511.4788505e.tihirvon@gmail.com>
	<7vr71hkofg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 14:01:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtkLJ-0002Se-42
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 14:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933081AbWFWMAx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 08:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933083AbWFWMAx
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 08:00:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:64741 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933081AbWFWMAx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 08:00:53 -0400
Received: by nf-out-0910.google.com with SMTP id o60so402681nfa
        for <git@vger.kernel.org>; Fri, 23 Jun 2006 05:00:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=T3pgc7wt4aoSYYNKuRHWcHI5Ua0FTnQJbER/tgZeAhqNVNpvsFwt/hfBUV+P53l40RUeKDmyDfTAJkpEQNtB4cXfmjkmIsInXYrbblq8+pL/4lP8khccsEJi4Ol3SKKxcRCwpKRWBj+2EkgIeONQEs+/991kB9RIT2k6/4e7jh0=
Received: by 10.49.60.17 with SMTP id n17mr2346826nfk;
        Fri, 23 Jun 2006 05:00:51 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id a23sm2904266nfc.2006.06.23.05.00.50;
        Fri, 23 Jun 2006 05:00:51 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr71hkofg.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22409>

Junio C Hamano <junkio@cox.net> wrote:

> The diff output has four parts, each of which can independently
> be enabled.  When no options are specified on the command line,
> each command has its own default but in general the low-level
> commands default to raw output only, and the higher-level ones
> default to patch output only.
> 
> The four parts are controlled with a bit each, and are output in
> the fixed order (iow the order of the options given from the
> command line does not matter): raw, stat, summary and patch.
> 
> When --name-only or --name-status is specified, that would be
> the only thing that is output (iow the above four parts would
> not be shown, just names optionally with the status are shown).
> 
> The four switches are: --raw, --stat, --summary and --patch.
> Existing flags are supported as obvious shorthands to turn on
> the corresponding bits:
> 
> 	-p, -u			--patch
>         --patch-with-raw	--raw --patch
>         --patch-with-stat	--stat --patch
> 
> Anybody interested in doing a patch?

I'll try. It shouldn't be too hard.

-- 
http://onion.dynserv.net/~timo/
