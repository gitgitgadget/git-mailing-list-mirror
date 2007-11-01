From: Theodore Tso <tytso@mit.edu>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 1 Nov 2007 17:18:48 -0400
Message-ID: <20071101211848.GG2387@thunk.org>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org> <916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com> <7v4pg5btis.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:20:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InhSm-0006Vz-R0
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbXKAVUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753697AbXKAVUO
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:20:14 -0400
Received: from THUNK.ORG ([69.25.196.29]:47683 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753275AbXKAVUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:20:12 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Inhc1-00054U-8J; Thu, 01 Nov 2007 17:30:01 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1InhRA-0006CL-W6; Thu, 01 Nov 2007 17:18:48 -0400
Content-Disposition: inline
In-Reply-To: <7v4pg5btis.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63004>

On Thu, Nov 01, 2007 at 01:27:55PM -0700, Junio C Hamano wrote:
> I think what you are trying to do is to deprecate or remove "git
> clean".
> 
> I do not know where "git clean" came from.  I am suspecting that
> it was to give counterparts to some other SCMs, but do not know
> which ones.  Some people wanted to have it --- so you need to
> convince them that it is a bad idea first.  Adding an equivalent
> options to "git rm" alone does not solve that issue.

There's this great SCM tool called git that we can use to investigate
the history of changes....  :-)

Looks like it came from Cogito's cg-clean.  No one else has it as far
as I know, and I agree with others that it's a really not such a great
idea.  Fortunately most of the damage can be mitigated with "git
config --global clean.requireForce true", but the newbies won't know
to do that.  

							- Ted
