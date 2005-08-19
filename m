From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] Allow file removal when "git commit --all" is used.
Date: Thu, 18 Aug 2005 18:04:40 -0700
Message-ID: <7vll2yenyv.fsf@assigned-by-dhcp.cox.net>
References: <7v64u3k74m.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508181248110.30218@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 03:05:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5vJQ-0002ft-LJ
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 03:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVHSBEn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 21:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbVHSBEn
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 21:04:43 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:19666 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964775AbVHSBEn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 21:04:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050819010443.VAZE7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 Aug 2005 21:04:43 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The patch is for people who thinks the user who uses the "--all"
>> flag deserves the danger that comes with the convenience.
>> 
>> Comments?
>
> This is a sane default behaviour. Maybe introduce yet another flag 
> "--no-remove", which says that removes should not be performed? But then, 
> "--all" is mostly used by lazy people, who probably expect the removes to 
> take place.

Well, let's refrain from using that word; I am one of the "lazy"
people, but I do that on purpose and from principle, not from
lazyness.  http://members.cox.net/junkio/per-file-commit.txt.
