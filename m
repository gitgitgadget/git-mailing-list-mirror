From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: unmerging feature branches
Date: Tue, 23 Oct 2007 12:49:12 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710231247301.30120@woody.linux-foundation.org>
References: <20071023152445.GA10070@piper.oerlikon.madduck.net>
 <alpine.LFD.0.999.0710230922240.30120@woody.linux-foundation.org>
 <7vir4x7hiu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 21:50:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkPlb-0005Yo-LY
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 21:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbXJWTuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 15:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbXJWTuE
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 15:50:04 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35545 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752457AbXJWTuB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2007 15:50:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NJnDVT003075
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Oct 2007 12:49:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NJnC6X003498;
	Tue, 23 Oct 2007 12:49:12 -0700
In-Reply-To: <7vir4x7hiu.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.72 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62154>



On Tue, 23 Oct 2007, Junio C Hamano wrote:
> 
> Desire to revert an octopus would, as you demonstrated, often be
> to revert only one arm, but I think allowing to revert a twohead
> merge should be trivial.  If we define "reverting a merge" to
> always revert all arms, then this should suffice.

The only reason I don't like this is that it kind of assumes that the 
mainline is the first parent. 

Maybe I'd like to revert a merge, but I want to revert a merge that 
somebody *else* did, and maybe it was the first-hand parent I don't like. 

Those kinds of issues don't exist with non-merge commits: there's never 
any question "which side" to revert.

			Linus
