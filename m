From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-subtree Ready #2
Date: Mon, 27 Feb 2012 18:04:51 -0800 (PST)
Message-ID: <m3ehtfvhkv.fsf@localhost.localdomain>
References: <87ty2ro1zf.fsf@smith.obbligato.org>
	<20120220205346.GA6335@sigill.intra.peff.net>
	<7vd399jdwc.fsf@alter.siamese.dyndns.org>
	<CAHqTa-2s1xbAfNvjD7cXBe2TBMs1985nag1NOYVfE+dATvfEWA@mail.gmail.com>
	<7vobsox84l.fsf@alter.siamese.dyndns.org>
	<CAHqTa-1fbi5W7R2fLu3bp7Yuv_ZB9nxhgjHkLGuU8-V4016+JA@mail.gmail.com>
	<87hayfv75y.fsf@smith.obbligato.org>
	<7vy5rrfft2.fsf@alter.siamese.dyndns.org>
	<87ty2ft0tm.fsf@smith.obbligato.org>
	<7vobsk56md.fsf@alter.siamese.dyndns.org>
	<20120227212157.GA19779@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"David A. Greene" <greened@obbligato.org>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 28 03:05:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2CRb-0001PU-IW
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 03:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab2B1CFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 21:05:16 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64823 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502Ab2B1CEy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 21:04:54 -0500
Received: by eaah12 with SMTP id h12so2422562eaa.19
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 18:04:52 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.202.130 as permitted sender) client-ip=10.14.202.130;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.202.130 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.202.130])
        by 10.14.202.130 with SMTP id d2mr9627199eeo.83.1330394692845 (num_hops = 1);
        Mon, 27 Feb 2012 18:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=0TmOpqqVau1JgKAllZQ97pllwmieLzFwqDYvn/ZMm/c=;
        b=DweOyVqVatzqn7hFgmi1XDBv5LPvEQGYAjUR0AwgpI+mMHYQGU8gIN+GTM+1OkhFGa
         Y2tyAfqMoUGrQebQEm4tzhO3UGTOw4Dqkn4BS9dKeE0jvC/mWI13JeXOmS3R5aZaimA7
         Ig1TJfW+fliPVaRMvpH8cDpXpmslWi8TC917I=
Received: by 10.14.202.130 with SMTP id d2mr7173837eeo.83.1330394692694;
        Mon, 27 Feb 2012 18:04:52 -0800 (PST)
Received: from localhost.localdomain (abwi97.neoplus.adsl.tpnet.pl. [83.8.232.97])
        by mx.google.com with ESMTPS id s48sm64679923eem.0.2012.02.27.18.04.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Feb 2012 18:04:51 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1S24qDZ010995;
	Tue, 28 Feb 2012 03:04:53 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1S24neL010992;
	Tue, 28 Feb 2012 03:04:49 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120227212157.GA19779@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191695>

Jeff King <peff@peff.net> writes:

> 
> Yeah, I don't see much point in rewriting. If parts of the history suck,
> then so be it.  It's probably not that big to store. And while it's
> sometimes easier to fix bad commit messages when they are recent and in
> your memory (rather than trying to remember later what you meant to
> say), I think it is already too late for that. Any archaeology you do
> now to make good commit messages could probably just as easily be done
> if and when somebody actually needs the commit message later (emphasis
> on the "if" -- it's likely that nobody will care about most of the
> commit messages later at all).

Anyway we already have subtree merges if subsystem with bad error
messages -- see gitweb.
-- 
Jakub Narebski
