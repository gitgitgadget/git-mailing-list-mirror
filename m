From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] send-email: allow sendmail binary to be used instead of SMTP
Date: Mon, 15 May 2006 14:13:25 -0700
Message-ID: <7vhd3rgfey.fsf@assigned-by-dhcp.cox.net>
References: <1147660345772-git-send-email-normalperson@yhbt.net>
	<7vpsifx2b7.fsf@assigned-by-dhcp.cox.net>
	<20060515092704.GB6855@localdomain>
	<7vmzdjtya4.fsf@assigned-by-dhcp.cox.net>
	<20060515210110.GR32076@h4x0r5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 23:13:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfkNm-0004ov-NS
	for gcvg-git@gmane.org; Mon, 15 May 2006 23:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965233AbWEOVNg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 17:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbWEOVNf
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 17:13:35 -0400
Received: from fed1rmmtai16.cox.net ([68.230.241.43]:18869 "EHLO
	fed1rmmtai16.cox.net") by vger.kernel.org with ESMTP
	id S965233AbWEOVNf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 17:13:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515211326.QTJT19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 17:13:26 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060515210110.GR32076@h4x0r5.com> (Ryan Anderson's message of
	"Mon, 15 May 2006 17:01:21 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20086>

Ryan Anderson <ryan@michonline.com> writes:

> I think, in practice, that /usr/lib/sendmail will exist anywhere you hve
> something running on port 25, at least on unixy machines.  In my
> searches at an old job, that appeared to be the canonical place to call
> sendmail from, and every MTA appears to provide an appropriate binary
> there.
>
> So, I'm not overly worried about it.

exim, postfix and friends?

I used to know somebody who port-forwarded 25/tcp to central
smtp server from smaller machines in her intranet installation,
but I would say that is rare.  I am not worried about it either;
I just wanted to make sure _somebody_ thought the potential
issues through and agreed with the change the patch makes.
