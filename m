From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not drop data from '\0' until eol in patch output
Date: Fri, 07 Jul 2006 05:03:18 -0700
Message-ID: <7vd5chzkop.fsf@assigned-by-dhcp.cox.net>
References: <1152268424350-git-send-email-sf@b-i-t.de>
	<7vslld1ycq.fsf@assigned-by-dhcp.cox.net> <44AE431C.4090509@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 14:03:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fyp3L-0005rH-Sh
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 14:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWGGMDU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 08:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWGGMDU
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 08:03:20 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:43157 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932128AbWGGMDU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 08:03:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707120319.CCAI11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 08:03:19 -0400
To: sf <sf@b-i-t.de>
In-Reply-To: <44AE431C.4090509@b-i-t.de> (sf@b-i-t.de's message of "Fri, 07
	Jul 2006 13:18:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23435>

sf <sf@b-i-t.de> writes:

> GNU patch can apply patches with binary content which are typically
> produced with GNU diff with --text option.

Hmph.  Things must have improved since I looked at it the last
time, perhaps 6-7 years ago.  I remember that I used "diff -a
-u0" as an el-cheapo way to deliber binary contents but found
that patch sometimes could not grok such, and ended up writing a
small customized C program.
