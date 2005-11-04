From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] v2: proxy-command support for git://
Date: Fri, 04 Nov 2005 08:50:33 -0800
Message-ID: <7v1x1wz7ae.fsf@assigned-by-dhcp.cox.net>
References: <87fyqdbuab.fsf@briny.internal.ondioline.org>
	<7v8xw5h898.fsf@assigned-by-dhcp.cox.net>
	<871x1wbgvn.fsf_-_@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 17:52:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY4m5-0005vp-O5
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 17:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVKDQug (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 11:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVKDQug
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 11:50:36 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:20201 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750708AbVKDQuf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 11:50:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051104165014.ZBEL1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Nov 2005 11:50:14 -0500
To: Paul Collins <paul@briny.ondioline.org>
In-Reply-To: <871x1wbgvn.fsf_-_@briny.internal.ondioline.org> (Paul Collins's
	message of "Fri, 04 Nov 2005 14:57:16 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11142>

Paul Collins <paul@briny.ondioline.org> writes:

> Regarding internal vs. external hosts, the proxy command can simply
> run netcat locally to internal hosts, so perhaps that is sufficient.

I was hoping this to become a bit more generalized mechanism
than that; for example using outgoing plug over HTTP Connect or
telnet proxy using tn-gw-nav.
