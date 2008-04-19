From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: Git performance on OS X
Date: Sun, 20 Apr 2008 00:08:15 +0200
Message-ID: <A80AA52C-4254-4580-83AA-1B3134B74430@ai.rug.nl>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191341210.2779@woody.linux-foundation.org> <alpine.LFD.1.10.0804191422480.2779@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 00:09:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnLF3-00014F-AH
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 00:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbYDSWIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 18:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbYDSWIR
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 18:08:17 -0400
Received: from smtp-4.orange.nl ([193.252.22.249]:20230 "EHLO smtp-4.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbYDSWIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 18:08:16 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6302.orange.nl (SMTP Server) with ESMTP id D60047000086;
	Sun, 20 Apr 2008 00:08:15 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6302.orange.nl (SMTP Server) with ESMTP id B17267000081;
	Sun, 20 Apr 2008 00:08:15 +0200 (CEST)
X-ME-UUID: 20080419220815726.B17267000081@mwinf6302.orange.nl
In-Reply-To: <alpine.LFD.1.10.0804191422480.2779@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79925>


On 19 apr 2008, at 23:29, Linus Torvalds wrote:
> Side note: on the kenrel tree, it makes the (insane!) operation
>
> 	git add $(git ls-files)
>
> go from 49 seconds down to 17 sec. So it does make a huge difference  
> for
> me, but I also want to point out that this really isn't a sane  
> operation
> to do (I also think that 17 sec is totally unacceptable, but I  
> cannot find
> it in me to care, since I don't think this is an operation that  
> anybody
> should ever do!)

Yes, using the patch decreases the time for my from ~40 seconds to  
just about 4 seconds.

- Pieter
