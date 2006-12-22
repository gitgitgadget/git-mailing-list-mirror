From: Junio C Hamano <junkio@cox.net>
Subject: Re: specify charset for commits
Date: Fri, 22 Dec 2006 11:01:54 -0800
Message-ID: <7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
	<20061221085907.GA2244@cepheus>
	<Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<200612211623.14236.litvinov2004@gmail.com>
	<7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0612221030440.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 20:02:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxpeZ-0005Gi-Ot
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 20:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbWLVTB5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 14:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWLVTB5
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 14:01:57 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:54183 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbWLVTB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 14:01:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222190156.FRNK97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 14:01:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1v1D1W0031kojtg0000000; Fri, 22 Dec 2006 14:01:13 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0612221030440.18171@xanadu.home> (Nicolas Pitre's
	message of "Fri, 22 Dec 2006 10:31:53 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35196>

Nicolas Pitre <nico@cam.org> writes:

> On Fri, 22 Dec 2006, Johannes Schindelin wrote:
>
>> Hi,
>> 
>> On Thu, 21 Dec 2006, Junio C Hamano wrote:
>> 
>> >  (2) update commit-tree to reject non utf-8 log messages and
>> >      author/committer names when i18n.commitEncoding is _NOT_
>> >      set, or set to utf-8.
>> 
>> The problem is: you cannot easily recognize if it is UTF8 or not, 
>> programatically. There is a good indicator _against_ UTF8, namely the 
>> first byte can _only_ be 0xxxxxxx, 110xxxxx, 1110xxxx, 11110xxx. But there 
>> is no _positive_ sign that it is UTF8. For example, many umlauts and other 
>> special modifications to letters, stay in the range 0x7f-0xff.
>
> Still... that would be a good enough thing to have in the majority of 
> cases, wouldn't it?

I think that would be very sane thing to do.
