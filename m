From: Theodore Tso <tytso@mit.edu>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Tue, 23 Oct 2007 01:30:03 -0400
Message-ID: <20071023053003.GE27132@thunk.org>
References: <20071016195744.GB32132@closure.lan> <7v3aw2aaxu.fsf@gitster.siamese.dyndns.org> <20071023012140.GC22997@thunk.org> <7vtzoi8voo.fsf@gitster.siamese.dyndns.org> <20071023020044.GA27132@thunk.org> <20071023040522.GX14735@spearce.org> <20071023043321.GC27132@thunk.org> <20071023044657.GC14735@spearce.org> <20071023045632.GD27132@thunk.org> <20071023050726.GD14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 07:30:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkCLY-0003ul-OQ
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 07:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbXJWFaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 01:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbXJWFaU
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 01:30:20 -0400
Received: from thunk.org ([69.25.196.29]:52744 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbXJWFaT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 01:30:19 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IkCVD-0001RZ-BV; Tue, 23 Oct 2007 01:40:31 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1IkCL5-0007fB-CN; Tue, 23 Oct 2007 01:30:03 -0400
Content-Disposition: inline
In-Reply-To: <20071023050726.GD14735@spearce.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62092>

On Tue, Oct 23, 2007 at 01:07:26AM -0400, Shawn O. Pearce wrote:
> Junio has in the past proposed rewinding next, especially after a
> significant release (e.g. 1.5.3).  

Hmm, yes.  I think I'd want to rewind next after a while; the thought
of next drifting hundreds or thousands of commits away from master
just gives me the heebee-jeebies.  I'm sure it mostly works, but it
just feels wrong.  :-)

> A bunch of folks (myself included if I recall correctly) didn't want
> to do this, as we create topic branches locally from things in next
> and sometimes make commits over them to improve the topic further.

I guess I don't see why this would be a hardship; would a quick rebase
on the topic branches more or less take care of the problem?  

I guess that brings up another question; I've been regularly rebasing
the topics branches as master and next advances... probably more out
of superstition than anything else.  Is that a bad idea for any reason?


Hmm... I guess some of this would be really good to get into the Howto
section of the user guide when talking about git workflows!

	       	    	       	       	     	 - Ted
