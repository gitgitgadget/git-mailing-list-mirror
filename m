From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-email and aliases
Date: Mon, 26 Mar 2007 02:47:39 -0700
Message-ID: <7vwt14wd38.fsf@assigned-by-dhcp.cox.net>
References: <38b2ab8a0703260239j3f3f0be2teee70fc502f6f7c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 11:47:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVlnk-0003zX-56
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 11:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933782AbXCZJrl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 05:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933784AbXCZJrl
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 05:47:41 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:51365 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933782AbXCZJrk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 05:47:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326094741.VLXK1312.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 05:47:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fMnf1W0011kojtg0000000; Mon, 26 Mar 2007 05:47:40 -0400
In-Reply-To: <38b2ab8a0703260239j3f3f0be2teee70fc502f6f7c1@mail.gmail.com>
	(Francis Moreau's message of "Mon, 26 Mar 2007 11:39:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43140>

"Francis Moreau" <francis.moro@gmail.com> writes:

> Hi,
>
> I'm trying to make an alias for 'git send-email' as following but it's
> not working:
>
> [alias]
> 	send-email = send-email --no-signed-off-cc --suppress-from
>
> Is it failing because git-send-email is an external command ?

$ sed -ne '/^alias\.\*/,/^$/p' Documentation/config.txt
