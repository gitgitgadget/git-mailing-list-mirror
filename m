From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [GSoC update] Sequencer: The insn sheet format
Date: Wed, 6 Jul 2011 05:41:51 -0500
Message-ID: <20110706104151.GM15682@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 12:42:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QePYP-0007Xq-9T
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 12:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332Ab1GFKl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 06:41:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45522 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135Ab1GFKlz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 06:41:55 -0400
Received: by iwn6 with SMTP id 6so5962604iwn.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 03:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=guBwEtQsX62w39Nrw9KCLqm0BIJAhmINChzjJu3gepU=;
        b=pwyAwT0a0IF2All4DjEmqkYCQ0flJJhQlyZ9oEMj9kIG94Pbt4MRsRU2uoQ9HtlQfY
         q48T+l9JULeON0pPSpNdx/wkhoqoxS8d00Hg9UmryEGEUE7gTK3oCuBJwjx1sy2lfuhH
         eKxWYfuruiZ4Dqf87Kz5tBU6ruiX0/9tX1g0w=
Received: by 10.231.92.84 with SMTP id q20mr3019783ibm.92.1309948915268;
        Wed, 06 Jul 2011 03:41:55 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.sbcglobal.net [69.209.76.243])
        by mx.google.com with ESMTPS id w11sm4797091ibw.58.2011.07.06.03.41.53
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 03:41:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176684>

Ramkumar Ramachandra wrote:

> Thanks for reading.

Thanks for the many improvements!

I think the hardest piece in the series so far is what to do about
the

	git cherry-pick something-i-shouldnt-cherry-pick
	git reset --hard; # or git reset --merge HEAD
	git cherry-pick what-i-should-have-cherry-picked-instead

habit.  Aside from that, it would be nice to have more tests and some
simple documentation, and most other things I found were nitpicks.
