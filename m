From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] v2: proxy-command support for git://
Date: Fri, 04 Nov 2005 10:57:13 -0800
Message-ID: <7v7jbow8ae.fsf@assigned-by-dhcp.cox.net>
References: <87fyqdbuab.fsf@briny.internal.ondioline.org>
	<7v8xw5h898.fsf@assigned-by-dhcp.cox.net>
	<871x1wbgvn.fsf_-_@briny.internal.ondioline.org>
	<7v1x1wz7ae.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 19:58:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY6kY-0001Tp-8K
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 19:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVKDS5P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 13:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKDS5P
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 13:57:15 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:25853 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750807AbVKDS5O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 13:57:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051104185655.PLOH16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Nov 2005 13:56:55 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x1wz7ae.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 04 Nov 2005 08:50:33 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11152>

Junio C Hamano <junkio@cox.net> writes:

> Paul Collins <paul@briny.ondioline.org> writes:
>
>> Regarding internal vs. external hosts, the proxy command can simply
>> run netcat locally to internal hosts, so perhaps that is sufficient.
>
> I was hoping this to become a bit more generalized mechanism
> than that; for example using outgoing plug over HTTP Connect or
> telnet proxy using tn-gw-nav.

I realize the above does not really convey my real objection.

Your "ssh to the proxy/firewall host and run netcat to the
destination" would not work for me to reach the internal hosts
at all (while it would work for external ones), because my
firewall does not know names of our internal hosts (the same for
using tn-gw-nav to cross http or telnet proxy).
