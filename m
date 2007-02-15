From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Thu, 15 Feb 2007 03:26:36 -0800
Message-ID: <7vr6srd5lf.fsf@assigned-by-dhcp.cox.net>
References: <200702140909.28369.andyparkins@gmail.com>
	<Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfy98snus.fsf@assigned-by-dhcp.cox.net>
	<200702151019.25409.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 12:27:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHelT-0007i0-NT
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 12:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965882AbXBOL0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 06:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965890AbXBOL0j
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 06:26:39 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:39067 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965882AbXBOL0i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 06:26:38 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070215112638.YYKT22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 15 Feb 2007 06:26:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PnSc1W00J1kojtg0000000; Thu, 15 Feb 2007 06:26:37 -0500
In-Reply-To: <200702151019.25409.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 15 Feb 2007 10:19:24 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39819>

Andy Parkins <andyparkins@gmail.com> writes:

> On Wednesday 2007 February 14 16:30, Junio C Hamano wrote:
>
>> Site-wide configuration for options that are potentially
>> compatibility-breaking is a bad idea on a multi-user machines,
>> and it was certainly the case back when our machines hosted many
>> diverse set of people.
>
> Isn't it more likely that on a multi-user machine all users are sharing one 
> install of git - in which case you do want the upgrade of facilities to be 
> system-wide.

Not really.  Some repositories would need to be accessible by
people with older git coming over the network.  Some don't.
