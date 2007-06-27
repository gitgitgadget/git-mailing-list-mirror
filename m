From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix zero-object version-2 packs
Date: Tue, 26 Jun 2007 17:41:46 -0700
Message-ID: <7vtzsuw7n9.fsf@assigned-by-dhcp.pobox.com>
References: <alpine.LFD.0.98.0706261428420.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Tjernlund <tjernlund@tjernlund.se>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 27 02:42:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Lbj-0005Dc-4X
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 02:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbXF0Alu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 20:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753122AbXF0Alu
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 20:41:50 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:52735 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbXF0Alr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 20:41:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627004147.QHUX1594.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Jun 2007 20:41:47 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GQhm1X00A1kojtg0000000; Tue, 26 Jun 2007 20:41:46 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50993>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> A pack-file can get created without any objects in it (to transfer "no 
> data" - which can happen if you use a reference git repo, for example, 
> or just otherwise just end up transferring only branch head information 
> and already have all the objects themselves).
>
> And while we probably should never create an index for such a pack, if we 
> do (and we do), the index file size sanity checking was incorrect.
>
> This fixes it.
>
> Reported-and-tested-by: Jocke Tjernlund <tjernlund@tjernlund.se>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>
> Tjernlund <tjernlund@tjernlund.se> wrote:
>>
>> [SNIP patch]
>> 
>> Tested your patch and the error went away, many thanks

Thank you very much to both of you.  Will be in 'maint'.
