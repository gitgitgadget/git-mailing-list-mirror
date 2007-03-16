From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 16:16:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703161612380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org>
 <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316104715.483df0d5@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Fri Mar 16 16:16:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSEAV-0002ml-RI
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 16:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbXCPPQ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 11:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399AbXCPPQ3
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 11:16:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:54329 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752279AbXCPPQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 11:16:28 -0400
Received: (qmail invoked by alias); 16 Mar 2007 15:16:27 -0000
X-Provags-ID: V01U2FsdGVkX18qoXttZg8qBch6ERbCR08B3cOltV/P0uK+zsGWWC
	FqPEqUvryjmYxw
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070316104715.483df0d5@localhost>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42365>

Hi,

On Fri, 16 Mar 2007, Luiz Fernando N. Capitulino wrote:

>  It doesn't need to be the next five-zilion-function-library that will 
> provide the wonders of git in several different ways.

Yes. Just like we have a really small really stable part of core-git, 
which can be used by porcelains, and is expected to work the same in 
future versions, we could have eventually with libgit.

That would mean, for example, that rev_info should always be initialised 
with malloc() so that future versions can make it bigger, and that new 
members be added always at the end.

>  We could start by fixing the got-an-error-die behaivor and define a 
> _experimental_ API (just a few functions) just to get data out of git.

That sounds very reasonable.

And if it does not work out as expected, we don't have to make it part of 
"official" Git. It can live on as a fork.

Ciao,
Dscho
