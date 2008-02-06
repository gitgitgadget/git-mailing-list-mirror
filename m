From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Wed, 6 Feb 2008 11:26:50 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802061124550.2967@woody.linux-foundation.org>
References: <20080203030054.GA18654@coredump.intra.peff.net> <20080203043310.GA5984@coredump.intra.peff.net> <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org> <7vr6fsk08w.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org>
 <alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org> <7vir13g9hx.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org> <alpine.LSU.1.00.0802052228280.8543@racer.site> <alpine.LFD.1.00.0802051539570.2967@woody.linux-foundation.org>
 <20080206164303.GA1255@code-monkey.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Tilman Sauerbeck <tilman@code-monkey.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:28:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMpwB-0002Rh-4C
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 20:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbYBFT1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 14:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbYBFT13
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 14:27:29 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40396 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752301AbYBFT13 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 14:27:29 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m16JQrGI011119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Feb 2008 11:26:59 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m16JQoqi026390;
	Wed, 6 Feb 2008 11:26:50 -0800
In-Reply-To: <20080206164303.GA1255@code-monkey.de>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.215 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72829>



On Wed, 6 Feb 2008, Tilman Sauerbeck wrote:
> 
> I'm not sure whether this repository was import from another SCM, but I
> doubt it. I'm fairly sure that 3a7340af2bd57488f832d7070b0ce96c4baa6b54
> was created using git commit though. I guess the committer's clock just
> was a little late at that point.

Heh. I thought it was imported from the outside because the commit log 
looks so damn nasty. I'm used to projects with good and readable logs, so 
I associate "native" git repos with logs that actually explain what's 
going on.

But yeah, it looks like your repo is a perfectly native git repo, it just 
has really sucky log messages. I guess you can create crap logs in any 
SCM, even if the system is written to encourage good logs ;)

		Linus
