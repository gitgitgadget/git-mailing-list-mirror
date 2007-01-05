From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Adding spell checker to GIT
Date: Fri, 5 Jan 2007 21:49:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701052147070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <b5a19cd20701041246we052685hd700580df2cc120d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 21:50:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2w0h-0006dW-QI
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 21:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbXAEUtx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 15:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbXAEUtw
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 15:49:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:51654 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750738AbXAEUtw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 15:49:52 -0500
Received: (qmail invoked by alias); 05 Jan 2007 20:49:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 05 Jan 2007 21:49:50 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Deepak Barua <dbbarua@gmail.com>
In-Reply-To: <b5a19cd20701041246we052685hd700580df2cc120d@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36021>

Hi,

On Fri, 5 Jan 2007, Deepak Barua wrote:

>         I and sasikumar have designed and built a spell checker into
> the pre-commit hook, could someone please test it and give us your
> comments.

It's a rather big chunk of code, and it is in perl, so I'd rather put it 
in another file, but oh well.

There are a few remaining problems, and I don't even know if the second 
can be solved:

- you miss "//" comments,
- if the diff is only about a small part of a comment, you do not spell 
  check that
- you do not spell check literal messages (i.e. printf("No such fiel!"))

Ciao,
Dscho
