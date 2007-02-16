From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Dissociating a repository from its alternates
Date: Fri, 16 Feb 2007 12:13:01 -0800
Message-ID: <7v8xex50aa.fsf@assigned-by-dhcp.cox.net>
References: <7vabzfhn9q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702151638130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 16 21:13:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI9S8-0006zX-SC
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 21:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946108AbXBPUNF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 15:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946109AbXBPUNF
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 15:13:05 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:42195 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946108AbXBPUNE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 15:13:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070216201303.HUJX1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Feb 2007 15:13:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QLD21W0071kojtg0000000; Fri, 16 Feb 2007 15:13:02 -0500
In-Reply-To: <Pine.LNX.4.63.0702151638130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 15 Feb 2007 16:39:44 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39947>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 14 Feb 2007, Junio C Hamano wrote:
>
>> People often start out with "clone -l -s" (or --reference) and
>> later wish to dissociate the repository from its alternates.
>
> Why not make a really dumb script which just _copies_ (or maybe 
> optionally hard link) the objects from the alternate repo, and then kills 
> the alternatives file? That should be easier. You always can repack after 
> that.

I think that is much safer.
