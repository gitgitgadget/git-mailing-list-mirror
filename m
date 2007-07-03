From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: being nice to patch(1)
Date: Mon, 2 Jul 2007 21:14:34 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707022114000.9434@woody.linux-foundation.org>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org>
 <20070702142557.eba61ccd.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org>
 <20070702145601.a0dcef0f.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
 <7vhcomuofl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org,
	quilt-dev@nongnu.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 06:14:51 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Zms-00065w-Ff
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 06:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbXGCEOs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 00:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbXGCEOs
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 00:14:48 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52634 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750731AbXGCEOr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2007 00:14:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l634EeLh022303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 Jul 2007 21:14:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l634EYtm030802;
	Mon, 2 Jul 2007 21:14:35 -0700
In-Reply-To: <7vhcomuofl.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.64 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51450>



On Mon, 2 Jul 2007, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > So I would suggest that in quilt and other systems, you either:
> >
> >  - strip all headers manually
> >
> >  - forget about "patch", and use "git-apply" instead that does things 
> >    right and doesn't screw up like this (and can do rename diffs etc too).
> >
> > I guess the second choice generally isn't an option, but dammit, 
> > "git-apply" really is the better program here.
> 
> Why not?  git-apply works outside of a git repo ;-)

I was more thinking that people are not necessarily willing to install git 
just to get the "git-apply" program..

		Linus
