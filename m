From: Willy Tarreau <w@1wt.eu>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Thu, 21 Dec 2006 06:44:45 +0100
Message-ID: <20061221054445.GL24090@1wt.eu>
References: <4589F9B1.2020405@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422732AbWLUFoy@vger.kernel.org Thu Dec 21 06:45:37 2006
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422732AbWLUFoy@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxGkI-00027M-9p
	for glk-linux-kernel-3@gmane.org; Thu, 21 Dec 2006 06:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422732AbWLUFoy (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 21 Dec 2006 00:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422738AbWLUFoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 00:44:54 -0500
Received: from 1wt.eu ([62.212.114.60]:1618 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422732AbWLUFoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 00:44:54 -0500
To: Jeff Garzik <jeff@garzik.org>
Content-Disposition: inline
In-Reply-To: <4589F9B1.2020405@garzik.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35016>

Hi Jeff !

On Wed, Dec 20, 2006 at 10:04:17PM -0500, Jeff Garzik wrote:
> I refreshed my git intro/cookbook for kernel hackers, at 
> http://linux.yyz.us/git-howto.html

Thanks for this update, it was my most useful source of inspiration
when I started with git.

> This describes most of the commands I use in day-to-day kernel hacking. 
>  Let me know if there are glaring errors or missing key commands.

I very often use "git-format-patch -k -m" to produce individual patches
that I delay, merge in other branches, or even in other trees with
"git-am -k -3".  I believe it was Davem who suggested this a while ago,
and I agree it's very convenient to maintain a patch collection (and
sometimes to clean them up).

Also, I think that for beginners, you have not insisted enough on the
fact that they should not modify the master branch, but that they
should immediately create their own branch before any local changes.

I got caught by this when I started, and had trouble playing with the
origin branch to try to fix my mistakes.

Overall it's a good tutorial anyway.

Cheers,
Willy
