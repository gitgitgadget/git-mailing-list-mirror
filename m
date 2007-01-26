From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Teach git-describe to display distances from tags.
Date: Thu, 25 Jan 2007 16:13:05 -0800
Message-ID: <7vmz4663xq.fsf@assigned-by-dhcp.cox.net>
References: <20070125173954.GA13276@spearce.org>
	<7vmz46ajcq.fsf@assigned-by-dhcp.cox.net>
	<7v7ivaailb.fsf@assigned-by-dhcp.cox.net>
	<20070125214923.GD13874@spearce.org>
	<Pine.LNX.4.64.0701251830400.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jan 26 01:13:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAEiP-0000oz-LJ
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 01:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030662AbXAZANK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 19:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030663AbXAZANK
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 19:13:10 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48086 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030662AbXAZANJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 19:13:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126001306.XOXX3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jan 2007 19:13:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FcC91W0031kojtg0000000; Thu, 25 Jan 2007 19:12:09 -0500
In-Reply-To: <Pine.LNX.4.64.0701251830400.3021@xanadu.home> (Nicolas Pitre's
	message of "Thu, 25 Jan 2007 18:32:01 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37786>

Nicolas Pitre <nico@cam.org> writes:

> On Thu, 25 Jan 2007, Shawn O. Pearce wrote:
>
>> We probably should make an option to enable the count, and
>> if the count is enabled then we'll have to pickup counting
>> where we left off and finish it out for the chosen tag so
>> the count is correct.
>
> Please don't make it an option.  This is too useful to require an 
> additional switch all the time.

Hmph.  And an option --no-number to disable this is probably not
worth it, as it forces the existing scripts that wants the
tagname to be updated to pass that new option.  If the users
need to update their scripts anyway, they can sed/expr the
number out just as easily as passing the new option.

Another backward incompatibility to mention in the release
notes.  I guess it is not too big a deal but makes me feel
uneasy.
