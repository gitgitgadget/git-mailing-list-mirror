From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Prepare "git-merge-tree" for future work
Date: Thu, 29 Jun 2006 19:32:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606291925230.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606281054470.3782@g5.osdl.org>
 <Pine.LNX.4.64.0606281401540.12404@g5.osdl.org> <7vejx7mmaj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 04:32:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw8o6-0007HV-P8
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 04:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWF3Cc3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 22:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWF3Cc3
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 22:32:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43159 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751416AbWF3Cc2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 22:32:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5U2WNnW010135
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Jun 2006 19:32:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5U2WMs7022173;
	Thu, 29 Jun 2006 19:32:23 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejx7mmaj.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22947>



On Thu, 29 Jun 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > I punted on trying to use the proper git diff interfaces (they are very 
> > tightly tied into the "diff_filespec" model - Junio, it might be nice if 
> > there was some way to use them in a setting where that isn't necessarily 
> > as natural).
> 
> I am not quite sure what you mean.

For what I wanted to do, I didn't see an easy way to add/populate a new 
filespec. It was easier to just use the raw libxdiff interfaces, but 
that's really just because I know the interfaces.

In contrast, the ones to diff_filespec I've never really used, and I did 
not want to compare blob objects, I very much wanted to compare in-memory 
buffers (_and_ potentially blobs).

So if you can show an easy example of how to populate a set of filespec 
pairs (not with blobs - with in-memory generated data) and insert them 
onto the lists, that would be good.

In fact, maybe you can show me what git-merge-tree needs to do..

Hint hint.

		Linus
