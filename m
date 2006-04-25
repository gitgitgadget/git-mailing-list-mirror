From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Tue, 25 Apr 2006 15:17:08 -0700
Message-ID: <8801.1146003428@lotus.CS.Berkeley.EDU>
References: <e2lrk5$ed5$1@sea.gmane.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 00:17:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYVqP-0006k9-Pn
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 00:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbWDYWRL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 18:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWDYWRL
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 18:17:11 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:19882 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751349AbWDYWRK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 18:17:10 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k3PMH9gH008830;
	Tue, 25 Apr 2006 15:17:09 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k3PMH9sU008829;
	Tue, 25 Apr 2006 15:17:09 -0700 (PDT)
To: Jakub Narebski <jnareb@gmail.com>
In-reply-to: <e2lrk5$ed5$1@sea.gmane.org> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19176>

And Jakub Narebski writes:
 - I don't mean we shouldn't define semantic for each use of "related" or
 - "note" header. Just like email X-* headres have detailed form and semantic
 - (long, long time ago Sender was X-Sender for example ;-). It's just a
 - toolkit.

You just proved Linus's point.  Ever have to parse
archives of old mail?  There are many different ways
of saying the same thing, and many of the same way
of saying different things.  It's pure hell.

And people expect you to get the X-* headers correct
for whatever definition of correct they happen to have
at the moment.  ugh.  You have many de-facto semantics
for the same headers, and no way to disambiguate them.

People will need to parse and understand git archives
thirty+ years from now.  Don't place this curse on
them.

Jason
