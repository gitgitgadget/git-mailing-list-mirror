From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: "git pull . <branch>" versus "git merge <branch>"
Date: Thu, 12 Jun 2008 02:56:52 +0200
Message-ID: <48507454.2070506@keyaccess.nl>
References: <484F2174.9020508@keyaccess.nl>	 <alpine.LNX.1.00.0806111340570.19665@iabervon.org>	 <XZoDb2arIiMts-bX6jjK15wC9cOn5lPGgCOQYbY9YIyNm_nfcDf5gQ@cipher.nrlssc.navy.mil>	 <alpine.LNX.1.00.0806111513380.19665@iabervon.org>	 <kpNEshc02wSu18FDnzOIvMAjQu_lmbk4tK_T_9HGh38@cipher.nrlssc.navy.mil> <237967ef0806111449i7d23976dxa3290eece06b5876@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Daniel Barkalow <barkalow@iabervon.org>,
	git <git@vger.kernel.org>, Miklos Vajna <vmiklos@frugalware.org>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 02:57:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6b8K-00089k-L1
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 02:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbYFLA4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 20:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752288AbYFLA4u
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 20:56:50 -0400
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:53801 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbYFLA4t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 20:56:49 -0400
Received: from [213.51.146.188] (port=60219 helo=smtp3.tilbu1.nb.home.nl)
	by smtpq1.tilbu1.nb.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1K6b7O-00076s-48; Thu, 12 Jun 2008 02:56:46 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:44322 helo=[192.168.0.3])
	by smtp3.tilbu1.nb.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1K6b7N-0004Gq-Jj; Thu, 12 Jun 2008 02:56:45 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <237967ef0806111449i7d23976dxa3290eece06b5876@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84689>

On 11-06-08 23:49, Mikael Magnusson wrote:

> For me, git-pull is that additional command, and using git-pull . 
> <branch> to merge feels really really strange. Why would I pull
> something I already have?

For what it's worth I (as thread starter) agree with this. At least in 
my mind local and remote branches are very different and I do not mind 
having to "fetch" the latter first before merging (nor combine the two 
through a "pull").

I can see the reason for the other viewpoint as well since it emphasises 
a point about local and remote branches _not_ being very different after 
all but that's more a symmetry to the implementor than it is to a user I 
feel. For the user, local and remote branches just are different.

And as such I feel it actually helps to just use "merge". Thanks for the 
answers everyone -- this was a matter of a user worrying that he wasn't 
getting it...

Rene
