From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add -C[NUM] to git-am
Date: Wed, 07 Feb 2007 16:17:53 -0800
Message-ID: <7vejp14i4u.fsf@assigned-by-dhcp.cox.net>
References: <20070207201511.GF12140@mellanox.co.il>
	<7vejp17m3t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702080049330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<eqdos9$4up$2@sea.gmane.org>
	<Pine.LNX.4.63.0702080106200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 08 01:17:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEwz7-0006o4-Km
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 01:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161495AbXBHARy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 19:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422823AbXBHARy
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 19:17:54 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:60124 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161495AbXBHARy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 19:17:54 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070208001754.PGHN4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 19:17:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LoHt1W00H1kojtg0000000; Wed, 07 Feb 2007 19:17:53 -0500
In-Reply-To: <Pine.LNX.4.63.0702080106200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 8 Feb 2007 01:07:13 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39014>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> [please Cc me when replying]
>
> On Thu, 8 Feb 2007, Jakub Narebski wrote:
>
>> From documentation, it looks like applymbox can get signoff from a file, 
>> and am not.
>
> Seems like just another low-hanging fruit. But I cannot believe that this 
> is the only reason to keep applymbox.

I do not think <signoff> from file is of any practical use.  You
cannot feed your committer information to match from the same
file anyway.
