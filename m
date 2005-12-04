From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] A few more options for git-cat-file
Date: Sat, 03 Dec 2005 22:17:28 -0800
Message-ID: <7vu0dptmh3.fsf@assigned-by-dhcp.cox.net>
References: <43924D1C.8070306@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 04 07:18:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EinBn-0000D4-PE
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 07:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVLDGRb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 01:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVLDGRa
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 01:17:30 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:64143 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932203AbVLDGRa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2005 01:17:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051204061646.UGVE6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Dec 2005 01:16:46 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13178>

"H. Peter Anvin" <hpa@zytor.com> writes:

> This adds the following options to git-cat-file:
>
> -n, to get the canonical name of a resource.  This is for one thing 
> useful in tagging scripts.

Isn't "git-rev-parse --verify" good enough?

> -e, to test for the existence of a file.

This might be useful and cleaner than "cat-file -s >/dev/null"
but marginally so.  While reading the whole file and discarding
that to /dev/null is wasteful and would go against tastes of
many people, -t and -s flags do not need to read the whole thing
and not so expensive.
