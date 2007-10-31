From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 17:59:37 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710301752250.30120@woody.linux-foundation.org>
References: <20071016210904.GI26127@efreet.light.src> 
 <Pine.LNX.4.64.0710280000240.4362@racer.site>  <20071029174000.GA4449@efreet.light.src>
  <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org> 
 <20071029214925.GH21133@thunk.org>  <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org>
  <20071030030104.GK21133@thunk.org>  <7vtzo9s221.fsf@gitster.siamese.dyndns.org>
  <20071030044026.GA9600@thunk.org>  <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
 <46a038f90710301741n67526976vda1cd131270aa7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 02:00:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In1wy-00061v-0h
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 02:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbXJaBAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 21:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbXJaBAg
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 21:00:36 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58023 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751122AbXJaBAf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2007 21:00:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9V0xcxf018003
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Oct 2007 17:59:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9V0xbYS004438;
	Tue, 30 Oct 2007 17:59:37 -0700
In-Reply-To: <46a038f90710301741n67526976vda1cd131270aa7f@mail.gmail.com>
X-Spam-Status: No, hits=-2.431 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_66
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62772>



On Wed, 31 Oct 2007, Martin Langhoff wrote:
> 
> Having something functionally similar to
> 
>   cg-clone git://foo.tld/bar.git#blue
> 
> would save a few steps -- and some potential confusion -- for projects
> using GIT.

I do agree with that "functionally similar", I just disagree with the 
syntax.

The thing is, we don't want a single branch name. Not for clone, not for 
fetch, not for pull, and not for push.

Yes, a single branch may be one common case, but it's definitely not the 
only one, and it's fundamentally the wrong thing to use as a definition of 
syntax. 

It's also the wrong thing to do for local stuff.

			Linus
