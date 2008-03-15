From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 17:03:10 -0700 (PDT)
Message-ID: <m3zlt0x39k.fsf@localhost.localdomain>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
	<alpine.LFD.1.00.0803141041080.3557@woody.linux-foundation.org>
	<20080314183731.GA2994@atjola.homenet>
	<alpine.LFD.1.00.0803141150070.3557@woody.linux-foundation.org>
	<m34pb9xgrp.fsf@localhost.localdomain>
	<BAYC1-PASMTP1563DCF0556F09CFE67BE8AE0A0@CEZ.ICE>
	<93c3eada0803141643r2f2c4c56l9e59f2ee7b67a8ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Geoff Russell" <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 01:03:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaJsP-0000Ai-QB
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 01:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbYCOADO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 20:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbYCOADO
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 20:03:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:39340 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbYCOADN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 20:03:13 -0400
Received: by ug-out-1314.google.com with SMTP id z38so184727ugc.16
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 17:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=SPLeDkHi/bf4FZC47/fHtWuw9ruA2EjexD+zzpc4znE=;
        b=M3wZ/6H6y91lThRqlwd+LA2Vx4geKEoL0SZ3n31MOYqiWrrROjocRpSAocfnmKSMz30W5Wg6o1PQJw7AQdk6F82Oc2+LTWfBv1CUuYp+Zvo7uHRzbte5ERgqNIccLNIDZM5WYRGa8KKrIIAFTyX1g35Qgr0H2SI9Ajs8h0M3ONI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=mO+q7Is+0+zqaNH0hcADhRIULEz2SkmWuZudW5LtWVPasCJLAJos4ZC1b0YddXBLiMk8p4HEsTrIcqDMLtkTpmEXrwPPNIoRNtSUEhUAfmq2bjuFWVT259nf4945P8lxShMJs59t6dh2lc/CGfAXG6TNG/+9zf3L3iDl1h6QXDI=
Received: by 10.66.221.5 with SMTP id t5mr706554ugg.83.1205539391948;
        Fri, 14 Mar 2008 17:03:11 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.191.199])
        by mx.google.com with ESMTPS id 32sm1049824ugd.37.2008.03.14.17.03.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Mar 2008 17:03:10 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2F03A7D032632;
	Sat, 15 Mar 2008 01:03:10 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2F034rc032625;
	Sat, 15 Mar 2008 01:03:04 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <93c3eada0803141643r2f2c4c56l9e59f2ee7b67a8ca@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77296>

"Geoff Russell" <geoffrey.russell@gmail.com> writes:

> I thought my question was trivial, but judging by the number of
> answers, clearly not!
> 
> I understand "git read-tree -u -m 3 ; git commit" and it does exactly
> what I want.
> 
> The context where I want to use this is for users who update files,
> can understand "take me back to the state I was in at 4pm yesterday
> before I mucked up my data" but who don't want to know about
> merging, branching, topics, etc, etc, But of course having taken
> them back to the 4pm commit, they then realise that they really need
> the 6pm commit or perhaps the 3pm commit. So anything which just
> throws away commits would be risky.

Thanks to the reflog even if they go the "git reset --hard 3" route,
the commits would be protected for gc.reflogExpireUnreachable period,
which defaults to 30 days, by reflog. After this period they could be
garbage-collected.

> The "git read-tree -u -m 3; git commit" allows me to present a
> simple straight line view of the data, which is perfect for the
> people I'm dealing with.

Simple, straight line with _rewinds_, i.e. not so simple history.

Unless you can expect users to find errors later than 30 days, or you
have pushed non-rewritable branch already, then "git reset --hard 3"
is IMHO a beter solution than "git read-file -u -m 3 && git commit -a".

-- 
Jakub Narebski
Poland
ShadeHawk on #git
