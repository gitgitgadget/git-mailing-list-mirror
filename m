From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] v2: proxy-command support for git://
Date: Fri, 04 Nov 2005 13:42:28 -0800
Message-ID: <7v3bmct7i3.fsf@assigned-by-dhcp.cox.net>
References: <87fyqdbuab.fsf@briny.internal.ondioline.org>
	<7v8xw5h898.fsf@assigned-by-dhcp.cox.net>
	<871x1wbgvn.fsf_-_@briny.internal.ondioline.org>
	<7v1x1wz7ae.fsf@assigned-by-dhcp.cox.net>
	<7v7jbow8ae.fsf@assigned-by-dhcp.cox.net>
	<87ll049l8a.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 22:43:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY9KU-00065W-M7
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 22:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVKDVmb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 16:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbVKDVmb
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 16:42:31 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:28832 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750937AbVKDVma (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 16:42:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051104214207.SBDO4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Nov 2005 16:42:07 -0500
To: Paul Collins <paul@briny.ondioline.org>
In-Reply-To: <87ll049l8a.fsf@briny.internal.ondioline.org> (Paul Collins's
	message of "Fri, 04 Nov 2005 21:06:13 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11162>

Paul Collins <paul@briny.ondioline.org> writes:

> But perhaps I do not really understand your objection.

No, I think you are getting it right.

I just wanted to avoid using the proxy script for some hosts,
depending on where you are going.  Obviously you can teach the
proxy script to do passthru for some hosts like you did in your
message.  The only difference is where the configuration is
specified.  I wanted it to be in the git configuration file
(i.e. using different proxy script or no script, depending on
the host).  Your example has that configuration wired in the
single script that is always called regardless of the
destination, and the script itself switches how it proxies,
depending on where it is going, perhaps using its own
configuration file or hardcoding.
