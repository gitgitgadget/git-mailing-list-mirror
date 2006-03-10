From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: git-rev-list bug?
Date: Fri, 10 Mar 2006 11:01:55 +0000
Message-ID: <tnx64mmpnq4.fsf@arm.com>
References: <b0943d9e0603080819i227c637fo@mail.gmail.com>
	<7vacc0iten.fsf@assigned-by-dhcp.cox.net>
	<7vmzfy1zjb.fsf@assigned-by-dhcp.cox.net>
	<7virqmzlhb.fsf@assigned-by-dhcp.cox.net>
	<7v4q26zklx.fsf@assigned-by-dhcp.cox.net>
	<7vslpqy4u7.fsf@assigned-by-dhcp.cox.net>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 12:02:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHfO5-0007LQ-9Z
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 12:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbWCJLCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 06:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWCJLCW
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 06:02:22 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:7845 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1752223AbWCJLCV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 06:02:21 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k2AB21uc019092;
	Fri, 10 Mar 2006 11:02:02 GMT
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 10 Mar 2006 11:02:01 +0000
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslpqy4u7.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 10 Mar 2006 02:25:04 -0800")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 10 Mar 2006 11:02:01.0803 (UTC) FILETIME=[0F0A61B0:01C64432]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17469>

Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
>
>> It however has a side effect -- uninteresting commits were never
>> parsed here, but now they get parsed.  I am not sure if there
>> are correctness implications...
>
> Actually there is.  If a merge with an uninteresting side branch
> was the only thing that brought changes to paths we are
> interested in, we do not want TREE_SAME logic to remove other
> parents (i.e. the branches we are interested in) from the merge
> commit.  
>
> So we would need a combination of both, something like this?

I can confirm that it "stg patches" works fine with this patch for
git-rev-list.

Thanks.

-- 
Catalin
