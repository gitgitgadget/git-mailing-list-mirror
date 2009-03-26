From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Question: Is it possible to host a writable git repo over both http and ssh?
Date: Thu, 26 Mar 2009 06:18:32 +0100
Message-ID: <200903260618.33019.robin.rosenberg.lists@dewire.com>
References: <49CA6A17.6050903@gmail.com> <49CB0AC1.2070006@gmail.com> <20090326045650.GA13628@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mike Gaffney <mr.gaffo@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 07:03:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmiga-0007uq-O8
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 07:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbZCZGAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 02:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbZCZGAe
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 02:00:34 -0400
Received: from mail.dewire.com ([83.140.172.130]:14999 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbZCZGAd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 02:00:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 479261391418;
	Thu, 26 Mar 2009 07:00:26 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sf9o-F2TiYUh; Thu, 26 Mar 2009 07:00:25 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 3673F80284C;
	Thu, 26 Mar 2009 07:00:25 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-14-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <20090326045650.GA13628@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114736>

torsdag 26 mars 2009 05:56:51 skrev Jeff King <peff@peff.net>:
> On Wed, Mar 25, 2009 at 11:55:29PM -0500, Mike Gaffney wrote:
> 
> > I'm actually trying to take what Sean did with gerrit and extract a
> > full Java/MinaSSHD based server that doesn't require a real user
> > account and is configurable by spring. So yes, I'm using JGit on the
> > server.
> 
> Ah. In that case, I don't know whether JGit respects all hooks. You
> should ask Shawn (Shawn, we are talking about a post-update to run
> update-server-info). :)

Arguably it should. but it doesn't. Then there is a question as to what
format those hooks should be. Shell scripts would run into platform
issues and jgit based stuff should have as little as possible of that, but
a similar mechanism should exist.

-- robin
