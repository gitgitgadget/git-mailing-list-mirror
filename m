From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rev-list: make --dense the default (and introduce "--sparse")
Date: Wed, 26 Oct 2005 13:03:53 -0700
Message-ID: <7vvezkcafq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510251459070.10477@g5.osdl.org>
	<Pine.LNX.4.64.0510251525540.10477@g5.osdl.org>
	<7vwtk08wnx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510260757350.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 26 22:06:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUrVI-0002Lz-9J
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 22:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbVJZUED (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 16:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVJZUED
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 16:04:03 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:46766 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964910AbVJZUEB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 16:04:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051026200323.CEGQ29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Oct 2005 16:03:23 -0400
To: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510260757350.10477@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 26 Oct 2005 08:18:13 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10688>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 26 Oct 2005, Junio C Hamano wrote:
>> 
>> I have not looked closely into what exactly, but the fourth
>> thing this does might be to break git-send-pack.
>
> Ack. And I see why.
>
>
> This patch (on top of the original one) does exactly that.

Thanks, this fixes it.
