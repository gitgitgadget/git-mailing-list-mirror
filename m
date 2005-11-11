From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-core-arch: Missing dependency
Date: Fri, 11 Nov 2005 10:51:38 -0800
Message-ID: <7vu0ejm30l.fsf@assigned-by-dhcp.cox.net>
References: <200511111446.jABEk6QM023362@pincoya.inf.utfsm.cl>
	<7vy83vnl7r.fsf@assigned-by-dhcp.cox.net> <4374E0EF.2020801@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Chris Wright <chrisw@osdl.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 19:53:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eae0E-0001hD-VT
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 19:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbVKKSvl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 13:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbVKKSvl
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 13:51:41 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:54718 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751033AbVKKSvk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 13:51:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111185112.OGQG4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 13:51:12 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4374E0EF.2020801@op5.se> (Andreas Ericsson's message of "Fri, 11
	Nov 2005 19:20:31 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11627>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>> Horst von Brand <vonbrand@inf.utfsm.cl> writes:
>>
>>>The command git-archimport makes use of tla, but the relevant package(s) are
>>>not on the requirements
>> Thanks.  Should the fix be like this?
>>  Group:          Development/Tools
>> -Requires:       git-core = %{version}-%{release}
>> +Requires:       git-core = %{version}-%{release}, tla
>
> Just to be anal;
> Requires doesn't usually include the %release,...

Obviously both you and Chris (who did the part you are quoting
for us) know RPM spec a lot better than I do, and I see two
experts contradicting with each other.  It could have been just
an oversight, or it might have done deliberately --- I cannot
judge myself, so I punt here.  I'll remove "-%{release}" when I
hear Chris says he agrees with you.

Thanks both.
