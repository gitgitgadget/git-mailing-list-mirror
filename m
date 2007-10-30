From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 12:53:21 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710301252240.30120@woody.linux-foundation.org>
References: <20071029174000.GA4449@efreet.light.src>
 <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org>
 <20071029214925.GH21133@thunk.org> <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org>
 <20071030030104.GK21133@thunk.org> <7vtzo9s221.fsf@gitster.siamese.dyndns.org>
 <20071030044026.GA9600@thunk.org> <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
 <20071030053732.GA16963@hermes.priv> <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org>
 <20071030193610.GA4442@efreet.light.src>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Tom Prince <tom.prince@ualberta.net>, Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Oct 30 20:55:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImxBW-0002U9-9c
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 20:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbXJ3Tyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 15:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752990AbXJ3Tyt
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 15:54:49 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36154 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752953AbXJ3Tys (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2007 15:54:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9UJrRKX001175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Oct 2007 12:53:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9UJrLxT025079;
	Tue, 30 Oct 2007 12:53:23 -0700
In-Reply-To: <20071030193610.GA4442@efreet.light.src>
X-Spam-Status: No, hits=-2.431 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_66
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62745>



On Tue, 30 Oct 2007, Jan Hudec wrote:
> > 
> > Now, the *transport* back-end may end up quoting it, of course, the same 
> > way it may end up using some random protocol. The user shouldn't care 
> > about the implementation details!
> 
> Yes. But the server will unquote it. ' ' should not have been there, but it's
> just passed through if it was. '+' is quoting for ' ' and '%20' is quoting
> for ' ' as well. Therefore all these three addresses are the *SAME*.

Ok, you have some reading comprehension skills.

Read the above again.

I'd certainly hope that *curl* does the proper quoting. That's a transport 
issue.

		Linus
