From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Clean up file descriptors when calling hooks.
Date: Wed, 07 Dec 2005 21:40:28 -0800
Message-ID: <7vwtigkuyb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0512072052560.25300@iabervon.org>
	<7vvey0mik7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512080006460.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Dec 08 06:42:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkEWA-0006o1-Eg
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 06:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbVLHFkb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 00:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVLHFkb
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 00:40:31 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:17799 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965072AbVLHFka (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 00:40:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051208053955.LAGP3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Dec 2005 00:39:55 -0500
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0512080006460.25300@iabervon.org> (Daniel
	Barkalow's message of "Thu, 8 Dec 2005 00:33:57 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13358>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 7 Dec 2005, Junio C Hamano wrote:
>
>> A quick question.  I understand "not connected to the pushing
>> connection" is desirable, but is there a reason you chose to
>> leave them open to /dev/null, not close()d?
>
> Wouldn't that make programs that assume that stdout (or stdin) is still 
> valid get errors?

right both of you are.  applied and pushed out.  thanks.
