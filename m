From: Sam Vilain <sam@vilain.net>
Subject: Re: Retroactively change email signature? [resend]
Date: Sat, 05 Jan 2008 12:04:50 +1300
Message-ID: <477EBB92.605@vilain.net>
References: <9b3e2dc20801021237v4d5d236fn3d2643502b9bb78f@mail.gmail.com> <alpine.LFD.1.00.0801021316080.3010@woody.linux-foundation.org> <477C7837.9000303@vilain.net> <alpine.LFD.1.00.0801041031590.2811@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 05 00:04:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAvak-0006QS-6r
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 00:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754AbYADXEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 18:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338AbYADXEK
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 18:04:10 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:36622 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753533AbYADXEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 18:04:09 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id EBB8721D148; Sat,  5 Jan 2008 12:04:06 +1300 (NZDT)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 77D9221D13A;
	Sat,  5 Jan 2008 12:04:01 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <alpine.LFD.1.00.0801041031590.2811@woody.linux-foundation.org>
X-Enigmail-Version: 0.95.0
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69612>

Linus Torvalds wrote:
> I don't care. If some commit refers to another commit that isn't its 
> ancestor, then that is undefined *anyway*. 
> 
> So the only case that really matters is when you refer to your own strict 
> ancestor.
> 
> This is one reason why it was so crazy that "git cherry-pick" used to have 
> "-x" by default - appending the original SHA1 (which is generally *not* an 
> ancestor) is meaningless and stupid.

Not stupid at all.  It gives you an easily clickable link to the
previous version of the patch, which may be of interest, and is
otherwise irretrievable information if the patch needed resolving.

Sam.
