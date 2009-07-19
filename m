From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 1/3] push: add --current
Date: Sun, 19 Jul 2009 23:46:38 +0200
Message-ID: <4A63943E.80209@gnu.org>
References: <1247526462-17584-1-git-send-email-bonzini@gnu.org>	<1247526462-17584-2-git-send-email-bonzini@gnu.org> <20090720063244.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 23:46:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSeDd-0007og-5H
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 23:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbZGSVqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 17:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbZGSVqn
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 17:46:43 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:50892 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbZGSVqm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2009 17:46:42 -0400
Received: by bwz28 with SMTP id 28so1658464bwz.37
        for <git@vger.kernel.org>; Sun, 19 Jul 2009 14:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=rnz6jKVZKzIeuxhmQq04bithck4WL1BqgFKKMCHbxh4=;
        b=vBsa1Dqhf5df/0KUz2VDK5Mod9xAX50uVfaidXsostU7GtAjQ5Ij1Nfqo4Xj5vNvH5
         bxyKxNvTB++PEL1U2lEW5dBwVWTO2Kj8f2I0ce1U3IBB6v8AP+uQGfomjnyznEaXo+zT
         QSNjj7R0ILe5vP87oAmYYRQK44K0PaualxwHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=COJUht7RnMm/MXTafdj04OAvWA4hTdZ5jtfr9alrEQ6zXsjh1TPC8JYEOnmR+gE2J3
         GB6Uw5jVfz7EfQmPVsmbZ29Y3+pgLRx+goHE3m+XHsT4l9Thd24Jnl5VQXTdt0MaCdg3
         kERDdQOjL9c9rbG9eAaj9p+o9l0tMiPs+KfgA=
Received: by 10.204.116.208 with SMTP id n16mr3610611bkq.96.1248040000713;
        Sun, 19 Jul 2009 14:46:40 -0700 (PDT)
Received: from scientist-2.local ([85.93.118.17])
        by mx.google.com with ESMTPS id 19sm6596261fkr.55.2009.07.19.14.46.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Jul 2009 14:46:40 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (Macintosh/20090605)
In-Reply-To: <20090720063244.6117@nanako3.lavabit.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123561>

Thanks for the review!

> If your final belief (which I happen to agree) is that
> 
> % git push --current
> % git push --current origin
> % git push --current over.there.example.com:project.git
> 
> should work as expected [...] mark clearly that the code after this patch is still broken

Okay, will do.  I just wanted to present both possibilities and thought
that (succeeding) tests were the best way to illustrate the difference.
 For the final submission, now that I had a second opinion, I'll
probably just squash 1/3 and 2/3 together.

> The style of the existing tests in the script isn't
> 
> 	test `git rev-parse master` = `cd b.git && git rev-parse master`
> 
> but is
> 
> 	test "$(git rev-parse master)" = "$(cd b.git && git rev-parse master)"

Will do.

Paolo
