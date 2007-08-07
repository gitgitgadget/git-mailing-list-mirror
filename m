From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Tue, 7 Aug 2007 12:58:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708071257350.14781@racer.site>
References: <f99cem$4a4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 13:59:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IINit-0003cw-Vh
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 13:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760162AbXHGL7O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 07:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760142AbXHGL7N
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 07:59:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:37633 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760095AbXHGL7L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 07:59:11 -0400
Received: (qmail invoked by alias); 07 Aug 2007 11:59:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 07 Aug 2007 13:59:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+nV9Z1kI2nt6RRPsbtyY18b5eZtkKidScQe830cl
	hr8byGb55t95C2
X-X-Sender: gene099@racer.site
In-Reply-To: <f99cem$4a4$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55247>

Hi,

On Tue, 7 Aug 2007, Sebastian Schuberth wrote:

>  100% (2295/2295) done
> Resolving 1793 deltas...
>  100% (1793/1793) done
> : not a valid SHA1b870df7cde1e05ee76d1d15ea428f
> fatal: Not a valid object name HEAD

I suspect that there is no master branch on the remote side, but the 
remote's HEAD points there.  Try "git ls-remote <url>" to find out.

Ciao,
Dscho
