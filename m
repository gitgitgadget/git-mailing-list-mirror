From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Add 'sane' mode to 'git reset'
Date: Mon, 1 Dec 2008 10:06:24 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812011003360.3256@nehalem.linux-foundation.org>
References: <alpine.LFD.2.00.0812010908120.3256@nehalem.linux-foundation.org> <32541b130812010944k3dd825e4pfa8c270ecc75d539@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 19:08:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7DCF-0006i2-Nj
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 19:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbYLASHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 13:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752288AbYLASHT
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 13:07:19 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37123 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751388AbYLASHS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2008 13:07:18 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mB1I6PrJ002381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Dec 2008 10:06:26 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mB1I6ODq032507;
	Mon, 1 Dec 2008 10:06:24 -0800
In-Reply-To: <32541b130812010944k3dd825e4pfa8c270ecc75d539@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.436 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102074>



On Mon, 1 Dec 2008, Avery Pennarun wrote:
> 
> For reference, I advised someone just yesterday to use "git reset
> HEAD^" to undo an accidental "commit -a" instead of just "commit".

Yeah, I guess the --mixed default of "git reset" is occasionally useful.

> Also, as far as I know, "git reset HEAD filename" is the only
> recommended way to undo an accidental "git add".

The path-name based ones are actually a totally different animal than the 
non-pathname version of "git reset". With pathnames, it won't change the 
actual HEAD, so it's really a totally different class of command, just 
sharing a name.

But:

> How about calling it --merge instead?  That's really what it does:
> merges the diffs from (your current index) to (the requested index)
> into (your working tree and your index).

Sure, "git reset --merge" would probably be a fine form.

		Linus
