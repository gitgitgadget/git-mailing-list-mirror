From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git merge with tkdiff fails (extra operand)
Date: Mon, 28 Jan 2008 13:13:17 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801281309240.23907@racer.site>
References: <fnk90t$gkq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 14:14:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJToO-0000Tq-1u
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 14:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481AbYA1NNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 08:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755542AbYA1NNh
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 08:13:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:53219 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755222AbYA1NNg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 08:13:36 -0500
Received: (qmail invoked by alias); 28 Jan 2008 13:13:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 28 Jan 2008 14:13:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18M1tl4dUcMMhz3GwPYCCR2EojdE7NJmLyED77wIV
	Auiv2R/H9zNpP/
X-X-Sender: gene099@racer.site
In-Reply-To: <fnk90t$gkq$1@ger.gmane.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71887>

Hi,

On Mon, 28 Jan 2008, Sebastian Schuberth wrote:

> I'm running Git 1.5.3.7 under SuSE 10.0. After pulling and getting a 
> merge conflict, "git mergetool" by default is configured to run tkdiff. 
> Unfortunately, tkdiff starts with an error:
> 
> diff failed:
> diff: extra operand
> `Amira/QxViewer.cpp.REMOTE.28414`
> diff: Try diff --help for more information.
> 
> I'm not sure whether the error is with the tkdiff integration into Git, 
> or with tkdiff itself (as it refers to the help for "diff").

It seems that tkdiff calls diff with arguments that diff does not like.  
What version of tkdiff do you use?

Ciao,
Dscho

P.S.: to make sure that it is tkdiff, I would search for this line in 
tkdiff:

	set g(debug) f

and change the "f" to "t".
