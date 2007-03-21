From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH] contrib/continuous: a continuous integration build manager
Date: Tue, 20 Mar 2007 20:27:42 -0600
Message-ID: <17920.38942.364466.642979@lisa.zopyra.com>
References: <20070320043341.GA29436@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 03:27:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTqYH-0003uL-JM
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 03:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbXCUC1q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 22:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752485AbXCUC1q
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 22:27:46 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61139 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450AbXCUC1p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 22:27:45 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l2L2Rgc11481;
	Tue, 20 Mar 2007 20:27:42 -0600
In-Reply-To: <20070320043341.GA29436@spearce.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42773>

On Tuesday, March 20, 2007 at 00:33:41 (-0400) Shawn O. Pearce writes:
>This is a simple but powerful continuous integration build system
>for Git.  ...

This looks quite useful.  Thanks for sharing your "hack".

For some reason, this got me to thinking about automated bisection.

The way I understand bisection to work is that you mark starting
and ending points (good vs. bad), then you do some work, and
tell git if the current point is good or bad, continuing on until
you find the first baddie.

This is a very thoughtful piece of software.

However, would it be possible to automate this, say by designating a
script to run that would automatically return the "good" vs. "bad",
allowing you to run off to lunch (or more) and let it determine the
first bad point?

Something like this:

% git bisect start
% git bisect bad
% git bisect good v2.6.13-rc2
% git bisect run my_script

I suppose one could just write a wrapper script, but perhaps this
would be convenient enough...


Bill
