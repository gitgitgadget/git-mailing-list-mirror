From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] gitweb: export options
Date: Sun, 17 Sep 2006 11:07:10 +0200
Message-ID: <20060917090710.GA18153@moooo.ath.cx>
References: <20060916192750.GA27008@moooo.ath.cx> <20060916223027.GA32679@moooo.ath.cx> <20060916223101.GB32679@moooo.ath.cx> <7v64fm7u2q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 11:07:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOscV-00076h-5M
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 11:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWIQJHP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 05:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWIQJHP
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 05:07:15 -0400
Received: from moooo.ath.cx ([85.116.203.178]:30598 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932380AbWIQJHO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 05:07:14 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v64fm7u2q.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27172>

Junio C Hamano <junkio@cox.net> wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> Is this replacement for your earlier two patches?
Yes, it is, they did not apply on the current master. (I fetched the
new heads, had a short look at the log but forgot to update my working
heads :) ).

>         [PATCH] gitweb: export-ok option
>         [PATCH] gitweb: option 'strict export'
> 
> What's the difference between this and the previous two?
Now I decided to split it in another way: first remove the
no-such-directory error and then implement the two new features. The
patches should be equivalent to those before.
