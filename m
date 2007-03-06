From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] revision walker: Fix --boundary when limited
Date: Mon, 05 Mar 2007 16:36:07 -0800
Message-ID: <7vk5xvw6mg.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
	<7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
	<Pine.LNX.4.63.0703060016020.13683@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Santi =?utf-8?Q?B?= =?utf-8?Q?=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 06 01:36:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HONf5-0002JS-JH
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 01:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933622AbXCFAgL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 19:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933611AbXCFAgL
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 19:36:11 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:64788 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933622AbXCFAgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 19:36:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306003608.YWRY2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 19:36:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XCc81W00D1kojtg0000000; Mon, 05 Mar 2007 19:36:09 -0500
In-Reply-To: <Pine.LNX.4.63.0703060016020.13683@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 6 Mar 2007 00:17:14 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41514>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 5 Mar 2007, Linus Torvalds wrote:
>
>> Anyway, I *suspect* that Dscho's patch might do the wrong thing for 
>> something like
>> 
>> 	gitk -20 v1.4.4.. t/
>> 
>> exactly because of the subtle interaction between pathname limiting, 
>> static commit limiting *and* commit number limiting. Dscho?
>
> Correct. I'll have a look at Junio's patch shortly, which hopefully makes 
> me forget my shortsighted patch.

I have a handful updates, including a few 'git-bundle' patches.
