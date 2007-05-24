From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Wed, 23 May 2007 17:50:42 -0700
Message-ID: <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net>
References: <11799589913153-git-send-email-skimo@liacs.nl>
	<Pine.LNX.4.64.0705240039370.4113@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 24 02:50:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr1XY-0005BD-HG
	for gcvg-git@gmane.org; Thu, 24 May 2007 02:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240AbXEXAuo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 20:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756000AbXEXAuo
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 20:50:44 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:45310 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240AbXEXAun (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 20:50:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070524005043.TITN2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 May 2007 20:50:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2oqh1X00J1kojtg0000000; Wed, 23 May 2007 20:50:42 -0400
In-Reply-To: <Pine.LNX.4.64.0705240039370.4113@racer.site> (Johannes
	Schindelin's message of "Thu, 24 May 2007 00:40:20 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48212>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 24 May 2007, skimo@liacs.nl wrote:
>
>> This patch series implements a mechanism for cloning submodules.
>> Each submodule is specified by a 'submodule.<submodule>.url'
>> configuration option, e.g.,
>> 
>> bash-3.00$ ./git-config --remote=http://www.liacs.nl/~sverdool/isa.git --get-regexp 'submodule\..*\.url' 
>> submodule.cloog.url /home/sverdool/public_html/cloog.git
>> submodule.cloog.url http://www.liacs.nl/~sverdool/cloog.git
>
> I am sorry to complain so late in the game, but I am not really interested 
> in submodules. However, what you say here is not a task for git-config 
> IMHO, but rather for git-remote.

Honestly speaking, I do not think people have no business
peeking into configuratoin remote repository has, and it would
be preferrable that supermodule Porcelain stuff does not rely on
that.
