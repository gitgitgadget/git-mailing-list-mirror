From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive
Date: Thu, 22 Feb 2007 12:05:04 -0800
Message-ID: <7vy7mqdklr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xeqllxk.fsf@assigned-by-dhcp.cox.net>
	<7v4ppellev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702221719030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vr6sif1ox.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702222015040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 22 21:05:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKKBj-0000yo-NS
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 21:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbXBVUFH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 15:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbXBVUFH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 15:05:07 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:55934 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbXBVUFF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 15:05:05 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070222200505.HTOT2670.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Feb 2007 15:05:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Sk541W0041kojtg0000000; Thu, 22 Feb 2007 15:05:04 -0500
In-Reply-To: <Pine.LNX.4.63.0702222015040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 22 Feb 2007 20:16:34 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40377>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The only worry I would have is if that exact number is too large
>> that you cannot pass them sensibly in argv[].
>
> I thought there is only a limitation in bash?

I am sure kernel folks on the list would correct me, but my
understanding is that is execve(2) limitation and you would get
E2BIG.
