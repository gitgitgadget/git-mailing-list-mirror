From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Validate nicknames of remote branches to prohibit
 confusing ones
Date: Fri, 15 Feb 2008 14:22:16 -0800
Message-ID: <7vskztg8rr.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802151412390.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Feb 15 23:23:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ8xR-0000qZ-Pe
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 23:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756761AbYBOWW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 17:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756657AbYBOWW2
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 17:22:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53268 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbYBOWW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 17:22:27 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 333941B67;
	Fri, 15 Feb 2008 17:22:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 98A921B65; Fri, 15 Feb 2008 17:22:23 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802151412390.13593@iabervon.org> (Daniel
 Barkalow's message of "Fri, 15 Feb 2008 14:14:18 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73991>

Daniel Barkalow <barkalow@iabervon.org> writes:

> The original problem was that the parsers for configuration files were
> getting confused by seeing as nicknames remotes that involved
> directory-changing characters. In particular, the branches config file
> for ".." was particularly mystifying on platforms that can open
> directories and read odd data from them.
>
> The validation function was written by Junio Hamano (with a typo
> corrected).
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> I was sort of expecting you to just put this in yourself, but since you 
> haven't, I wrote it up as an actual patch and fixed the polarity of the 
> test for slashes.

Thanks.  I am bogged down in day-job these days and have been
down-sick for the past 36 hours.
