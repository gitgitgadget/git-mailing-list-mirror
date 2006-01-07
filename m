From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.0.7
Date: Sat, 07 Jan 2006 00:43:03 -0800
Message-ID: <7vsls0mns8.fsf@assigned-by-dhcp.cox.net>
References: <7vhd8go71t.fsf@assigned-by-dhcp.cox.net>
	<20060107.021614.94523887.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 09:43:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev9fJ-000828-7P
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 09:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWAGInG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 03:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbWAGInG
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 03:43:06 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:35791 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030362AbWAGInE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 03:43:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107084152.ZDVS20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 03:41:52 -0500
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14245>

[Yoshifuji-san, you will see this message twice but everybody
else would not --- I removed your Japanese name from the body of
the message, to pass mail filter at kernel.org]

YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org> writes:

> Allow compilation w/ gcc 2.95.4.
> (Or, it is okay to replace path[] with path[0].)

This is unfortunate; path[] is the correct C (and path[0] is
not---it is an gcc extension), and we have quite a few of them.
Last time somebody wanted to change all of them to path[] we
found out gcc 2.95 did not like it, and ended up doing path[0]
form.  So I'd say change it to path[0] for now.
