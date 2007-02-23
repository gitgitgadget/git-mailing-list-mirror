From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 23 Feb 2007 10:12:58 -0800
Message-ID: <7virds4uad.fsf@assigned-by-dhcp.cox.net>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
	<7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702231258400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 23 19:14:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKew4-0007HO-2Y
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 19:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933153AbXBWSNB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 13:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933152AbXBWSNA
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 13:13:00 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:47378 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933153AbXBWSM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 13:12:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223181258.GUMA3767.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 23 Feb 2007 13:12:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id T6Cy1W00i1kojtg0000000; Fri, 23 Feb 2007 13:12:59 -0500
In-Reply-To: <Pine.LNX.4.63.0702231258400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 23 Feb 2007 15:48:33 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40458>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 23 Feb 2007, Junio C Hamano wrote:
>
>> * js/fetch-progress (Tue Feb 20 03:01:44 2007 +0100) 1 commit
>>  + fetch & clone: do not output progress when not on a tty
>> 
>> I'll see it in action from my cron job.
>
> That's how I tried to test it. It does not work. The problem is that the 
> remote git-upload-pack is unlikely to understand the option 
> "--no-progress".
>
> So maybe we have to make this a new pack protocol option?

Yes.
