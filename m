From: Junio C Hamano <junkio@cox.net>
Subject: Re: recent patch breaks the build ?
Date: Wed, 16 Nov 2005 17:15:40 -0800
Message-ID: <7vd5l03whv.fsf@assigned-by-dhcp.cox.net>
References: <437B6997.8010903@mc.com>
	<7v64qs8kuo.fsf@assigned-by-dhcp.cox.net> <437B8CEC.8040002@mc.com>
	<20051116203334.GA3968@reactrix.com>
	<Pine.LNX.4.63.0511170023040.9284@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051117004621.GB3968@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 02:16:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcYNQ-0006SI-Bh
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 02:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbVKQBPn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 20:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbVKQBPn
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 20:15:43 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:21431 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161068AbVKQBPm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 20:15:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051117011542.NBAH25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 20:15:42 -0500
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051117004621.GB3968@reactrix.com> (Nick Hengeveld's message of
	"Wed, 16 Nov 2005 16:46:21 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12080>

Nick Hengeveld <nickh@reactrix.com> writes:

> On Thu, Nov 17, 2005 at 12:25:06AM +0100, Johannes Schindelin wrote:
>
>> #if LIBCURL_VERSION_NUM < 0x070801
>> #error http-push needs curl >= 7.8.1 (because of CURLOPT_HTTPGET)
>> #endif
>
> Is it worth trying to figure this out in the Makefile instead, using eg.
> curl-config --vernum?

If we can do that reliably, that would be very nice for the
users.  Might be worth a try.
