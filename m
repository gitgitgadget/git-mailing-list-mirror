From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rev-{list,parse}: allow -<n> as shorthand for --max-count=<n>
Date: Tue, 24 Jan 2006 00:02:30 -0800
Message-ID: <7vd5iicauh.fsf@assigned-by-dhcp.cox.net>
References: <20060124072946.GA9468@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 24 09:02:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1J8P-0001y9-Ry
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 09:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWAXICf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 03:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWAXICf
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 03:02:35 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:37017 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030219AbWAXICe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 03:02:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060124080029.UAGW17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 Jan 2006 03:00:29 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060124072946.GA9468@Muzzle> (Eric Wong's message of "Mon, 23
	Jan 2006 23:29:46 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15097>

Eric Wong <normalperson@yhbt.net> writes:

> Some versions of head(1) and tail(1) allow their line limits to be
> parsed this way.  I find --max-count to be a commonly used option,
> and also similar in spirit to head/tail, so I decided to make life
> easier on my worn out (and lazy :) fingers with this patch.

As an old timer, I personally am very used to "head -4", but
also have been training my fingers to say "head -n 4" for the
past few years, because the former is not POSIXly correct.

At the same time, I agree that --max-count *was* a mistake.  We
should maybe say "-n <n>" perhaps?
