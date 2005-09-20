From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git-init-db creating crap directories (zeroth try)
Date: Mon, 19 Sep 2005 19:04:20 -0700
Message-ID: <7v1x3kebq3.fsf@assigned-by-dhcp.cox.net>
References: <200509172141.31591.dtor_core@ameritech.net>
	<432F0D1B.60303@zytor.com> <20050919194445.GD18320@pasky.or.cz>
	<432F46BE.5000406@zytor.com> <20050919234030.GI18320@pasky.or.cz>
	<432F50BC.5000304@zytor.com> <20050920000731.GJ18320@pasky.or.cz>
	<432F5345.3020303@zytor.com> <20050920001949.GL18320@pasky.or.cz>
	<432F5B07.2060803@zytor.com> <20050920015154.GA25115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 04:05:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXV1-0003R5-2i
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 04:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVITCEo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 22:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbVITCEo
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 22:04:44 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:59063 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964835AbVITCEo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 22:04:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050920020422.GXUB11628.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Sep 2005 22:04:22 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050920015154.GA25115@pasky.or.cz> (Petr Baudis's message of
	"Tue, 20 Sep 2005 03:51:54 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8951>

Petr Baudis <pasky@suse.cz> writes:

>> >Oops, sorry. That's what you get when you want to make things marginally
>> >better. ;-) We indeed want to pass copy_templates_1() the trailing slash
>> >as well.

Original patch from you is the right one.  Thanks.
