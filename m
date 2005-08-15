From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add -k kill keyword expansion option to git-cvsimport
Date: Mon, 15 Aug 2005 00:12:02 -0700
Message-ID: <7vk6in65dp.fsf@assigned-by-dhcp.cox.net>
References: <46a038f9050814235140877be7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 09:12:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4Z8h-0003TS-Ts
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 09:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVHOHME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 03:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVHOHME
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 03:12:04 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:29872 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932135AbVHOHME (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 03:12:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050815071201.VCCW19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 03:12:01 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f9050814235140877be7@mail.gmail.com> (Martin Langhoff's
	message of "Mon, 15 Aug 2005 18:51:39 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> writes:

> [PATCH] Add -k kill keyword expansion option to git-cvsimport
>
> Early versions of git-cvsimport defaulted to using preexisting keyword
> expansion settings. This change preserves compatibility with existing cvs
> imports and allows new repository migrations to kill keyword expansion.
>
> Should improve our chances of detecting merges and reduce imported
> repository size.

The discussion between you and Linus since you brought this up
has kept me wondering if -ko is the only thing people may want
to do, or sometimes -kk or even -kb or -kv make sense for some
others, in which case instead of a -k option that does not allow
anything but -ko, making it take an optional single letter
o/k/b/v might might more sense.  A single -k defaulting to -ko
is fine by me if you did so, because I think that is the most
useful and usual mode of operation while converting to GIT
repository.

Thoughts?
