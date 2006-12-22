From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] libgit.a: add some UTF-8 handling functions
Date: Fri, 22 Dec 2006 14:33:01 -0800
Message-ID: <7vlkkzwogy.fsf@assigned-by-dhcp.cox.net>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
	<20061221085907.GA2244@cepheus>
	<Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<200612211623.14236.litvinov2004@gmail.com>
	<7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0612221030440.18171@xanadu.home>
	<7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612222201200.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7virg3y624.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612222233150.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vpsabwq34.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612222319230.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 23:33:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxsww-0002B0-BQ
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 23:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWLVWdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 17:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbWLVWdE
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 17:33:04 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64837 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbWLVWdC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 17:33:02 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222223302.OXRC29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 17:33:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1yYK1W00A1kojtg0000000; Fri, 22 Dec 2006 17:32:19 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612222319230.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 22 Dec 2006 23:20:12 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35237>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > To me, characters are the symbols occupying one "column" each. Bytes are 
>> > the 8-bit thingies that you usually use to encode the characters.
>> 
>> I cannot tell from your reponse if you are very well aware of
>> Asian "double-width" characters and your version of strlen()
>> counts one such character as two, or if you are totally unaware
>> about the issue and your function returns 1 for a string that
>> consists of a single such character.
>> 
>> If the former, then the function is not strlen() anymore, and if
>> the latter, then it is unusable for wrapping purposes.
>
> The latter. Oh, well. Call me a Western idiot.
>
> And scrap that patch.

Hey, don't give up too quickly.  Although the execution of the
initial revision might have been less than desirable, the series
really meant well and was in the right direction.  We do that
all the time ;-).
