From: Junio C Hamano <junkio@cox.net>
Subject: Re: Ship our own copy of subprocess.py
Date: Mon, 19 Sep 2005 23:36:15 -0700
Message-ID: <7vll1s6yao.fsf@assigned-by-dhcp.cox.net>
References: <432F0C66.7060402@zytor.com>
	<20050919200222.GA11322@c165.ib.student.liu.se>
	<7vslw0lqvd.fsf@assigned-by-dhcp.cox.net> <432F26E9.9090707@zytor.com>
	<7v7jdclpme.fsf@assigned-by-dhcp.cox.net> <432F3253.3070201@zytor.com>
	<20050919231704.GA19276@unpythonic.net> <432F48C7.8070405@zytor.com>
	<7v8xxsebsc.fsf@assigned-by-dhcp.cox.net>
	<7vfys0cpyj.fsf_-_@assigned-by-dhcp.cox.net>
	<20050920061413.GP8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 08:37:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHbjq-0007uC-Fq
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 08:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743AbVITGgU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 02:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbVITGgU
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 02:36:20 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:27837 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932743AbVITGgT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 02:36:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050920063617.CANG23678.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Sep 2005 02:36:17 -0400
To: Chris Wright <chrisw@osdl.org>
In-Reply-To: <20050920061413.GP8041@shell0.pdx.osdl.net> (Chris Wright's
	message of "Mon, 19 Sep 2005 23:14:13 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8983>

Chris Wright <chrisw@osdl.org> writes:

> Sorry I don't think this one will work.  It's not going to install
> compat/subprocess.py, and if it did, I don't think it'd be able to import
> (how will it find subprocess.py?).

My intent can be found out if you do this:

    $ make
    $ diff -u git-merge-recursive.py git-merge-recursive
    $ grep -C3 GIT_PYTHON_ Makefile
