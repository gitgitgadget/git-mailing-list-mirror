From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix 'git commit -a' in a newly initialized repository
Date: Thu, 22 Feb 2007 21:03:02 -0800
Message-ID: <7vlkipbh4p.fsf@assigned-by-dhcp.cox.net>
References: <20070222202812.8882.44375.stgit@c165>
	<Pine.LNX.4.63.0702222140360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<alpine.LRH.0.82.0702221550290.27932@xanadu.home>
	<Pine.LNX.4.63.0702222157000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<alpine.LRH.0.82.0702221605080.27932@xanadu.home>
	<7vhctddge7.fsf@assigned-by-dhcp.cox.net>
	<alpine.LRH.0.82.0702221904210.27932@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Feb 23 06:03:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKSaL-00006R-HG
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 06:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbXBWFDF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 00:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbXBWFDF
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 00:03:05 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:48054 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbXBWFDE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 00:03:04 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223050302.TRKU6078.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Feb 2007 00:03:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id St311W00V1kojtg0000000; Fri, 23 Feb 2007 00:03:02 -0500
In-Reply-To: <alpine.LRH.0.82.0702221904210.27932@xanadu.home> (Nicolas
	Pitre's message of "Thu, 22 Feb 2007 19:06:41 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40414>

Nicolas Pitre <nico@cam.org> writes:

> On Thu, 22 Feb 2007, Junio C Hamano wrote:
>
>> However, because ! test -f "$THIS_INDEX" is such a special case
>> (totally new check-in), we can afford to be verbose if we wanted
>> to, and offer tons of possibilities, say:
>> 
>> 	die 'nothing to commit.  You can use "git add file..."
>> to include individual files, or use "git add ." if you want to 
>> include all files in the current directory, for your first
>> commit.'
>> 
>> But if we want to say "for your first commit" in the message, we
>> should also be checking if HEAD commit really does not exist.
>
> Seems to me that the single line message avoids all those issues.

Yup.  Will apply Fredrik's original to 'maint'.
