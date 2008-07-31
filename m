From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git vs Monotone
Date: Thu, 31 Jul 2008 13:30:50 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807311328500.3277@nehalem.linux-foundation.org>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org> <63BEA5E623E09F4D92233FB12A9F79430238A5EC@emailmn.mqsoftware.com> <alpine.LFD.1.10.0807311244240.3277@nehalem.linux-foundation.org>
 <7vmyjxyf7a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Craig L. Ching" <cching@mqsoftware.com>, sverre@rabbelier.nl,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 22:36:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOesk-0000mW-La
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 22:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757375AbYGaUfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 16:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757185AbYGaUfQ
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 16:35:16 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53551 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756259AbYGaUfO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 16:35:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VKXo9I022013
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2008 13:33:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VKXn01010663;
	Thu, 31 Jul 2008 13:33:50 -0700
In-Reply-To: <7vmyjxyf7a.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.406 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90983>



On Thu, 31 Jul 2008, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > ... And since the original pack-file is marked as a 'keep' file,
> > that original pack-file won't even be broken apart.
> 
> Oops, isn't that something we fixed recently as a "bug"?

Ehh, apparently. I had thought it was a feature (not that it was me who 
implemented it), and didn't realize that others thought it was a bug. 
Oops.

The default *.keep file was _wonderful_ for cloning a large tree onto a 
small machine. It did exactly the right thing (never mind any shared 
repositories - it just made repacking much more reasonable).

So maybe it was unintentional (a "bug"), but I had always seen it as being 
something good.

			Linus
