From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Wed, 14 Feb 2007 10:12:16 -0800
Message-ID: <7vd54cpq0v.fsf@assigned-by-dhcp.cox.net>
References: <200702140909.28369.andyparkins@gmail.com>
	<slrnet5p5h.s9h.siprbaum@xp.machine.xx>
	<Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfy98snus.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702141843190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vlkj0pqp5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702141901250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 14 19:12:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOc8-0005zy-J6
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 19:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbXBNSMR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 13:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbXBNSMR
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 13:12:17 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46190 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932417AbXBNSMR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 13:12:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214181217.HGRU21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 13:12:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PWCG1W00E1kojtg0000000; Wed, 14 Feb 2007 13:12:16 -0500
In-Reply-To: <Pine.LNX.4.63.0702141901250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 14 Feb 2007 19:02:01 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39715>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 14 Feb 2007, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > Well, I don't use it myself (other than testing that the patch does what 
>> > it says). Let the list decide?
>> 
>> I am slightly worried about stupid distros screwing people over
>> by shipping with a bad default config in /etc, which would make
>> diagnosing their problems harder without knowing what they have
>> there.  But other than that I do not have a problem with it.
>
> They can do that already by shipping with a bad default /etc/skel/ 
> directory.

That's slightly different.  I can ask "Do you have anything
special in your $HOME/.gitconfig?"  Now I have to ask two
questions (and I would not know if a particular distro compiled
git to use /etc/git/default.config or /etc/gitconfig or whatever).
