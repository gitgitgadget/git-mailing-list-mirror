From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.0.0b quickfix
Date: Thu, 22 Dec 2005 11:22:14 -0800
Message-ID: <7vk6dxlyxl.fsf@assigned-by-dhcp.cox.net>
References: <7vpsnq3wrg.fsf@assigned-by-dhcp.cox.net>
	<43A9E15F.1060808@zytor.com> <1135244363.10035.185.camel@gaston>
	<Pine.LNX.4.64.0512220945450.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 20:22:37 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpW1G-0000No-2e
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 20:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbVLVTWR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 14:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbVLVTWQ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 14:22:16 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:17855 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030260AbVLVTWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 14:22:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051222192044.FJDW17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Dec 2005 14:20:44 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13962>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 22 Dec 2005, Benjamin Herrenschmidt wrote:
>> > 
>> > Wouldn't it make more sense for the maintenance release to be 1.0.1?
>> 
>> Seconded. letters in versions are bad. With my MacOS background, for me,
>> "b" means "beta" :)
>
> FWIW, thirded. The kernel used to use letters too, and it's cute, but just 
> using multiple levels of release numbers is much more common.

FWIW, fourthed ;-)

commit c894168631e4b7da66ed3993a4c92380d38599a8
Author: Junio C Hamano <junkio@cox.net>
Date:   Wed Dec 21 22:33:37 2005 -0800

    Versioning scheme changes.
    
    HPA suggests it is simply silly to imitate Linux versioning
    scheme where the leading "2" does not mean anything anymore, and
    I tend to agree.
    
    The first feature release after 1.0.0 will be 1.1.0, and the
    development path leading to 1.1.0 will carry 1.0.GIT as the
    version number from now on.  Similarly, the third maintenance
    release that follows 1.0.0 will not be 1.0.0c as planned, but
    will be called 1.0.3.  The "maint" branch will merge in fixes
    and immediately tagged, so there is no need for 1.0.2.GIT that
    is in between 1.0.2 (aka 1.0.0b) and 1.0.3.
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>
