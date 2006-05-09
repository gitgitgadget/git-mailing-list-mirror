From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitopt - command-line parsing enhancements
Date: Tue, 09 May 2006 01:35:55 -0700
Message-ID: <7vzmhr7fys.fsf@assigned-by-dhcp.cox.net>
References: <1147151209168-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 10:36:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdNhH-0006vc-MT
	for gcvg-git@gmane.org; Tue, 09 May 2006 10:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWEIIf5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 04:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWEIIf5
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 04:35:57 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:58821 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751479AbWEIIf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 04:35:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509083556.GIJO27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 May 2006 04:35:56 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <1147151209168-git-send-email-normalperson@yhbt.net> (Eric Wong's
	message of "Mon, 08 May 2006 22:06:43 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19829>

Eric Wong <normalperson@yhbt.net> writes:

> Here's my take at a new command-line option parser to reduce wear on my
> fingers.  It handles both long and short options, permuting, automatic
> abbreviations, required arguments, optional arguments, and bundling.

Taken a superficial look at it.

Sounds nice, might be a tad too ambitious though.  Looks
intrusive at places.

And scary, especially the "eat" macros are very scary.

I have to think about it a bit.
