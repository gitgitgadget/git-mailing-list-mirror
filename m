From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Return CURL error message when object transfer fails
Date: Mon, 26 Sep 2005 22:51:38 -0700
Message-ID: <7v3bnr3vo5.fsf@assigned-by-dhcp.cox.net>
References: <20050926175211.GD9410@reactrix.com>
	<7v4q87ed73.fsf@assigned-by-dhcp.cox.net>
	<20050927001241.GB15615@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 07:51:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK8NV-0007Vy-Tx
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 07:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVI0Fvm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 01:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVI0Fvm
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 01:51:42 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:11252 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964821AbVI0Fvm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 01:51:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927055140.UZBC19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 01:51:40 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20050927001241.GB15615@reactrix.com> (Nick Hengeveld's message
	of "Mon, 26 Sep 2005 17:12:41 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9371>

Nick Hengeveld <nickh@reactrix.com> writes:

> I don't see any indication that CURLOPT_ERRORBUFFER is a new feature.
> The curl_easy_strerror() function is new as of 7.12.0 which is why
> I elected to use the CURLOPT_ERRORBUFFER option instead.

If that is the case, I'll take your patch verbatim.  Thanks.

I just needed to get the feel that you did things that way,
knowing what to and what not to worry about; I am no cURL
expert.
