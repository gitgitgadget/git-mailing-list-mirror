From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git merge remote branch says "Merge commit ..."?
Date: Fri, 22 May 2009 20:30:34 +0200
Message-ID: <200905222030.34301.j6t@kdbg.org>
References: <2729632a0905211250v4e7537caybe9e703c14361b5f@mail.gmail.com> <loom.20090522T172429-73@post.gmane.org> <20090522175401.GB11640@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Raible <raible@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 22 20:31:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7ZWR-0005PA-MW
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 20:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbZEVSai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 14:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbZEVSah
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 14:30:37 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:55834 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752620AbZEVSag (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 14:30:36 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 16CB6CDF8F;
	Fri, 22 May 2009 20:30:34 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 89E0C5AF31;
	Fri, 22 May 2009 20:30:34 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090522175401.GB11640@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119749>

On Freitag, 22. Mai 2009, Jeff King wrote:
> No, it is not terribly expensive. But you do have to talk to the server,
> which may mean making an ssh connection, or the server may be overloaded
> and slow. So it can take a few seconds instead of a few microseconds.

It's certainly doable without a remote connection with some digging in the 
configuration.

Git-gui has some magic to find out the remote when you request to merge a 
remote tracking branch. That is, even though you clickety-click through to do 
the equivalent of 'git merge origin/master', it comes up with a merge message 
that is the same as if you had said 'git pull origin master' on the command 
line. It doesn't need a connection to do that.

-- Hannes
