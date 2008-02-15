From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xdl_merge(): introduce XDL_MERGE_ZEALOUS_ALNUM
Date: Fri, 15 Feb 2008 09:32:57 -0800
Message-ID: <7vlk5mgm5y.fsf@gitster.siamese.dyndns.org>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com>
 <alpine.LFD.1.00.0802121544370.2920@woody.linux-foundation.org>
 <alpine.LSU.1.00.0802130003370.3870@racer.site>
 <alpine.LSU.1.00.0802130108060.3870@racer.site>
 <7v3arxzlke.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802131113360.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Voltage Spike <voltspike@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 15 18:33:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ4Rc-0008QL-Cc
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 18:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbYBORdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 12:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327AbYBORdS
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 12:33:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbYBORdS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 12:33:18 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0993932DE;
	Fri, 15 Feb 2008 12:33:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 2B39732C1; Fri, 15 Feb 2008 12:33:07 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73965>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Maybe even both.  
>
> As Linus has stated in the other reply, up to three lines between two 
> conflicts could be "merged" with the conflicts by default, because less or 
> equally much screen estate would used.
>
> So I am thinking about an interface that is not too painful.

I think there is no excuse not to coalesce hunks separated by
three lines or less, so we can first get immediate improvement
without any configuration or tweaking.  My "less than N alnums"
was ill thought out overengineering, and Linus's improvement is
much cleaner.
