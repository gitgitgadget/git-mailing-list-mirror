From: Junio Hamano <junio@twinsun.com>
Subject: Re: rsync update appears broken now
Date: Thu, 20 Oct 2005 16:37:50 -0700
Message-ID: <7vek6f220h.fsf@arte.twinsun.com>
References: <86vezs9wy9.fsf@blue.stonehenge.com>
	<81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com>
	<Pine.LNX.4.64.0510201038320.3369@g5.osdl.org>
	<loom.20051020T220751-355@post.gmane.org>
	<Pine.LNX.4.64.0510201432260.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 01:39:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESjzA-0000pr-RX
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 01:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVJTXiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 19:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbVJTXiJ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 19:38:09 -0400
Received: from alcor.twinsun.com ([198.147.65.9]:13446 "EHLO alcor.twinsun.com")
	by vger.kernel.org with ESMTP id S932552AbVJTXiI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 19:38:08 -0400
Received: from sic.twinsun.com ([192.54.239.17])
	by alcor.twinsun.com (8.12.9/8.12.9) with ESMTP id j9KNbn3x010253;
	Thu, 20 Oct 2005 16:37:49 -0700 (PDT)
Received: from pete.twinsun.com (pete.twinsun.com [192.54.239.43])
	by sic.twinsun.com (8.11.7p1+Sun/8.11.7) with SMTP id j9KNbnc09946;
	Thu, 20 Oct 2005 16:37:49 -0700 (PDT)
Received: from sic.twinsun.com ([192.54.239.17])
 by pete.twinsun.com (SMSSMTP 4.1.0.19) with SMTP id M2005102016374804760
 ; Thu, 20 Oct 2005 16:37:48 -0700
Received: from arte (arte.twinsun.com [192.54.239.5])
	by sic.twinsun.com (8.11.7p1+Sun/8.11.7) with SMTP id j9KNbmc09942;
	Thu, 20 Oct 2005 16:37:48 -0700 (PDT)
Received: by arte (sSMTP sendmail emulation); Thu, 20 Oct 2005 16:37:50 -0700
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510201432260.10477@g5.osdl.org> (Linus
 Torvalds's message of "Thu, 20 Oct 2005 14:32:44 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10386>

Linus Torvalds <torvalds@osdl.org> writes:

> What you _must_ do to fix things up is that _you_ merge your current head 
> with your old head, and then you push out the result.

Yes.  That is what I will do when able (not right now).

I posted a workaround because I am at work and I do not have
access to kernel.org machine from here, and I did not pull
yesterday at work so I do not have an access to that lost side
branch until later today (I think I still have it in my private
repo, either on my home machine or my ~/git on hera).

> At that point:
>
>>                -----(A) head merlyn and everybody
>>              /          pulled from kernel.org previously
>>   --- common ------------------------------------(B) head rebased and pushed
>>                                                      out by mistake

Mind telling me the (A) commit ID if you know it?
