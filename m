From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Tie it all together: "git log"
Date: Wed, 01 Mar 2006 01:02:48 -0800
Message-ID: <7vpsl6lepz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602281115110.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602281126340.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602281251390.22647@g5.osdl.org>
	<7vr75nm8cl.fsf@assigned-by-dhcp.cox.net>
	<46a038f90602281538m90c4d04pbb6f277e3bec89e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 10:03:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FENEW-0000on-8L
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 10:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWCAJCv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 04:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWCAJCv
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 04:02:51 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63685 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964819AbWCAJCu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 04:02:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060301090118.JOIT20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Mar 2006 04:01:18 -0500
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90602281538m90c4d04pbb6f277e3bec89e8@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 1 Mar 2006 12:38:53 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16968>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 3/1/06, Junio C Hamano <junkio@cox.net> wrote:
>> I would say we should just rip merge-order out.  Who uses it,
>> and why does it not work with topo-order, again?
>
> IIRC archimport uses it, but there's no reason why topo-order wouldn't work.

Thanks.  I'll push out a few patches on top of Linus' series,
with s/merge-order/topo-order/ on archimport.
