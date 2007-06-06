From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add git-index-pack -l to list objects in a pack
Date: Wed, 06 Jun 2007 14:35:45 -0700
Message-ID: <7vtztkyde6.fsf@assigned-by-dhcp.cox.net>
References: <11811227811793-git-send-email-sam.vilain@catalyst.net.nz>
	<alpine.LFD.0.99.0706060952410.12885@xanadu.home>
	<466725C4.5090707@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Jun 06 23:36:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw3BP-0001sB-O7
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 23:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbXFFVfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 17:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbXFFVfv
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 17:35:51 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:43051 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964902AbXFFVfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 17:35:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606213546.IIUE29545.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 17:35:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8Mbl1X0071kojtg0000000; Wed, 06 Jun 2007 17:35:45 -0400
In-Reply-To: <466725C4.5090707@catalyst.net.nz> (Sam Vilain's message of "Thu,
	07 Jun 2007 09:23:16 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49319>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> Nicolas Pitre wrote:
>>> I couldn't figure out how to make git-unpack-objects -n work.
>>> But it seems to be easy in the loop in index-pack
>> 
>> Why don't you simply use git-show-index?
>
> Because I found the enticing -n switch in the documentation first?
>
> That command certainly would have done the trick for what I needed it
> to do.  Perhaps change the documentation of the switch?

I think this is "incorrect expectation".  The document says:

>  -n::
> -        Only list the objects that would be unpacked, don't actually unpack
> -        them.

I suspect that you were trying to unpack in a repository that
already had that object?  They are not "the objects that would
be unpacked" hence not listed.
