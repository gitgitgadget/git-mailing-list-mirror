From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to create tags outside of refs/tags?
Date: Tue, 22 Feb 2011 02:09:14 -0800 (PST)
Message-ID: <m3wrks756a.fsf@localhost.localdomain>
References: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com>
	<AANLkTi=7yUh9J9S5LdpNY0SwCv008ih2LEd3KNvy46sL@mail.gmail.com>
	<20110222080305.GA11177@sigill.intra.peff.net>
	<7vvd0cebi6.fsf@alter.siamese.dyndns.org>
	<20110222081458.GA11825@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 22 11:09:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrpBN-0004NS-GS
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 11:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab1BVKJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 05:09:19 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39517 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab1BVKJS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 05:09:18 -0500
Received: by bwz10 with SMTP id 10so3038719bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 02:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=tQn2mLaG9OPrKADqkPI5GmroeG3fVqj3y3t9NiNzTZo=;
        b=pxesTPe3lTek+chSLhjas0pRisTtsC2wVEq22y6GCdtTVc74mTGM2HBXUfic66tRMK
         5xidY3VSP6jvNsA8L3s47tTDYcsRYFvhgSNT6oyiGi9wO6sHifd0xdQdQKG0xBuXtc0u
         v88C0tQLXW+hjsxTZpdTYjCWxQEynZYkRSbzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=J75+dRIhrw8KEnU3xYZRiSX898f0AFlW3rSQ0OIhZkbDrlgGJ9zdG8MNc1kwhRq97t
         9LQVFpU9yZlZpgILL/QXeu9Wf3oF/edXcKehfgBFNsAQ3qPD/td19B4G/EwoxSQCn4VJ
         OB8v5duSfNOoxIwaUiTW2pp63WcGoqc7JuxME=
Received: by 10.204.102.146 with SMTP id g18mr2318967bko.163.1298369356597;
        Tue, 22 Feb 2011 02:09:16 -0800 (PST)
Received: from localhost.localdomain (abwn36.neoplus.adsl.tpnet.pl [83.8.237.36])
        by mx.google.com with ESMTPS id v25sm4376695bkt.18.2011.02.22.02.09.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 02:09:14 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p1MA8Z46032192;
	Tue, 22 Feb 2011 11:08:46 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p1MA8DFv032187;
	Tue, 22 Feb 2011 11:08:13 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110222081458.GA11825@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167538>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 22, 2011 at 12:09:37AM -0800, Junio C Hamano wrote:
> 
> > >   # tell git to ignore boring stuff
> > >   git config tag.ignore 'boring/*'
> > >   git config --add tag.ignore 'more-boring/*'
> > 
> > Hmph, isn't that what "grep -v" was invented for?
> 
> Heh. Yeah, but I think the point is that you will want to do this _every
> time_, so it saves typing. I guess you could make an alias. Or even more
> hack-ish, a custom tag.pager that filters the results. ;)

[...]
> > Also it is unclear if the boring tags will or will not be propagated (or
> > should or should not be, for that matter) to outer world when you do "git
> > push --tags" with your "ignore".  Most likely some people do want to see
> > them hidden (e.g. when publishing), and some others do want to be pushed
> > (e.g. when backing the repository up).
> 
> I think changing the config name to tag.list-ignore would make it more
> obvious what is going on. If you don't want to push certain tags, I
> think refspecs are the way to do that, and this should be a purely local
> display thing.

You meant `tag.listIgnore`, weren't you?  No hyphens in config
variable names.

About refspecs: we currently do not support negative refspecs, do we?
(IIRC there was proposal to use '!' or '-' as prefix for them).  So we
can't currently exclude refs/tags/private/* while including
refs/tags/v*?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
