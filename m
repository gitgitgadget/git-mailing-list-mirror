From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/14] fork/exec removal series
Date: Sun, 14 Oct 2007 18:09:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710141808300.25221@racer.site>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at>
 <20071014021149.GO27899@spearce.org> <Pine.LNX.4.64.0710140348550.25221@racer.site>
 <20071014025857.GQ27899@spearce.org> <20071014071239.GB1198@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <johannes.sixt@telecom.at>, gitster@pobox.com,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 19:09:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih6yO-00081w-Th
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 19:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758229AbXJNRJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 13:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758172AbXJNRJm
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 13:09:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:43540 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758113AbXJNRJj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 13:09:39 -0400
Received: (qmail invoked by alias); 14 Oct 2007 17:09:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 14 Oct 2007 19:09:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19JiPA/JE5JmA6Fiag5AxivreYpvNc1eeyXmlHNFe
	Ohdz5nTvYn2nLS
X-X-Sender: gene099@racer.site
In-Reply-To: <20071014071239.GB1198@artemis.corp>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60871>

Hi,

On Sun, 14 Oct 2007, Pierre Habouzit wrote:

> On Sun, Oct 14, 2007 at 02:58:57AM +0000, Shawn O. Pearce wrote:
>
> > But we most definately *must* continue to support fork() for the async 
> > functions.  Its the most common interface available on one of our 
> > biggest platforms (UNIX).
> 
> Yeah that, and the fact that many of the git modules aren't thread-safe 
> (some modules have static buffers strbuf's or caching variables) and 
> should be used with care.

I think that was exactly the point of Shawn: expose bugs on Unix that 
would otherwise only show in msysGit.

Ciao,
Dscho
