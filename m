From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [RFD] Strange patch formats (aka tricks with unified diffs)..
Date: Fri, 13 Apr 2007 10:10:50 +0200
Message-ID: <20070413081049.GA26649@moooo.ath.cx>
References: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 10:11:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcGrz-0001oL-Fv
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 10:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbXDMIKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 04:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbXDMIKy
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 04:10:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:59091 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752712AbXDMIKx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 04:10:53 -0400
Received: (qmail invoked by alias); 13 Apr 2007 08:10:52 -0000
Received: from pD9EBB9A8.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.185.168]
  by mail.gmx.net (mp032) with SMTP; 13 Apr 2007 10:10:52 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19RIxdpW7dR/12AgJrEqHO57gxtNs7dlGuAEBwoYK
	I3Kl+sJyz00qns
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44393>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
>  - add some actual switch to git diff generation to hide the negative side 
>    of a unified diff, and add some way to just make gitk pass that switch 
>    in.

This one would still allow to show the added lines still colored in
green.  Or do I miss a way to do this?  git show --color is not very
grep friendly because lines begin with an escape sequence.
