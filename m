From: Junio C Hamano <junkio@cox.net>
Subject: Re: CFT: merge-recursive in C
Date: Wed, 28 Jun 2006 02:22:30 -0700
Message-ID: <7v64il4otl.fsf@assigned-by-dhcp.cox.net>
References: <20060626233838.GA3121@steel.home>
	<20060628063747.GA983@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 11:22:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvWFm-00045K-OI
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 11:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423239AbWF1JWc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 05:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423240AbWF1JWc
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 05:22:32 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:5326 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1423239AbWF1JWb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 05:22:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060628092231.EONM19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Jun 2006 05:22:31 -0400
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20060628063747.GA983@informatik.uni-freiburg.de> (Uwe
	Zeisberger's message of "Wed, 28 Jun 2006 08:37:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22789>

Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:

> Hello Alex,
>
>> +// does not belong here
> Some C compiler (e.g. Sun Forte) don't like C++-style comments.

Heh, I said something like that last year and was scolded by
Linus who responded "what century are you living in?" ;-).
