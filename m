From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 11:19:11 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710301100470.30120@woody.linux-foundation.org>
References: <20071029174000.GA4449@efreet.light.src>
 <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org>
 <20071029214925.GH21133@thunk.org> <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org>
 <20071030030104.GK21133@thunk.org> <7vtzo9s221.fsf@gitster.siamese.dyndns.org>
 <20071030044026.GA9600@thunk.org> <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
 <20071030053732.GA16963@hermes.priv> <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org>
 <20071030160232.GB2640@hermes.priv> <alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org>
 <vpq8x5kh4rr.fsf@bauges.imag.fr>
 <alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Tom Prince <tom.prince@ualberta.net>, Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:21:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imvhv-0006dx-Fc
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 19:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbXJ3SUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 14:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbXJ3SUl
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 14:20:41 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34098 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751808AbXJ3SUk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2007 14:20:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9UIJD2Z028114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Oct 2007 11:19:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9UIJBU3020959;
	Tue, 30 Oct 2007 11:19:11 -0700
In-Reply-To: <alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.432 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_66
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62725>



On Tue, 30 Oct 2007, Linus Torvalds wrote:
> 
> So if you want to make that RFC have any relevance what-so-ever, then show 
> some interoperability issue. Which is why I'm bringing up a web browser: 
> that interop issue simply *does*not*exist*.

Btw, the reason I care is that the whole ".. but it's a standard" thinking 
really is dangerous. It's how you create absolute and utter crap.

It's why I have also brought up XML in this discussion, because XML is a 
classic example of something where this ".. but it's a standard" thinking 
has resulted in really bad solutions. It's pushed as a way to 
"interoperate", but then, since everybody does different things, the only 
thing you can actually interoperate with is by having a common parsing 
library for a REALLY HORRIBLY BAD FORMAT!

The same is true of a URL. What is there to interoperate with? The whole 
(and only) point of the git remote URL is to point git to a different git 
repository. There's no other reason to use it. So the only possible case 
we care about interoperability is with other git uses.

And those other git uses are not RFC1738-quoted, are they? 

			Linus
