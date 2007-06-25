From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Darcs
Date: Sun, 24 Jun 2007 17:00:33 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706241657540.3593@woody.linux-foundation.org>
References: <cecbdd220706232232w77a609faxf0e6b2dc37f0d1f4@mail.gmail.com> 
 <alpine.LFD.0.98.0706241030540.3593@woody.linux-foundation.org> 
 <46a038f90706241345m4b5ecb80p9f4ec840993023e0@mail.gmail.com> 
 <7vlke9ouv8.fsf@assigned-by-dhcp.cox.net>
 <61e816970706241638j60830741p2cd1a102a72ae226@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Bu Bacoo <bubacoo@gmail.com>, git@vger.kernel.org
To: Dan Chokola <dan@chokola.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 02:01:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2c0q-0007mD-R4
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 02:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbXFYAA4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 20:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbXFYAA4
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 20:00:56 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48211 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751004AbXFYAAz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2007 20:00:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5P00dlr004538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 24 Jun 2007 17:00:40 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5P00XXi023502;
	Sun, 24 Jun 2007 17:00:33 -0700
In-Reply-To: <61e816970706241638j60830741p2cd1a102a72ae226@mail.gmail.com>
X-Spam-Status: No, hits=-2.56 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50848>



On Sun, 24 Jun 2007, Dan Chokola wrote:
> 
> What I have noticed is a lot of nitpicking, of which I'm guilty, too. The
> issue Linus brought up about Darcs and versioning is not one I typically see
> surface in real life. Users usually complain about some _release_ version
> or, "I updated last week."

Actually, in the kernel, we are getting quite a lot out of "git bisect", 
and people throw git SHA1's around to describe where they are, or a 
particular commit.

Which never happened with BK.

So I think that the _ability_ to name revisions easily across different 
uses is quite important, because it then drives behaviour.

Without it, you'll never notice you need it. With it, you start wondering 
how others handle it.

For example, we have people like Andrew, who don't really "use" git, and 
he starts pointing to commits with their git ID, because he sees them 
flying past, and he knows they are stable and useful for things like 
gitweb.

			Linus
