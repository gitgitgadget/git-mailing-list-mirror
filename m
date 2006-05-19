From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow pickaxe to be used via git log.
Date: Thu, 18 May 2006 20:05:01 -0700
Message-ID: <7vk68ilnoi.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP04945C92FB14DA65AB1AC7AEA70@CEZ.ICE>
	<7v4pzmn32g.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP07581788E7BAAC19B2A159AEA70@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 19 05:05:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgvIb-0003wC-SV
	for gcvg-git@gmane.org; Fri, 19 May 2006 05:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWESDFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 23:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWESDFE
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 23:05:04 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56479 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932201AbWESDFC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 23:05:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060519030502.SAUW15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 23:05:02 -0400
To: git@vger.kernel.org
In-Reply-To: <BAYC1-PASMTP07581788E7BAAC19B2A159AEA70@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Thu, 18 May 2006 22:56:12 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20319>

Sean <seanlkml@sympatico.ca> writes:

> Is there any place that depends on the ability to specify both a pickaxe
> string _and_ always_show_header?  If not, it's hard to see how this patch
> could break anything.

User's scripts.  The point is the set of arguments rev-list as
the lowest level machinery should not be modified by an
arbitrary policy decision that happens to suit "git log" usage.
