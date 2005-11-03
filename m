From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] RFC: proxy-command support for git://
Date: Thu, 03 Nov 2005 13:31:23 -0800
Message-ID: <7vsludbeqc.fsf@assigned-by-dhcp.cox.net>
References: <87fyqdbuab.fsf@briny.internal.ondioline.org>
	<7v8xw5h898.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511031117290.27915@g5.osdl.org>
	<20051103204137.GA1343@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 22:31:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXmgD-0006y2-Nr
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 22:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbVKCVb0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 16:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030498AbVKCVbZ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 16:31:25 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:21901 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030494AbVKCVbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 16:31:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051103213124.DSSQ9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 16:31:24 -0500
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20051103204137.GA1343@hpsvcnb.fc.hp.com> (Carl Baldwin's message
	of "Thu, 3 Nov 2005 13:41:37 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11098>

Carl Baldwin <cnb@fc.hp.com> writes:

> Another way to do this would be using the ~/.ssh/config file.  It would
> look something like this:

Maybe I am slow today, but wouldn't this require the other end
(i.e. remote repo) to let you ssh in?

I think the point of the original patch was to give proxied
connection to git:// transport, not git over ssh.
