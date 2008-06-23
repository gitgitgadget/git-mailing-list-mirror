From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 14:26:39 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806231425270.2926@woody.linux-foundation.org>
References: <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org>
 <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org> <20080623210935.GC13395@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 23:30:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAtb8-0003UJ-Rc
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbYFWV2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbYFWV2S
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:28:18 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49364 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752304AbYFWV2R (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 17:28:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NLQexE008063
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jun 2008 14:26:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NLQd19017145;
	Mon, 23 Jun 2008 14:26:39 -0700
In-Reply-To: <20080623210935.GC13395@artemis.madism.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.844 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85934>



On Mon, 23 Jun 2008, Pierre Habouzit wrote:
> 
>   Let's see if I can catch it elegantly.

No.

Look at builtin-blame.c.

THEN get back to me.

Trust me, you need what I wrote. Something that parses all the options in 
one go, and ignores the ones it cannot parse, because a TOTALLY DIFFERENT 
function than the caller will call it!

Why is that so hard to accept? Especially since I already wrote the code 
and sent it out?

			Linus
