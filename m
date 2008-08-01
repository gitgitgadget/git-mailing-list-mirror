From: cte <cestreich@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 19:12:37 -0700
Message-ID: <ac9f0f090807311912h31c47f8ey43e0109c38f5a91d@mail.gmail.com>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
	 <20080731105727.GF7008@dpotapov.dyndns.org>
	 <ac9f0f090807310410u461f5584ved74769d8452c539@mail.gmail.com>
	 <bd6139dc0807311127j57d9ab5ckd6acf16d17621614@mail.gmail.com>
	 <ac9f0f090807311444lb2f02e6ud76463b359184fbd@mail.gmail.com>
	 <bd6139dc0807311451t763aa07bsf9474fce4073babd@mail.gmail.com>
	 <ac9f0f090807311817n551f53a5mb1270e6f4b2a058e@mail.gmail.com>
	 <alpine.LFD.1.10.0807311840240.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, "Dmitry Potapov" <dpotapov@gmail.com>,
	git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 04:14:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOk9s-0001jE-Kq
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 04:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbYHACMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 22:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbYHACMj
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 22:12:39 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:11185 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbYHACMj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 22:12:39 -0400
Received: by yw-out-2324.google.com with SMTP id 9so503664ywe.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 19:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hAScxEPtMo8akj3EuQ5frIO6inhrvB2Eh+TfHlUXBa0=;
        b=IdGRtG/TSyPuwZjTaWr8/U/sApwsgsjWg6ufsH73pQS+KFx3k460GL7IlejDiV3YCI
         Bdu4TyS1FUbI5VzXoDHw9NcAj+ZRzdMcsuKcZ+PaCkX2P9aaU4Wi9KRDTbMZXR//TgC9
         nTgOMSKNEL1SxUOnuGKsaM7Gb6f2L14Hs0j70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NYfWdxsQP3gCG7EkX7PKh8FpRr50qRW7lXgDlwSH/OOPQgJLQdsHv7H4SxBbgdFeR5
         djxE5FyT8/pKImZU1PaLqBwxwOPl1WHT6f/f4Qncl8ChN2/zSnHk+2nR1xAaON0al5Z5
         NTMlUnBNo5ZnKJCjEIvrvnL8vZFPNp8Pey+9c=
Received: by 10.150.49.1 with SMTP id w1mr2292520ybw.4.1217556758018;
        Thu, 31 Jul 2008 19:12:38 -0700 (PDT)
Received: by 10.151.78.17 with HTTP; Thu, 31 Jul 2008 19:12:37 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0807311840240.3277@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91019>

> So it's very true that git in general is geared towards scripting (and
> we've often added things to make it even more so), but no, your particular
> complaint isn't true. gitk doesn't do anything really strange.

Yeah, I guess that's why I like using git so much; a few piped
commands and a script or two, and you can do some pretty rad stuff.
