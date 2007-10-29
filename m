From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: remote#branch
Date: Mon, 29 Oct 2007 15:57:41 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org>
References: <20071015233800.6306e414@paolo-desktop> <20071016021933.GH12156@machine.or.cz>
 <Pine.LNX.4.64.0710161139530.25221@racer.site> <20071016210904.GI26127@efreet.light.src>
 <Pine.LNX.4.64.0710162228560.25221@racer.site> <20071027204757.GA3058@efreet.light.src>
 <Pine.LNX.4.64.0710280000240.4362@racer.site> <20071029174000.GA4449@efreet.light.src>
 <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org>
 <20071029214925.GH21133@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 29 23:58:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImdYq-0006MI-Ry
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 23:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbXJ2W6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 18:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbXJ2W6G
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 18:58:06 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57900 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751783AbXJ2W6E (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Oct 2007 18:58:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9TMvgTC027311
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Oct 2007 15:57:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9TMvfli030189;
	Mon, 29 Oct 2007 15:57:42 -0700
In-Reply-To: <20071029214925.GH21133@thunk.org>
X-Spam-Status: No, hits=-2.436 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_66
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62629>



On Mon, 29 Oct 2007, Theodore Tso wrote:
> 
> Well, the confusion is that we refer to things that look like
> "git://git.kernel.org/pub/scm/git/git.git" as if it were a URL.

Sure, but "URL" in human-speak has nothing to do with an RFC.

I dislike language-lawyerese. Why the hell do people think that human 
language should follow the RFC's?

Git addresses look like URL's, and they act like URL's, but dammit, git 
isn't a web browser, and it's not interested in acting like one. 

And "standards" are only as good as they are useful. XML is a piece of 
crap despite being a standard because it makes no sense. Similarly, "URL 
quoting" is a piece of crap when _it_ makes no sense. Having a RFC or an 
ISO standard doesn't change anything, and doesn't imply that human 
communication (or indeed, even machine communication) should care.

			Linus
