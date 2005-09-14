From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/4] Recovery after interrupted HTTP(s) fetch
Date: Wed, 14 Sep 2005 14:53:17 -0700
Message-ID: <7vk6hjfh9u.fsf@assigned-by-dhcp.cox.net>
References: <20050914124206.GC24405@master.mivlgu.local>
	<7vpsrbjz0t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509141325310.26803@g5.osdl.org>
	<Pine.LNX.4.63.0509141641290.23242@iabervon.org>
	<Pine.LNX.4.58.0509141411510.26803@g5.osdl.org>
	<Pine.LNX.4.63.0509141722500.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Sergey Vlasov <vsu@altlinux.ru>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 23:54:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFfBz-0004uq-0O
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 23:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbVINVxU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 17:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932785AbVINVxU
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 17:53:20 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:3005 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932784AbVINVxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 17:53:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914215317.OKCH18319.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 17:53:17 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509141722500.23242@iabervon.org> (Daniel
	Barkalow's message of "Wed, 14 Sep 2005 17:24:16 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8569>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 14 Sep 2005, Linus Torvalds wrote:
>
>> Do what the pack-sending stuff does: it assumes that it has everything
>> that is reachable from the _old_ refs. It doesn't walk all the way to the 
>> root, it "just" walks far enough that it can ignore anything that was 
>> reachable from the old refs.
>
> Oh, right. Yeah, that's the obvious solution. I'll do that tonight.

Thanks.  In the meantime I have Sergey's patch in the "pu"
branch but we can replace it with your fix.
