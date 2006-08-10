From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git, and announcing GIT 1.4.2-rc4
Date: Thu, 10 Aug 2006 01:10:38 -0700
Message-ID: <7vodutvwn5.fsf@assigned-by-dhcp.cox.net>
References: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0608100957050.13885@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 10:10:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB5cs-00011m-AC
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 10:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbWHJIKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 04:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbWHJIKl
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 04:10:41 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:17795 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1161127AbWHJIKk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 04:10:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060810081039.ZQRG29796.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Aug 2006 04:10:39 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608100957050.13885@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 10 Aug 2006 10:05:54 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25167>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>   - pack-objects can copy a non-delta representation of a object
>>     with the new style header straight into packs.
>>...
>>   * Hopefully not too long after 1.4.2:
>>   - New style loose objects, which use the same header format as
>>     in-pack objects, can be copied straight into packs when not
>>     deltified.  I am hoping that we can make the new-style loose
>>     objects the default in 10 to 12 weeks to give everybody time
>>     to update to 1.4 series.
>
> These are the same, no?

Yeah; I meant to say that we need to wait a while before making
the new style loose object the default, since people with older
git would not be able to use them.
