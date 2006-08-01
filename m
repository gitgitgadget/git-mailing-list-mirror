From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Set User-Agent string in shell scripts used for fetching
Date: Tue, 01 Aug 2006 02:51:21 -0700
Message-ID: <7vmzao238m.fsf@assigned-by-dhcp.cox.net>
References: <200607292239.11034.jnareb@gmail.com>
	<7vd5bk3mqo.fsf@assigned-by-dhcp.cox.net>
	<200608011134.52006.jnareb@gmail.com>
	<200608011136.54698.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Aug 01 11:51:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7quL-0004UG-9I
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 11:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422773AbWHAJvW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 05:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422777AbWHAJvW
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 05:51:22 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:29895 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1422773AbWHAJvW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 05:51:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060801095121.FBZ2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Aug 2006 05:51:21 -0400
To: git@vger.kernel.org
In-Reply-To: <200608011136.54698.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 1 Aug 2006 11:36:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24588>

Jakub Narebski <jnareb@gmail.com> writes:

>> "Why?", meaning if we deliberately do so for some good reason?
>> 
>> There isn't.
>> 
>> git-http-fetch uses its own User-Agent string, but the shell
>> script wrappers that use curl executable do not bother setting
>> customized User-Agent string; that is why.
>
> So there :-)

Who said we want to?  Actually I explicitly said we do not
bother ;-).
