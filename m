From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH] diff --check: use colour
Date: Thu, 25 Jan 2007 18:06:51 -0600
Message-ID: <17849.17947.645022.282882@lisa.zopyra.com>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vr6tkdnee.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701251015390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vk5za925w.fsf@assigned-by-dhcp.cox.net>
	<17849.13327.527531.262943@lisa.zopyra.com>
	<Pine.LNX.4.63.0701260034320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 26 01:07:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAEcn-0006n8-6E
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 01:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030656AbXAZAHO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 19:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030659AbXAZAHO
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 19:07:14 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60677 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030656AbXAZAHN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 19:07:13 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0Q07Bc02645;
	Thu, 25 Jan 2007 18:07:11 -0600
In-Reply-To: <Pine.LNX.4.63.0701260034320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37785>

On Friday, January 26, 2007 at 00:41:42 (+0100) Johannes Schindelin writes:
>...
>The easiest way to find out what it does is to execute:
>
>	git log -S--check diff.c

Hmm, using 1.5.0-rc2, I created a test repo, and did this:

echo foo > foo
git add foo
git commit -a -m foo
echo bar > foo
git commit -a -m bar
git log -S--check foo

and nothing happened.

I did

git log -S --check foo

and the thing went off into outer space.  Now at over 2 1/2 minutes of
CPU time on my 2 Ghz Opteron box...

Is it really '-S--check'?


Bill
