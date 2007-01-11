From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Bug-ish: CRLF endings and conflict markers
Date: Thu, 11 Jan 2007 10:46:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701111043440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701110941.22024.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 10:46:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4wWN-0001WK-IS
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 10:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965358AbXAKJqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 04:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965341AbXAKJqx
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 04:46:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:48068 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965358AbXAKJqw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 04:46:52 -0500
Received: (qmail invoked by alias); 11 Jan 2007 09:46:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp012) with SMTP; 11 Jan 2007 10:46:51 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701110941.22024.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36568>

Hi,

On Thu, 11 Jan 2007, Andy Parkins wrote:

> [describes that conflict markers have LF-only line ending, even if file 
>  has CR-LF line endings]
> 
> The best solution is probably to use the line ending of the conflicted 
> lines.

Question is: how to find out. Especially if your file already has mixed 
line endings...

> I've had a look, but I can only fine builtin-rerere.c that generates the 
> markers - would that be the place to make this change?

No. It would be in xdiff/xmerge.c:{139,147,160}. But I think that xdiff 
really is LF-only throughout, so you'd have to do much more work anyway.

Ciao,
Dscho
