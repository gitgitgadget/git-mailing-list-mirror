From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix failed tag parsing when tag object has no body/message (and thus ends with a single '\n')
Date: Fri, 08 Jun 2007 09:06:08 -0700
Message-ID: <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	<200706080208.14571.johan@herland.net>
	<7vd507m159.fsf@assigned-by-dhcp.cox.net>
	<200706081018.34207.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jun 08 18:06:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwgyk-0005Cg-VV
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 18:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967812AbXFHQGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 12:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765856AbXFHQGL
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 12:06:11 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61278 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763720AbXFHQGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 12:06:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070608160608.WIVO9600.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Jun 2007 12:06:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 94681X00D1kojtg0000000; Fri, 08 Jun 2007 12:06:08 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49482>

Johan Herland <johan@herland.net> writes:

> I can:
>
> 1. Provide a new patch series to totally replace the previous 6-part patch 
> series (plus bugfixes). The new patch series will make smaller steps and 
> end up (hopefully) in a better place, with less overzealous 
> checking/parsing, and more "traditional" whitespacing.
>
> OR
>
> 2. Provide the babystep-series ending up exactly where we are today (i.e. 
> after the patch series, plus bug fixes). Then, provide patches on top of 
> the existing series to get it into shape, both scope-wise (i.e. not trying 
> to do too much) and whitespace-wise.
>
> Which do you prefer?

I am not sure if there is any practical difference between the
two ;-).  But in either case, it appears that we should first
revert d9fa4a8 from 'next' and start from clean slate.  It
really seems that the patch series did upset too many people;
personally I found the first patch still was follow-able, but I
do agree that it should have been much smaller and not mixing
too many things into one).

So, let's do 1.
