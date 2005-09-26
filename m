From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Return CURL error message when object transfer fails
Date: Mon, 26 Sep 2005 14:22:56 -0700
Message-ID: <7v4q87ed73.fsf@assigned-by-dhcp.cox.net>
References: <20050926175211.GD9410@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 23:24:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK0RB-0004lj-Af
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 23:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVIZVW7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 17:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVIZVW6
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 17:22:58 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:13965 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932318AbVIZVW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 17:22:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050926212256.CITS29747.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Sep 2005 17:22:56 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20050926175211.GD9410@reactrix.com> (Nick Hengeveld's message of
	"Mon, 26 Sep 2005 10:52:11 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9336>

Nick Hengeveld <nickh@reactrix.com> writes:

> It might be better to extend this to all places that curl_easy_perform
> is called, rather than just in fetch_object.

Sounds like a good idea.  Also if you happen to know if this
option is not available in older versions of the library, it
might not hurt to guard it with "#if LIBCURL_VERSION_NUM" like
we do with other options.
