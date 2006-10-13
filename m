From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] git-repack: -b to pass --delta-base-offset
Date: Fri, 13 Oct 2006 15:11:02 -0700
Message-ID: <7vslhrc1e1.fsf@assigned-by-dhcp.cox.net>
References: <11607177011745-git-send-email-junkio@cox.net>
	<11607177024171-git-send-email-junkio@cox.net>
	<Pine.LNX.4.64.0610130912500.2435@xanadu.home>
	<7v64endi6x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610131757050.2435@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 14 00:11:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYVFE-0003Lt-Ry
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 00:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbWJMWLF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 18:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbWJMWLF
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 18:11:05 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:16329 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751895AbWJMWLD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 18:11:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061013221102.JMTC18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Fri, 13 Oct 2006 18:11:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZyB51V00T1kojtg0000000
	Fri, 13 Oct 2006 18:11:06 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610131757050.2435@xanadu.home> (Nicolas Pitre's
	message of "Fri, 13 Oct 2006 17:58:43 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28866>

Nicolas Pitre <nico@cam.org> writes:

>> So how about
>> 
>> 	[core]
>>         	repackUseDeltaBase = true
>
> I agree, although "repackUseDeltaBase" is a bit vague as both delta 
> types do use a delta base.

True; core.repackUseDeltaBaseOffset that is.
