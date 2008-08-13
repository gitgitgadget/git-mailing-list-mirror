From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] git-daemon: Simplify child management and associated logging by
Date: Wed, 13 Aug 2008 09:21:01 +0200
Message-ID: <20080813072101.GA12628@cuci.nl>
References: <20080812193613.32388.92145.stgit@aristoteles.cuci.nl> <20080812212534.6871.19377.stgit@aristoteles.cuci.nl> <20080812223224.GA4134@steel.home> <20080812231210.GB15265@cuci.nl> <20080813062008.GA4345@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 09:22:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTAgK-0001KG-F6
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 09:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbYHMHVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 03:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbYHMHVE
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 03:21:04 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:46823 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbYHMHVE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 03:21:04 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 526985465; Wed, 13 Aug 2008 09:21:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080813062008.GA4345@blimp.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92188>

Alex Riesen wrote:
>Stephen R. van den Berg, Wed, Aug 13, 2008 01:12:10 +0200:
>> Alex Riesen wrote:
>> I merely copied the other argument parsing methods, didn't want to
>> improve this, just functionally equivalent (will do fine here, IMO).

>In case of error max_connections will be 0. How does your code handle
>it? It is a server side program, which supposed to provide reliable
>service. In this case, an operator mistake is not even noticable until
>the first request and even than the clients have to complain first.

Well, same thing that goes wrong when the timeout is set too low,
of course.
But, you have a point, I'll provide a reasonable cap and support
unlimited as well.
-- 
Sincerely,
           Stephen R. van den Berg.

"And now for something *completely* different!"
