From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Need to set PAGER in tests
Date: Wed, 10 Aug 2005 22:50:46 -0700
Message-ID: <7v3bphowcp.fsf@assigned-by-dhcp.cox.net>
References: <1123726201.18644.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 07:51:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E35xr-0007QH-Gc
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 07:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVHKFut (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 01:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVHKFus
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 01:50:48 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:32509 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932241AbVHKFus (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 01:50:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050811055046.KOU16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 11 Aug 2005 01:50:46 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1123726201.18644.10.camel@dv> (Pavel Roskin's message of "Wed,
	10 Aug 2005 22:10:01 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pavel Roskin <proski@gnu.org> writes:

> "t5400-send-pack.sh --verbose" stops waiting for user input.  It happens
> because "git log" uses less for output now.  To prevent this, PAGER
> should be set to cat.

Good catch, thanks.

I did not notice this before, because I always work in Emacs
compilation buffer, setting PAGER to cat and EDITOR to
emacsclient.
