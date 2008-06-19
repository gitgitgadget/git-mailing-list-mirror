From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/4] Split up default "core" config parsing into helper
 routine
Date: Wed, 18 Jun 2008 17:23:21 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806181721580.2907@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806181524490.2907@woody.linux-foundation.org> <alpine.LFD.1.10.0806181529570.2907@woody.linux-foundation.org> <20080618224919.GA22599@sigill.intra.peff.net> <alpine.LFD.1.10.0806181552590.2907@woody.linux-foundation.org>
 <20080618231316.GB23053@sigill.intra.peff.net> <alpine.LFD.1.10.0806181632080.2907@woody.linux-foundation.org> <20080619000842.GA25117@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 19 02:25:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K97xZ-00040u-Hg
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 02:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634AbYFSAYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 20:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756453AbYFSAYB
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 20:24:01 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35424 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756608AbYFSAX4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 20:23:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5J0NM86024532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jun 2008 17:23:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5J0NLrg028494;
	Wed, 18 Jun 2008 17:23:21 -0700
In-Reply-To: <20080619000842.GA25117@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.853 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85432>



On Wed, 18 Jun 2008, Jeff King wrote:
> 
> Have you read "man git-config" lately?

That whole program is there just for scripting. Of _course_ it talks about 
the machine format!

Nobody should ever use "git-config" normally. You should fire up your 
editor and just edit the damn file in place. But no, we don't have a 
man-page for that.

		Linus
