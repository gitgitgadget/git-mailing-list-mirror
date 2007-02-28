From: Junio C Hamano <junkio@cox.net>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 20:33:55 -0800
Message-ID: <7vmz2y3npo.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070227154241.GA8228@thunk.org>
	<Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070227223929.GA9027@thunk.org> <86vehnnpy2.fsf@blue.stonehenge.com>
	<7vfy8rb2do.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702271605290.12485@woody.linux-foundation.org>
	<7vejob9l70.fsf@assigned-by-dhcp.cox.net>
	<20070228023208.GC2178@thunk.org>
	<7vr6sb2e5m.fsf@assigned-by-dhcp.cox.net>
	<20070228030347.GE2178@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 28 05:34:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMGW3-0001EZ-Vw
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 05:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbXB1Ed5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 23:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbXB1Ed5
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 23:33:57 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:43625 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbXB1Ed5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 23:33:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070228043357.QON6078.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 23:33:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UsZv1W00V1kojtg0000000; Tue, 27 Feb 2007 23:33:56 -0500
In-Reply-To: <20070228030347.GE2178@thunk.org> (Theodore Tso's message of
	"Tue, 27 Feb 2007 22:03:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40892>

Theodore Tso <tytso@mit.edu> writes:

> On Tue, Feb 27, 2007 at 06:45:41PM -0800, Junio C Hamano wrote:
>> Theodore Tso <tytso@mit.edu> writes:
>> 
>> > Well, the other design alternative is to make git-show take a list of
>> > objects, so that
>> >
>> > 	git show v1.5.0..v1.5.0.1
>> >
>> > ends up displaying the same thing as
>> >
>> > 	git show `git-rev-list v1.5.0..v1.5.0.1`
>> >
>> > ... but I'm not really convinced that's really all that useful.  
>> 
>> I think we are better off doing "git show v1.5.0..v1.5.0.1" for
>> that, but we do take multiple objects.
>
> Not sure I understand what you mean?  That:

I don't either.

I thought I was writing "git log v1.5.0..v1.5.0.1".

Sorry for the confusion.
