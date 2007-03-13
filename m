From: Junio C Hamano <junkio@cox.net>
Subject: Re: Support for config wildcards
Date: Tue, 13 Mar 2007 12:50:26 -0700
Message-ID: <7v8xe0j531.fsf@assigned-by-dhcp.cox.net>
References: <17910.54683.651029.884390@lisa.zopyra.com>
	<7vird5jctl.fsf@assigned-by-dhcp.cox.net>
	<17910.59652.481204.872797@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 20:50:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRD0x-0003qX-8H
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 20:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbXCMTu1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 15:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933041AbXCMTu1
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 15:50:27 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61121 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932186AbXCMTu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 15:50:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070313195027.MAVB24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 13 Mar 2007 15:50:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aKqS1W00B1kojtg0000000; Tue, 13 Mar 2007 15:50:26 -0400
In-Reply-To: <17910.59652.481204.872797@lisa.zopyra.com> (Bill Lear's message
	of "Tue, 13 Mar 2007 12:10:12 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42147>

Bill Lear <rael@zopyra.com> writes:

> But that doesn't work for your example "all but xyz".  I guess in that
> case, I would need to check both branch patterns and if one did not
> match, then I would reject it and not add to the recipient list.
>
> Was that basically what you had in mind?

Yes, similar to how positive and negative entries in .gitignore
influences the final outcome of the 'ignoredness' for each path.
