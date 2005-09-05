From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Update git-send-email-script with --compose
Date: Mon, 05 Sep 2005 13:38:01 -0700
Message-ID: <7vslwj2qty.fsf@assigned-by-dhcp.cox.net>
References: <11258971871874-git-send-email-ryan@michonline.com>
	<46a038f905090504166246dc0a@mail.gmail.com>
	<20050905153705.GD5335@mythryan2.michonline.com>
	<7vll2b4ake.fsf@assigned-by-dhcp.cox.net>
	<46a038f90509051306212d4e93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 22:39:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECNjb-0004UH-32
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 22:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVIEUiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 16:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVIEUiE
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 16:38:04 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:17840 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932281AbVIEUiD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2005 16:38:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050905203801.PEKE6784.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Sep 2005 16:38:01 -0400
To: martin.langhoff@gmail.com
In-Reply-To: <46a038f90509051306212d4e93@mail.gmail.com> (Martin Langhoff's
	message of "Tue, 6 Sep 2005 08:06:50 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8115>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Fair enough -- blame it on my primitive approach of only having 2
> working repositories, and having some patches in them that I'm not
> pushing upstream. Exporting to mbox would mean that I have to edit the
> mbox file to remove the patches I don't intend to publish.
>
> ... and on my naive reading of git-send-email documentation -- it
> doesn't mention mbox format at all, so I assumed it would expect one
> patch per file.

Not really; --mbox output is one-file-per-patch and it is up to
you which ones to pick and concatenate them in what order, if you
want them in a single file.
