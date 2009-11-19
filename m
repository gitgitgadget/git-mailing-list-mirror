From: Greg Bacon <gbacon@dbresearch.net>
Subject: Re: [PATCH] No diff -b/-w output for all-whitespace changes
Date: Thu, 19 Nov 2009 16:25:14 -0600
Message-ID: <4B05C5CA.6090408@dbresearch.net>
References: <1258665144-26520-1-git-send-email-gbacon@dbresearch.net> <200911192314.41542.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Nov 19 23:25:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBFRL-0002JX-Ct
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 23:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbZKSWZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 17:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754568AbZKSWZK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 17:25:10 -0500
Received: from smtp202.iad.emailsrvr.com ([207.97.245.202]:40353 "EHLO
	smtp202.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbZKSWZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 17:25:09 -0500
Received: from relay20.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay20.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id E0A9F1B42A3;
	Thu, 19 Nov 2009 17:25:14 -0500 (EST)
Received: by relay20.relay.iad.mlsrvr.com (Authenticated sender: gbacon-AT-dbresearch.net) with ESMTPSA id 9F9D51B4171;
	Thu, 19 Nov 2009 17:25:14 -0500 (EST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <200911192314.41542.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133264>

Thomas Rast wrote

> Judging from the test, this parses as
> 
>   Change git-diff's whitespace-ignoring modes to generate
>   output only if a non-(empty patch, which git-apply
>   rejects) results.
> 
> which is a bit weird, isn't it? :-)

Yes, rotten wording. I meant git-apply rejects empty patches,
so let's not do that!

I chose this route rather than making git-apply more
forgiving because as currently implemented, git-diff is not
entirely ignoring whitespace when commanded to do so.

Greg
