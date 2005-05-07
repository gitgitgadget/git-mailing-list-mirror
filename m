From: Junio C Hamano <junkio@cox.net>
Subject: Re: Broken adding of cache entries
Date: Sat, 07 May 2005 11:42:15 -0700
Message-ID: <7vu0leaneg.fsf@assigned-by-dhcp.cox.net>
References: <1115408460.32065.37.camel@localhost.localdomain>
	<20050506231447.GG32629@pasky.ji.cz>
	<1115421933.32065.111.camel@localhost.localdomain>
	<20050506233003.GJ32629@pasky.ji.cz>
	<1115423450.32065.138.camel@localhost.localdomain>
	<20050507001409.GP32629@pasky.ji.cz>
	<1115431767.32065.182.camel@localhost.localdomain>
	<20050507152849.GD9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Sat May 07 20:35:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUU97-0002yw-Gj
	for gcvg-git@gmane.org; Sat, 07 May 2005 20:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVEGSmT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 14:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbVEGSmT
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 14:42:19 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:45971 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262729AbVEGSmR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 14:42:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050507184216.GEVP19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 May 2005 14:42:16 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050507152849.GD9495@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 7 May 2005 17:28:50 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'll have a look later but as I recall the code (I'm writing
this without looking at the specific code, just your patch
hunk), the flag comparison there is not about blob vs tree modes
but for "stages"; it must answer that two entries with the same
name but in different merge stages are different.


