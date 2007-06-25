From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule: provide easy way of adding new submodules
Date: Mon, 25 Jun 2007 00:09:09 -0700
Message-ID: <7vps3k33ze.fsf@assigned-by-dhcp.pobox.com>
References: <20070621095300.GA27071MdfPADPa@greensroom.kotnet.org>
	<7v8xaa4f5g.fsf@assigned-by-dhcp.pobox.com>
	<20070624151750.GA997MdfPADPa@greensroom.kotnet.org>
	<7vir9dtf5z.fsf@assigned-by-dhcp.cox.net>
	<20070624210607.GC997MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Jun 25 09:09:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2ihN-0007KR-ST
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 09:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbXFYHJN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 03:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753492AbXFYHJM
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 03:09:12 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:43100 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbXFYHJL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 03:09:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070625070911.HHJZ6565.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 Jun 2007 03:09:11 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fj9A1X0011kojtg0000000; Mon, 25 Jun 2007 03:09:10 -0400
In-Reply-To: <20070624210607.GC997MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Sun, 24 Jun 2007 23:06:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50867>

Sven Verdoolaege <skimo@kotnet.org> writes:

> To make a submodule effectively usable, the path and
> a URL where the submodule can be cloned need to be stored
> in .gitmodules.  This subcommand takes care of setting
> this information after cloning the new submodule.
> Only the index is updated, so, if needed, the user may still
> change the URL or switch to a different branch of the submodule
> before committing.
>
> Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
> ---
> On Sun, Jun 24, 2007 at 10:50:48AM -0700, Junio C Hamano wrote:
>> Sven Verdoolaege <skimo@kotnet.org> writes:
>> 
>> > They're different because submodule update (which also calls module_clone)
>> > is performed on a module that already exists in the repo and
>> > was therefore checked out by git as an empty directory.  If you
>> > add a new submodule, then there is no reason for the subdirectory
>> > to exist already.
>> 
>> Ah, you are absolutely right.  Thanks for the clarification.
>> 
>> By the way, when I have to say "thanks for the clarification", I
>> think it is an indication that the relevant parts of the code
>> need a bit of commenting ;-).
>
> How's this ?

I am not sure about the usefulness of "-b branch" thing myself,
but other than that, looks very sane to me.

Lars?
