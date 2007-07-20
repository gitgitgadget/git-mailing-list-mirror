From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (REVISED)] Add core.editor configuration variable
Date: Thu, 19 Jul 2007 17:20:55 -0700
Message-ID: <7v7iow2ae0.fsf@assigned-by-dhcp.cox.net>
References: <11848281302504-git-send-email-aroben@apple.com>
	<200707190848.54655.andyparkins@gmail.com>
	<95E642DA-F848-4398-9D9D-52B03A235887@silverinsanity.com>
	<alpine.LFD.0.999.0707191531330.22541@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Adam Roben <aroben@apple.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jul 20 02:21:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBgF6-0004iF-Ip
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 02:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758028AbXGTAU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 20:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758014AbXGTAU6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 20:20:58 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:55345 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286AbXGTAU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 20:20:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070720002056.BLCG1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Jul 2007 20:20:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RcLv1X0031kojtg0000000; Thu, 19 Jul 2007 20:20:56 -0400
In-Reply-To: <alpine.LFD.0.999.0707191531330.22541@xanadu.home> (Nicolas
	Pitre's message of "Thu, 19 Jul 2007 15:32:37 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53042>

Nicolas Pitre <nico@cam.org> writes:

> On Thu, 19 Jul 2007, Brian Gernhardt wrote:
>
>> For many people commit is more "core" to their git usage than write-tree and
>> commit-tree.  At this point, it's less an extra layer porcelain and more the
>> standard interface.  It's a result of the wonderful attempts to make git more
>> user friendly.
>> 
>> As far as [core] being only for plumbing, I disagree with that premise as
>> well.  Any option that is used across many of the git commands is a core
>> (meaning central) option.
>
> That pov certainly makes sense to me.

Good to see the discussion converged while I was trapped in the
day job.  So core.editor it is?
 
