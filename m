From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "secret key not available". "unable to sign the tag".
Date: Wed, 19 Nov 2008 07:42:43 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811190740200.18283@nehalem.linux-foundation.org>
References: <31942.12221.qm@web37902.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Gary Yang <garyyang6@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 16:44:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2pDu-0003FV-5O
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 16:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbYKSPmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 10:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbYKSPmy
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 10:42:54 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37192 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753863AbYKSPmx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Nov 2008 10:42:53 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAJFgixA000934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Nov 2008 07:42:45 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAJFghi6010016;
	Wed, 19 Nov 2008 07:42:43 -0800
In-Reply-To: <31942.12221.qm@web37902.mail.mud.yahoo.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.437 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101353>



On Tue, 18 Nov 2008, Gary Yang wrote:
> 
> The gpg works. But, git tag dose not work. Any idea?

Does

	git tag -u garyyang6@yahoo.com tag-name

work (ie when you use an explicitly given key to tag with)?

And if not, please do list the output of "gpg -K" if that doesn't work.

			Linus
