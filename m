From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] t7001: add test for git-mv dir1 dir2/
Date: Wed, 26 Jul 2006 12:31:49 -0700
Message-ID: <7vmzawqi1m.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<9e4733910607261050k5f8d8d5dke5ded3a806b46f21@mail.gmail.com>
	<7virlkrzr4.fsf@assigned-by-dhcp.cox.net>
	<9e4733910607261131q195defa7vbedd72cb0b938ba3@mail.gmail.com>
	<7vejw8ry5f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 26 21:32:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5p6t-0001vr-EQ
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 21:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWGZTbx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 15:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWGZTbx
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 15:31:53 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:16275 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932236AbWGZTbw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 15:31:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060726193151.UPTG2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Jul 2006 15:31:51 -0400
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <7vejw8ry5f.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 26 Jul 2006 11:58:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24241>

Junio C Hamano <junkio@cox.net> writes:

> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
>> git diff HEAD makes a much longer patch that deltas out the existing
>> files and delta in the new file.
>>
>> It's applying patches in the extended git format that fails.
>
> Thanks.

... and it turns out that "git apply" (with or without --index)
groks it just fine.  I suspect the fix is quite recent (not in
v1.4.2-rc1 but in v1.4.2-rc2).
