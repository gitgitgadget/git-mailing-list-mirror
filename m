From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] Add support for external programs for handling native
 fetches
Date: Sun, 26 Jul 2009 09:06:58 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907260901100.3960@localhost.localdomain>
References: <alpine.LNX.2.00.0907251330240.2147@iabervon.org> <alpine.LFD.2.01.0907251107500.3960@localhost.localdomain> <7viqhgrm1h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 18:07:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV6GB-0005dE-3x
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 18:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbZGZQHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 12:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753746AbZGZQHb
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 12:07:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46433 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753363AbZGZQHb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2009 12:07:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6QG6x4N028526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 26 Jul 2009 09:07:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6QG6wQ6013622;
	Sun, 26 Jul 2009 09:06:59 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7viqhgrm1h.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.959 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124124>



On Sat, 25 Jul 2009, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > So a very big Acked-by: from me for the series. I didn't test that http: 
> > works with it, but I don't personally even care, so I'd ack it even 
> > without that ;)
> 
> Heh, "git ls-remote http://..." segfaulting for me is not a very good
> sign, but I like the concept.

Hmm. Just tested. Works for me (git and kernel repos on kernel.org). Which 
repo did you test against?

		Linus
