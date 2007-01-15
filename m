From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 13:02:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701151255530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701151000.58609.andyparkins@gmail.com> <20070115105616.GE12257@spearce.org>
 <Pine.LNX.4.63.0701151201100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701151150.28082.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 15 19:23:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VXn-0001fS-1v
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:22:51 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9t-0003eK-4S
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbXAOMCV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 07:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbXAOMCV
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 07:02:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:35035 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932255AbXAOMCU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 07:02:20 -0500
Received: (qmail invoked by alias); 15 Jan 2007 12:02:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp012) with SMTP; 15 Jan 2007 13:02:18 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701151150.28082.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36822>

Hi,

On Mon, 15 Jan 2007, Andy Parkins wrote:

> It is certainly true that signed commits /is/ a feature.  And it's a 
> feature that some people might want.  If there isn't a technical 
> argument against it, what does it matter?
> 
> (Note: it doesn't matter enough to me that I would put the time in, I'm 
> arguing in the abstract really - should features be kept out because 
> they allow a development method we would find distasteful?)

You gave the answer yourself: until there is somebody who needs it, I 
guess it will not be there.

Note that it would be relatively easy: I already gave the location where 
the hook should go (builtin-commit-tree.c, line 151), and you can see an 
example how to execute a hook in receive-pack.c, lines 67ff.

Ciao,
Dscho

P.S.: Yes, I am encouraging you to implement it.
