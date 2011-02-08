From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [1.8.0] git checkout refs/heads/foo checks out branch foo
Date: Mon, 7 Feb 2011 19:22:21 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1102071918430.3788@debian>
References: <alpine.DEB.1.10.1102062234010.3788@debian> <20110207211127.GG63976@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 08 01:22:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmbLi-0000zr-Gp
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 01:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407Ab1BHAW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 19:22:26 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35973 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125Ab1BHAWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 19:22:25 -0500
Received: by vxb37 with SMTP id 37so1947802vxb.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 16:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=jpxzbNVTf8/+2mk6mQkg3pRCG7Pqw5CAqbGuZjjTIdg=;
        b=H8y4axRHIPt8+bB21W7Qpk9GsWarof2LvWmbN4ivTtgoj+fa90MxMpquE4FV2CIml2
         IIN7YuKJRo4n8SDMo9sJrA12IdbO81cb+/v5pkJdIUI2p6IXS2B0HY1/p9UKtw/2FjPB
         Rsbr5QZlnjwAy75aZQ4NqaqI9usT6/K1/Ai+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=KGI8NFuf3ZgniGi5FdT9GmWAD65tkzQgVl3Ew5wGK3ISKw3oyGBzyKfcUTLnOlcOSh
         ahBEE8MrmQS03z29ZsqJnx6FEtt0dRUO98FGu3VtLOp0fcCL06cVdGlVvB4Z8T+TLvN+
         1H3NhWG0H0Oo2m6Tc/zz536b0laWWvYVgnNmk=
Received: by 10.220.188.135 with SMTP id da7mr4453063vcb.146.1297124544231;
        Mon, 07 Feb 2011 16:22:24 -0800 (PST)
Received: from [192.168.1.104] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id u6sm3690134vby.17.2011.02.07.16.22.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 16:22:23 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <20110207211127.GG63976@book.hvoigt.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166313>

On Mon, 7 Feb 2011, Heiko Voigt wrote:

> Hallo Martin,
> 
> On Mon, Feb 07, 2011 at 06:01:51AM -0500, Martin von Zweigbergk wrote:
> > Proposal:
> > 
> > 'git checkout refs/heads/foo' (or 'git checkout heads/foo' for that
> > matter) does not check out the branch, but instead detaches HEAD at
> > foo. This is quite counter-intuitive (at least to me) and the same
> > functionality can be achieved by using e.g. foo~0. Change the behavior
> > so that the branch is actually checked out. This also applies to
> > e.g. 'git rebase master refs/heads/topic', which currently rebases a
> > detached HEAD. There are probably other examples as well that I'm not
> > aware of.
> 
> Just to clarify: You are not proposing that 'git checkout origin/master'
> would also not checkout to a detached head, right? Because that is a
> feature I am using frequently to test branches that have been pushed by
> another developer to a remote server. If that would create a new local
> branch that would be confusing.

Nope, I'm not proposing that. I wouldn't want that either.

/Martin
