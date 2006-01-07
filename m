From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.0.7
Date: Sat, 07 Jan 2006 10:27:34 -0800
Message-ID: <7voe2nki5l.fsf@assigned-by-dhcp.cox.net>
References: <7vhd8go71t.fsf@assigned-by-dhcp.cox.net>
	<20060107.021614.94523887.yoshfuji@linux-ipv6.org>
	<7vsls0mns8.fsf@assigned-by-dhcp.cox.net>
	<7vmzi8mkdi.fsf@assigned-by-dhcp.cox.net>
	<20060107151244.762e628f.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 19:27:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvImx-0002YB-D5
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 19:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbWAGS1h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 13:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbWAGS1h
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 13:27:37 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:60413 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1752576AbWAGS1g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 13:27:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107182538.BUPG26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 13:25:38 -0500
To: Sergey Vlasov <vsu@altlinux.ru>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14267>

Sergey Vlasov <vsu@altlinux.ru> writes:

> There is also gcc 2.96, which also does not understand the C99 syntax.
> So we should use something like this instead:
>
> #if defined(__GNUC__) && (__GNUC__ < 3)
> #define FLEX_ARRAY 0
> #else
> #define FLEX_ARRAY /* empty */
> #endif
>
> (and be prepared to get complaints from users of other compilers).

Thanks.
