From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git with custom diff for commits
Date: Mon, 17 Dec 2007 23:01:37 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712172300510.9446@racer.site>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Gerald Gutierrez <ggmlfs@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:03:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Oz8-0004FK-2Y
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764932AbXLQXBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764242AbXLQXBx
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:01:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:58302 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S937213AbXLQXBv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:01:51 -0500
Received: (qmail invoked by alias); 17 Dec 2007 23:01:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 18 Dec 2007 00:01:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kCkZI1Rcktoo8eFDcOyTJk23qOnaSk/e80Dxvh6
	EV1XJS2gjSs6yS
X-X-Sender: gene099@racer.site
In-Reply-To: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68651>

Hi,

On Mon, 17 Dec 2007, Gerald Gutierrez wrote:

> I do a nightly mysqldump of a database and check it into a git 
> repository. mysqldump generates a timestamp as part of that output which 
> is causing git to think that the file changes every night when it really 
> doesn't. The timestamp is simply in an SQL comment.
> 
> So what I'd like to do is teach git to ignore that particular SQL 
> timestamp comment. I've tried to set up an external diff script that 
> runs diff -I "<<sql timestamp comment>>" that effectively ignores the 
> timestamp. While this works with "git diff", it seems when git commits, 
> it still sees the differences.
> 
> How do I properly teach git to ignore these types of differences?

You might be interested in reading Documentation/gitattributes.txt, look 
for "diff driver".

Hth,
Dscho
