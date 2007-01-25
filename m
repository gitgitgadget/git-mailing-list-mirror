From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/4] add a test case for git-merge-one-file
Date: Wed, 24 Jan 2007 16:10:43 -0800
Message-ID: <7vy7nsc6f0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701240214000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 25 01:11:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9sCh-0001LP-SU
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 01:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932936AbXAYAKp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 19:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932948AbXAYAKp
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 19:10:45 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46703 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932936AbXAYAKo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 19:10:44 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070125001044.QPDP25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Wed, 24 Jan 2007 19:10:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FCB21W00M1kojtg0000000; Wed, 24 Jan 2007 19:11:02 -0500
In-Reply-To: <Pine.LNX.4.63.0701240214000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 24 Jan 2007 02:14:18 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37695>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +git-update-index --index-info << EOF
> +10644 $hash_one 1	one
> +10644 $hash_two 2	one
> +10644 $hash_three 3	one
> +EOF

How can this work with 10644 instead of 100644?  Did you spot a
bug in update-index --index-info?
