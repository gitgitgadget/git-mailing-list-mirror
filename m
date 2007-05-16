From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] import-tars: Use the "Link indicator" to identify directories
Date: Wed, 16 May 2007 11:49:51 -0700
Message-ID: <7vlkfoeh80.fsf@assigned-by-dhcp.cox.net>
References: <6efbd9b70705111308v47a76b04n9328ebf393a209e6@mail.gmail.com>
	<Pine.LNX.4.64.0705161659530.6410@racer.site>
	<7vsl9weie0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Riddoch <riddochc@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed May 16 20:49:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoOZS-0005ce-Ir
	for gcvg-git@gmane.org; Wed, 16 May 2007 20:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415AbXEPStx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 14:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756641AbXEPStx
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 14:49:53 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42817 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756415AbXEPStw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 14:49:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516184952.QHVI22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 16 May 2007 14:49:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id zupr1W00A1kojtg0000000; Wed, 16 May 2007 14:49:51 -0400
In-Reply-To: <7vsl9weie0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 16 May 2007 11:24:39 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47449>

Junio C Hamano <junkio@cox.net> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Earlier, we used the mode to determine if a name was associated with
>> a directory. This fails, since some tar programs do not set the mode
>> correctly. However, the link indicator _has_ to be set correctly.

Nah, what was I smoking.  Even gtar seems to give mode="0000775"
(with NUL termination) for directories, so there is no way there
were regressions.  Patch looks good.

	Acked-by: Junio C Hamano <junkio@cox.net>
