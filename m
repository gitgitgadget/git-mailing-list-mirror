From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Gui criticism
Date: Sat, 05 Dec 2009 20:25:14 +0100
Message-ID: <4B1AB39A.7080500@drmicha.warpmail.net>
References: <loom.20091205T194800-496@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ram Rachum <cool-rr@cool-rr.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 20:25:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH0Fy-0006qG-H6
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 20:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757939AbZLETZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 14:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757937AbZLETZO
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 14:25:14 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59787 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757936AbZLETZO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Dec 2009 14:25:14 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 76D89C545E;
	Sat,  5 Dec 2009 14:25:20 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sat, 05 Dec 2009 14:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=KBCZv6HwxmndGwnt/+9JqUWsGow=; b=bFK0j28IzvMT8ZcvFlOInjtmFELU1oB9PS+PRfbttbnoR45GOu/3TKfLspG2N1gty2AvLXFL0bAbfmy0GcEbWlRBfcH+ROkfUpFGyAO3vdIraKVlXKaFFuov09tRhDoAPULAlYIWmAG0mureJCKnFwaM3wIVHDR2HtLcwR3nFLI=
X-Sasl-enc: 1neHlevqBRt8YydJ99InKBHKq7zr2NHdnGiVZ7yqX8Lw 1260041120
Received: from localhost.localdomain (p5DCC0D75.dip0.t-ipconnect.de [93.204.13.117])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B83C74A65E9;
	Sat,  5 Dec 2009 14:25:19 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091204 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <loom.20091205T194800-496@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134615>

Ram Rachum venit, vidit, dixit 05.12.2009 19:51:
> Hello!
> 
> This is my first time on this list. I'm a Python developer who's been using git 
> for about a year. I generally like it, but I have several gripes about the GUI. 
> (My development machine is on Windows XP.) Would specifying these criticisms be 
> helpful to you?

No, unless they are specific bug reports.

The main problem is that we have too many GUIs, and the "main" ones are
in tcl/tk which not many people write. So there's a small developer base
for the standard GUI, and the rest prefers to split up and each do their
own GUI rather than work on a coordinated project. (I've tried to change
that before.)

Michael
