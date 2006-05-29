From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/4] t5500-fetch-pack: remove local (bashism) usage.
Date: Sun, 28 May 2006 22:36:46 -0700
Message-ID: <7vpshxbde9.fsf@assigned-by-dhcp.cox.net>
References: <11486091783808-git-send-email-normalperson@yhbt.net>
	<11486091793385-git-send-email-normalperson@yhbt.net>
	<20060526122317.GC5372@gondor.apana.org.au>
	<20060529052828.GB24077@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 07:36:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkaQt-0003bI-7p
	for gcvg-git@gmane.org; Mon, 29 May 2006 07:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWE2Fgr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 01:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWE2Fgr
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 01:36:47 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:65261 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751204AbWE2Fgr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 01:36:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060529053646.RNSB27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 May 2006 01:36:46 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060529052828.GB24077@localdomain> (Eric Wong's message of
	"Sun, 28 May 2006 22:28:28 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20921>

Eric Wong <normalperson@yhbt.net> writes:

> Herbert Xu <herbert@gondor.apana.org.au> wrote:
>> On Thu, May 25, 2006 at 07:06:17PM -0700, Eric Wong wrote:
>> > None of the variables seem to conflict, so local was unnecessary.
>> 
>> BTW, dash supports (and has always supported) local which is a quite
>> useful feature.
>
> Cool.  Hmm... pdksh seems to support it here (Debian sid).  I'm pretty
> sure local is not part of the POSIX spec, though; and I have seen
> /bin/sh that don't support it.

Concurred.  There are things Herbert said are clearly dash bugs,
but this one is outside POSIX, so lets leave your changes to the
test for it.
