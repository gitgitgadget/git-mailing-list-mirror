From: Dan Zwell <dzwell@gmail.com>
Subject: Re: git-diff not showing changes (corrupt repo?)
Date: Tue, 02 Oct 2007 23:00:16 -0500
Message-ID: <470313D0.7020808@gmail.com>
References: <47029414.3080100@gmail.com> <7vbqbhl44h.fsf@gitster.siamese.dyndns.org> <470309D5.702@gmail.com> <20071003032331.GA11638@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 06:00:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcvPn-0003Tu-0E
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 06:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbXJCEAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 00:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbXJCEAm
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 00:00:42 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:25979 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbXJCEAl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 00:00:41 -0400
Received: by nz-out-0506.google.com with SMTP id s18so3140759nze
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 21:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=iYWI0cl7vK+BYfhKHgwElm9KRz+U2bkHnvTH5rgfO6E=;
        b=fnlJzGWKyGWvJWOuHqtUCwggmLa28dcma+Rzq0U0KAf5BnsCopzKsLuaedaXsROK4tlIyqMDkNFuo6PCzxp5SbZ7KQU3QEEHuzB/qDjkyy9i0TPVg/YHk72GQNfWeYRsLepiG4VG2cc5FtrVsA+MFeqd84GB9cr5AXFwaGfOdto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dgOYDuMUJIUxXxsYOOgUB6gPgRdZaSeDGUelo5OGbsi3I1by35fF632pegn0VA4htkJm/x44Dnt/LPgA+88tscyS+x1dCYhPDSQ40uNsUVWFp218pB8JLDaSdEDahRfKTs8eoEyaeGlHSa0lCqO9aGWgXqFryLsc7KcHYHzpGZI=
Received: by 10.115.106.7 with SMTP id i7mr3508201wam.1191384039908;
        Tue, 02 Oct 2007 21:00:39 -0700 (PDT)
Received: from ?143.44.70.185? ( [143.44.70.185])
        by mx.google.com with ESMTPS id c12sm247270nzc.2007.10.02.21.00.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Oct 2007 21:00:39 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070922)
In-Reply-To: <20071003032331.GA11638@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59776>

Jeff King wrote:
 > On Tue, Oct 02, 2007 at 10:17:41PM -0500, Dan Zwell wrote:
 >
 >> e88ee2915493213ea0d0be64c542c090fefd4b33 is first bad commit
 >> commit e88ee2915493213ea0d0be64c542c090fefd4b33
 >> Author: Martin Waitz <tali@admingilde.org>
 >> Date:   Tue Oct 10 21:16:25 2006 +0200
 >>
 >>     paginate git-diff by default
 >
 > The only thing this patch does is run the pager, so presumably git-diff
 > _is_ generating output, but calling the pager is broken for some reason.
 > What is the value of $GIT_PAGER and $PAGER on the broken and working
 > machines? Can you confirm that the pager works on both machines?
 >

You're absolutely right, my pager was being called and exiting. My 
system configuration must be dodgy, because "echo hi | less 
--quit-if-one-screen" does not display anything unless it in run in 
"screen". But that's not git's fault, and I just need different options, 
for now. Thanks a lot for helping me solve this.

Dan

 >
 > -Peff
 >
