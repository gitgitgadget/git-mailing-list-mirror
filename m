From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: How to Import a bitkeeper repo into git - Had a few questions on Qgit; I like the GUI.
Date: Thu, 18 Oct 2007 23:12:22 +0200
Message-ID: <200710182312.23616.robin.rosenberg.lists@dewire.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com> <200710171800.37345.robin.rosenberg.lists@dewire.com> <e5bfff550710171626h733228aw7a251746d2b43c63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: pete@bluelane.com, piet.delaney@gmail.piet.net,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	"free cycle" <freecycler23@yahoo.com>, git@vger.kernel.org,
	piet.delaney@gmail.com, "Piet Delaney" <pdelaney@bluelane.com>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 23:10:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IicdI-0008VI-Ub
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 23:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759219AbXJRVJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 17:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758817AbXJRVJw
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 17:09:52 -0400
Received: from [83.140.172.130] ([83.140.172.130]:23267 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754846AbXJRVJv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 17:09:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2E98E802AAD;
	Thu, 18 Oct 2007 23:01:12 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 29768-02; Thu, 18 Oct 2007 23:01:11 +0200 (CEST)
Received: from [10.9.0.7] (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id AAAAE802A88;
	Thu, 18 Oct 2007 23:01:11 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <e5bfff550710171626h733228aw7a251746d2b43c63@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61559>

torsdag 18 oktober 2007 skrev Marco Costalba:
> On 10/17/07, Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> >
> > You could avoid the temporary files if you just pipe the diff to kompare. That
> > would require an option to tell qgit that the external viewer can read a git diff.
> >
> > At the time qgit 1.5 was written, kompare could not handle git diffs.
> >
> 
> So does the other tools I have checked at that time.
> 
> But I don't know if this fixes the problem of slowness reported. A
> little test Pete may do is just as I have written in the former email:
> try to save the big files that cause troubles where he prefers and run
> Kompare on them directly from the command line.
> 
> Is kompare faster? If no probably the 'pipe' technique will not solve
> the problem and shrinks the applicability of the external diff
> launcher to tools that handle diffs directly.

kompare is pretty fast. Obviously not as fast as less.

"git diff HEAD HEAD~1000|kompare -" takes less than two seconds (hot cache)
on my machine. With small diffs it is almost instantaneous.

-- robin
