From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a --user option to git-config
Date: Wed, 01 Aug 2007 11:31:47 -0700
Message-ID: <7vzm1b3y3w.fsf@assigned-by-dhcp.cox.net>
References: <46AB7041.8070605@ramsay1.demon.co.uk>
	<Pine.LNX.4.64.0707282103150.14781@racer.site>
	<46AFAF7D.7010306@ramsay1.demon.co.uk>
	<Pine.LNX.4.64.0708011913070.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 01 20:32:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGIzm-0003oq-9H
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 20:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765493AbXHASbu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 14:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761592AbXHASbt
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 14:31:49 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57117 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761636AbXHASbs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 14:31:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801183147.VRUO7349.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Aug 2007 14:31:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WiXn1X0061kojtg0000000; Wed, 01 Aug 2007 14:31:47 -0400
In-Reply-To: <Pine.LNX.4.64.0708011913070.14781@racer.site> (Johannes
	Schindelin's message of "Wed, 1 Aug 2007 19:13:35 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54463>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Yep, which is why I made it a synonym; git-gui uses the
>> --global option, for example, and I'm confident that other
>> (user) scripts use it too. The "future" I had in mind was
>> something like 1 year down the road, but it could be longer
>> (or forever) if necessary.
>
> Please read my reply as "I vote against ever removing the --global 
> option".

I would say with --system present, I do not see much point
having the new alias --user either.  Get used to it.  It is
global across the repositories you have control over.
