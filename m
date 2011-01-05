From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git fails on large repo clone on intermittent, or intermittently-high-latency, connections
Date: Wed, 05 Jan 2011 07:26:31 -0800 (PST)
Message-ID: <m3tyhnbcf7.fsf@localhost.localdomain>
References: <AANLkTinkhmHpAQjraviKjqFAczThR5GtT_qdyf6Sb3nm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zenaan Harkness <zen@freedbms.net>
X-From: git-owner@vger.kernel.org Wed Jan 05 16:26:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaVG5-0003XC-Di
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 16:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab1AEP0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 10:26:36 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33461 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab1AEP0f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 10:26:35 -0500
Received: by wyb28 with SMTP id 28so15446583wyb.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 07:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=A/K943/FW6baMsR/ksw6MGiggQ5+JGdRNkqOtFFQQlg=;
        b=JBxatVlSA1DgoO+pzUYPQP2r9KyCXsbwzCpb1J6JJC95ckgForCtvZOHwXasotBWYQ
         yICFxIXzJufC3Zozvg/BF6Msvvewu3eupAVbwQqP3v4HIqlj60Ubhpg93cg9+87basMq
         EQinijwPWqBc2p1lRIB/e8CSM34jbB1Ln3700=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Kgh1lGELUV/rrCMHOi8RoOIFG3NtSyWlrv8nefGVnv6IME1m4l0ZZws7yKagIDO/bB
         Mer81RlRHLSXh/3/ojFsWToPHVfQ5bYpDNXdlsG/QHkLWMcDQDr9GU/BKg/p+DpsYkkB
         dDwGIX0rIRwBX2R2qWN6lesr0o2UFfgm2w5YM=
Received: by 10.216.56.79 with SMTP id l57mr20313534wec.86.1294241192727;
        Wed, 05 Jan 2011 07:26:32 -0800 (PST)
Received: from localhost.localdomain (abwq27.neoplus.adsl.tpnet.pl [83.8.240.27])
        by mx.google.com with ESMTPS id r6sm11234338weq.20.2011.01.05.07.26.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Jan 2011 07:26:31 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p05FPTjW021163;
	Wed, 5 Jan 2011 16:25:42 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p05FPH8c021159;
	Wed, 5 Jan 2011 16:25:17 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTinkhmHpAQjraviKjqFAczThR5GtT_qdyf6Sb3nm@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164567>

Zenaan Harkness <zen@freedbms.net> writes:

> Hi, I am trying to clone opentaps.git. The following is my third try,
> and I am giving up now. As you can see I pressed <Return> every now
> and then, and for the last long while, absolutely nothing downloading
> - the connection has clearly died once again. My last run was
> yesterday and I left it run overnight.
> 
> I cannot download (with a git clone/ initial repo), more than roughly
> 100MiB. I am on a satellite connection. I have also experienced this
> with wireless connection about 18 months ago.
> 
> I have in the middle there (a few months ago) spent a couple months at
> a friend's place, and never had the same problem - nice ADSL2+
> connection, ~1.5MiB/s connections. As you can see with my satellite
> (rural) and also with my older wireless (also rural) connections, I do
> not get more than about 64KiB/s, but it's usually slower, and I've
> always had satellite latency issues in the order of 450ms, and
> sometimes the odd dropout.
> 
> As opposed to git, wget on the other hand not only retries and
> continues from where it left off when it retries (HTTP protocol)
> (default retry 10 times I think), but I can completely INTerrupt wget,
> and start it again from an entirely different computer if I want
> (using wget's --continue option), and it will (with HTTP) happily
> continue right where it left off, and eventually my download
> completes.

[...]
> What can I do to work around my flaky link?

Ask project in question to provide bundle of repository for seeding
initial clone (see git-bundle manpage); this is an ordinary file, and
can be downloaded via HTTP or even P2P.

> 
> How hard would it be to add a wget-like mode to git, for the initial
> repo download?

Very hard; tthough "resumable clone" was often requested (25%
responders in "Git User's Survey 2010", see [1]), and there was even
some discussion about possible implementation, it was not implemented
yet, even as proof of concept.

The trouble is that packfile is *generated for a client*, and
bit-for-bit representation of said pack can vary (e.g. if
multithreaded packing is enabled; usually a good idea).

[1]: https://git.wiki.kernel.org/index.php/GitSurvey2010#17._Which_of_the_following_features_would_you_like_to_see_implemented_in_git.3F

-- 
Jakub Narebski
Poland
ShadeHawk on #git
