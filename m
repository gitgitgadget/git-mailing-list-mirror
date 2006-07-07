From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not drop data from '\0' until eol in patch output
Date: Fri, 07 Jul 2006 03:52:05 -0700
Message-ID: <7vslld1ycq.fsf@assigned-by-dhcp.cox.net>
References: <1152268424350-git-send-email-sf@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 12:52:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FynwR-0001Li-Oa
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 12:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWGGKwI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 06:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWGGKwH
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 06:52:07 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:6313 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932102AbWGGKwG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 06:52:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707105206.NNJO22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 06:52:06 -0400
To: Stephan Feder <sf@b-i-t.de>
In-Reply-To: <1152268424350-git-send-email-sf@b-i-t.de> (Stephan Feder's
	message of "Fri, 07 Jul 2006 12:33:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23424>

Stephan Feder <sf@b-i-t.de> writes:

> The binary file detection is just a heuristic which can well fail.
> Do not produce garbage patches in these cases.
>
> Signed-off-by: Stephan Feder <sf@b-i-t.de>

Thanks.

I do not think this patch is _wrong_ per se, but I wonder what
you would use a patch like that for.  Specifically, do you apply
such a patch with NUL and other binary data in it, and if so
what tool do you use?
