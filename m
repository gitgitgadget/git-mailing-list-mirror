From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "secret key not available". "unable to sign the tag".
Date: Mon, 17 Nov 2008 20:21:22 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811172019080.18283@nehalem.linux-foundation.org>
References: <424422.27374.qm@web37902.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Gary Yang <garyyang6@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 05:22:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2I73-00045t-E5
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 05:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbYKREVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 23:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbYKREVb
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 23:21:31 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59503 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751061AbYKREVa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Nov 2008 23:21:30 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAI4LMsw003300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Nov 2008 20:21:23 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAI4LM4C012626;
	Mon, 17 Nov 2008 20:21:22 -0800
In-Reply-To: <424422.27374.qm@web37902.mail.mud.yahoo.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.437 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101259>



On Mon, 17 Nov 2008, Gary Yang wrote:
> 
> gpg: WARNING: using insecure memory!
> gpg: please see http://www.gnupg.org/faq.html for more information
> gpg: skipped `Gary Yang <garyyang6@yahoo.com>': secret key not available
> gpg: signing failed: secret key not available

What does

	gpg --list-secret-keys

say? Have you actually set up a key for that email address?

		Linus
