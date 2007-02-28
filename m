From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 28 Feb 2007 15:44:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702281535070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702281303.11951.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 15:45:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMQ33-0007Ps-7j
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 15:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbXB1Oov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 09:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbXB1Oov
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 09:44:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:39195 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932436AbXB1Oov (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 09:44:51 -0500
Received: (qmail invoked by alias); 28 Feb 2007 14:44:49 -0000
X-Provags-ID: V01U2FsdGVkX19nEKEEdAFnHLa0IYrD47k2mOfqhrrzgJl8UaNy2s
	OLDg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702281303.11951.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40927>

Hi,

On Wed, 28 Feb 2007, Andy Parkins wrote:

> Previously, a binary file in the diffstat would show as:
> 
>  some-binary-file.bin       |  Bin
> 
> The space after the "Bin" was never used.  This patch changes binary
> lines in the diffstat to be:
> 
>  some-binary-file.bin       |  Bin +123456B -12345B

This seemed as a good idea to me at first. But I think it is a little 
misleading: Imagine for example that you have raw image data (which I 
track with Git, too). If only part of that changes, this representation is 
misleading.

How about "Bin 123456 -> 12345 bytes" instead?

Ciao,
Dscho
