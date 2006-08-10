From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: merge-recur status
Date: Thu, 10 Aug 2006 09:54:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608100949250.13885@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060810062914.GA5192@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Aug 10 09:55:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB5Nc-0006hN-Jc
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 09:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbWHJHy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 03:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWHJHy5
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 03:54:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:35818 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161097AbWHJHy5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 03:54:57 -0400
Received: (qmail invoked by alias); 10 Aug 2006 07:54:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 10 Aug 2006 09:54:55 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060810062914.GA5192@c165.ib.student.liu.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25161>

Hi,

On Thu, 10 Aug 2006, Fredrik Kuivinen wrote:

> I just want to say that you have made a great work with porting
> merge-recursive to C!

Thank you! I was feeling bad a little, because you were the creator of it, 
and I just bastardized it. But given my plans with MinGW, I needed to get 
rid of Python (it exists on Python, but has all kinds of path conversion 
problems).
 
> I ran merge-recur through a couple of test merges that I used to test
> merge-recursive with. It is mostly merge cases people have posted to
> the mailing list, but also some home made ones. For some of them I get
> segmentation faults, see the log below. The first three come from
> Linus kernel tree. The last one,
> 44583d380d189095fa959ec8ba87f0cb6deb15f5, is from Thomas Gleixner's
> historical Linux kernel repository. I haven't seen "fatal: fatal:
> cache changed flush_cache();" before...
> 
> Let me know if you can't reproduce some them.

I could reproduce already yesterday ;-) The patch "merge-recur: do not die 
unnecessarily" I sent out earlier gets rid of this error.

But yes, I want to test -recur with the linux kernel on the weekend.

Ciao,
Dscho

P.S.: Pavel, thanks for the "A dedicated programmer with good C and Python 
skills could rewrite git-merge-recursive.py in C in 2 days, I believe. Add 
a few days of bug fixing, of course." underestimation. I do not know if I 
had started fiddling with it if I had known how involved it is.
