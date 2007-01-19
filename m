From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation/git.txt: command re-classification
Date: Fri, 19 Jan 2007 14:22:17 -0800
Message-ID: <7vbqkufyhy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701181713200.2577@xanadu.home>
	<7v1wlrle61.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701191437450.3011@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 23:22:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H827p-00054u-T5
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 23:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbXASWWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 17:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbXASWWT
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 17:22:19 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:54585 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964899AbXASWWS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 17:22:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119222218.WZZH16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 17:22:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DANb1W0021kojtg0000000; Fri, 19 Jan 2007 17:22:35 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0701191437450.3011@xanadu.home> (Nicolas Pitre's
	message of "Fri, 19 Jan 2007 17:08:53 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37210>

Nicolas Pitre <nico@cam.org> writes:

> OK.  But I think the following are still misclassified:
>
>   git-rev-parse
>   git-runstatus
>   git-fsck-objects

Thanks for proofreading.  runstatus should be a pure helper.  I
am not sure what rev-parse and fsck-objects are, but they are
not primary porcelain.  rev-parse could sit next to rev-list and
fsck-objects, I guess.

>> +The interface (input, output, set of options and the semantics)
>> +to these low-level commands are meant to be a lot more stable
>> +than Porcelain level commands, because these commands are
>> +primarily for scripted use.  To put it another way, the
>> +interface to Plumbing commands are subject to change in order to
>> +improve the end user experience.
>
> I think the "to put it another way" sentence is a bit confusing here.

I agree.  What I wanted to say was the interface to plumbing is
sacred and we will not lightly change it without a very good
reason, while Porcelains are more or less "for breaking".

Better wording is certainly appreciated.
