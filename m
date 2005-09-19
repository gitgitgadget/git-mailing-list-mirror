From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why does git-core 0.99.7 require python 2.4?
Date: Mon, 19 Sep 2005 14:22:17 -0700
Message-ID: <7v7jdclpme.fsf@assigned-by-dhcp.cox.net>
References: <432F0C66.7060402@zytor.com>
	<20050919200222.GA11322@c165.ib.student.liu.se>
	<7vslw0lqvd.fsf@assigned-by-dhcp.cox.net> <432F26E9.9090707@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 19 23:23:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHT67-0000he-KM
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 23:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbVISVWp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 17:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbVISVWp
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 17:22:45 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:63215 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932695AbVISVWo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 17:22:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050919212217.LDTX25410.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Sep 2005 17:22:17 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <432F26E9.9090707@zytor.com> (H. Peter Anvin's message of "Mon,
	19 Sep 2005 14:00:25 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8908>

"H. Peter Anvin" <hpa@zytor.com> writes:

> My suggestion would be to fork off the recursive merge into a separate 
> binary package which can have the python >= 2.4 requirement (unless 
> Fredrik just fixes it.)

It sounds like the right thing to do, not that I know much about
how RPM world deals with situations like this (aside from what I
learnt from the list).  If we go this route probably we should
the same for gitk and git-send-email as well?
