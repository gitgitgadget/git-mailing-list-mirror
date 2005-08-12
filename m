From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add "--sign" option to git-format-patch-script
Date: Fri, 12 Aug 2005 09:28:39 -0700
Message-ID: <7v64ubxgp4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508121532051.25606@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7vr7czxj6s.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508121804240.26333@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Aug 12 18:29:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3cOl-0006e5-U9
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 18:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVHLQ2p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 12:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVHLQ2p
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 12:28:45 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:20188 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751221AbVHLQ2o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 12:28:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812162841.MQCR15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 12 Aug 2005 12:28:41 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508121804240.26333@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 12 Aug 2005 18:05:09 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Fri, 12 Aug 2005, Junio C Hamano wrote:
>
>> Good intentions, but I'd rather see these S-O-B lines in the
>> actual commit objects.  Giving format-patch this option would
>> discourage people to do so.  Maybe a patch to git commit would
>> be more appropriate, methinks.
>
> Maybe in addition to this one? I meant that option to be for on-passers of 
> commits they are not author of.

Surely.  Also I find Daniel's suggestion to check a good one.
