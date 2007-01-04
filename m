From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] git-reset --hard: tell the user what the HEAD was reset
 to
Date: Thu, 04 Jan 2007 15:59:44 +0000
Message-ID: <459D2470.2090001@shadowen.org>
References: <emcf17$esj$1@sea.gmane.org> <Pine.LNX.4.63.0612211525070.19693@wbgn013.biozentrum.uni-wuerzburg.de> <459BACE1.5020406@shadowen.org> <Pine.LNX.4.63.0701041357380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 17:00:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2V0m-0006WW-7o
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 17:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbXADP7s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 10:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbXADP7r
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 10:59:47 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:1809 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964958AbXADP7q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 10:59:46 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H2UzS-0005lp-FA; Thu, 04 Jan 2007 15:58:50 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701041357380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35937>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 3 Jan 2007, Andy Whitcroft wrote:
> 
>> I think we need to delimit the name better, probabally we need to quote
>> it.  Perhaps something like:
>>
>>   HEAD is now at ac9c110: "git-fetch: remove .keep file at the end".
> 
> Fine. But this is "git log --pretty=oneline --abbrev-commit". I don't know 
> how many things break if you change _that_.
> 
> Alternatively, you could pipe that into a sed command adding the colon and 
> the quotes.

Quack, so it is.

apw@pinky$ git log --pretty=oneline --abbrev-commit | head -1
f4bf218... Update clone/fetch documentation with --depth (shallow clone)
option

Perhaps we could do something like:

Head is now at "f4bf218... Update clone/fetch documentation with --depth
(shallow clone) option"

Hmmm ... oh well I guess I'll just get used to it.

-apw
