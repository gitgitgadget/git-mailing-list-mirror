From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: repo.or.cz wishes?
Date: Mon, 27 Aug 2007 16:34:37 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708271632000.25853@woody.linux-foundation.org>
References: <20070826235944.GM1219@pasky.or.cz> <20070827001634.GB1976MdfPADPa@greensroom.kotnet.org>
 <20070827004153.GN1219@pasky.or.cz> <alpine.LFD.0.999.0708271114470.25853@woody.linux-foundation.org>
 <mj+md-20070827.195605.14967.albireo@ucw.cz>
 <alpine.LFD.0.999.0708271509230.25853@woody.linux-foundation.org>
 <46D356F9.1010506@vilain.net> <alpine.LFD.0.999.0708271616520.25853@woody.linux-foundation.org>
 <46D35E8A.8010409@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Martin Mares <mj@ucw.cz>, Petr Baudis <pasky@suse.cz>,
	skimo@liacs.nl, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Aug 29 16:13:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPo7i-0003eN-0U
	for gcvg-git@gmane.org; Tue, 28 Aug 2007 01:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758723AbXH0Xft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 19:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbXH0Xft
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 19:35:49 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47787 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758787AbXH0Xfs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2007 19:35:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7RNYbgE010520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Aug 2007 16:34:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7RNYb0B001876;
	Mon, 27 Aug 2007 16:34:37 -0700
In-Reply-To: <46D35E8A.8010409@vilain.net>
X-Spam-Status: No, hits=-2.75 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.29__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56899>



On Tue, 28 Aug 2007, Sam Vilain wrote:
> 
> Why annoying and impractical, if you don't ever have to specify it
> unless you want to write a URI which is portable between applications?

Sure. I'm perfectly happy to make connect.c just ignore any "git+" prefix, 
and let people do it.

What I object to is:
 - the totally *idiotic* notion that "ssh" is somehow different
 - encouraging people to actually *use* that inconvenient format

The fact is, nobody really cares. We've happily used the non-"git+" forms 
for over two years, and there has never *ever* been a case of actual 
confusion. So allowing the "git+" prefix everywhere may be _logical_, but 
it's still totally idiotic and user-unfriendly.

		Linus
