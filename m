From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sat, 30 Jun 2007 20:01:59 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706301955560.1172@woody.linux-foundation.org>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
 <7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net> <20070630194335.GK7730@nan92-1-81-57-214-146.fbx.proxad.net>
 <7vtzsoami9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 05:02:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4phV-0000w2-IW
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 05:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038AbXGADCL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 23:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754992AbXGADCL
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 23:02:11 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38743 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754934AbXGADCK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jun 2007 23:02:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l61325PR022489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 30 Jun 2007 20:02:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6131xTK015924;
	Sat, 30 Jun 2007 20:01:59 -0700
In-Reply-To: <7vtzsoami9.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.654 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51270>



On Sat, 30 Jun 2007, Junio C Hamano wrote:
> 
> The current scripts that largely use "git-foo" do not have to be
> changed.  Your --no-alias and Linus's "git - foo" would be a
> "solution", but both require changes to the scripts

No. I didn't (and wouldn't) _remove_ the "git-xyzzy" thing.

I'm just saying that it should be considered a secondary thing, and we 
should have the long-term *option* to remove it.

And in order to do that, we should start removing our dependency on it 
earlier rather than later.

Your whole alias argument is bogus, since we don't _allow_ aliases to 
override the command (as you yourself did admit).

So changing the current scripts from using "git-xyzzy" to using "git 
xyzzy" changes nothing at all - except it gives people the _option_ to 
stop installing the git-* links if they don't want to.

With my script, you can actually do it and have a mostly working setup. 
Yeah, not installing the git-* links will actually break some things, but 
it won't break the really common stuff. 

As it is, we have to have the git-* links somewhere, and I don't see why 
you or others argue that that _requirement_ is somehow a better thing than 
not requiring it.

With my patch, it's a _choice_, rather than a straight-jacket.

		Linus
