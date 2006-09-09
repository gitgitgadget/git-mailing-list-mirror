From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] git-archive: wire up TAR format.
Date: Sat, 09 Sep 2006 12:42:07 -0700
Message-ID: <7v8xksx1ww.fsf@assigned-by-dhcp.cox.net>
References: <450019C3.4030001@innova-card.com>
	<11576347252834-git-send-email-vagabon.xyz@gmail.com>
	<4501D0CF.70306@lsrfire.ath.cx>
	<7vlkouf32i.fsf@assigned-by-dhcp.cox.net>
	<7vk64derfd.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80609090810t6fdab535r761636e65205a0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 21:41:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM8i5-0003ak-TC
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 21:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWIITll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 15:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWIITll
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 15:41:41 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:21448 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964812AbWIITlk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 15:41:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060909194140.VIG18458.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Sat, 9 Sep 2006 15:41:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id LKhW1V00B1kojtg0000000
	Sat, 09 Sep 2006 15:41:31 -0400
To: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26762>

"Franck Bui-Huu" <vagabon.xyz@gmail.com> writes:

> Almost Acked by me, except you've missed some Rene's comments. And
> more important I fixed an "uninitialized variable" bug. See patch
> below.

Gaah, I swear I fixed all of these at one time in my tree but
somehow forgot to apply the fix-up patch while cleaning it up.

Big thanks for eyeballing.
