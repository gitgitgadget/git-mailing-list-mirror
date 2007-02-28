From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 28 Feb 2007 20:41:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702282040430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702281535070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200702281515.10016.andyparkins@gmail.com>
 <Pine.LNX.4.63.0702281630430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200702281842.15147.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 20:41:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMUgN-00082u-QY
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 20:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbXB1Tlc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 14:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbXB1Tlc
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 14:41:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:48097 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751631AbXB1Tla (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 14:41:30 -0500
Received: (qmail invoked by alias); 28 Feb 2007 19:41:29 -0000
X-Provags-ID: V01U2FsdGVkX18QF3lMnAoQQ+AvAhWapUUiprh1QGNS+aGFycObho
	LYXA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702281842.15147.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40997>

Hi,

On Wed, 28 Feb 2007, Andy Parkins wrote:

> On Wednesday 2007, February 28, Johannes Schindelin wrote:
> 
> > for added files (and the obvious thing for deleted ones), but with
> > your patch, both added and deleted get
> >
> > 	Bin 123456 bytes
> >
> > which is not so optimal.
> 
> See my corrected patch.  However, while you're interested: how would one 
> tell the difference between 0 bytes and (no file).  I'm thinking of 
> these possibilities:
> 
>  new -> 123456
>  0 -> 123456
>  123456 -> deleted
>  123456 -> 0
> 
> For example - does mmfile_t.ptr set to NULL mean anything?

In non-binary case, we have only plusses or minusses, so you cannot tell 
either. You have to look into the summary for that.

Ciao,
Dscho
