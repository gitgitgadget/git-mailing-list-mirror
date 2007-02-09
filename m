From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] format-patch -n: make sorting easier by padding number
Date: Fri, 9 Feb 2007 01:47:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702090147050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702082158.56463.andyparkins@gmail.com>
 <200702082331.13095.andyparkins@gmail.com> <20070208234153.GB1556@spearce.org>
 <7vk5ysw6a3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702081623460.8424@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702090142100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Feb 09 01:47:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFJvi-0007Gb-2v
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 01:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422733AbXBIArz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 19:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423187AbXBIArz
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 19:47:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:47069 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422733AbXBIAry (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 19:47:54 -0500
Received: (qmail invoked by alias); 09 Feb 2007 00:47:53 -0000
X-Provags-ID: V01U2FsdGVkX1/jZp9crBrjMnw8nOZg+h6yAInzjgw6+Z6X4IjGGx
	MI2g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702090142100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39144>

Hi,

On Fri, 9 Feb 2007, Johannes Schindelin wrote:

> +static unsigned int log10(unsigned int number)
> +{
> +	unsigned int i = 10, result = 1;
> +	while (i < number) {

D'oh. Make that "<=", please.

> +		i *= 10;
> +		result++;
> +	}
> +	return result;
> +}

Ciao,
Dscho
