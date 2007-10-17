From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: How to Import a bitkeeper repo into git - Had a few questions on Qgit; I like the GUI.
Date: Wed, 17 Oct 2007 18:00:36 +0200
Message-ID: <200710171800.37345.robin.rosenberg.lists@dewire.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com> <47159779.6010502@bluelane.com> <e5bfff550710170030y7778e96ax146acea7a0e57a67@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Oct 17 17:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiBIC-0004RG-L7
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 17:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765384AbXJQP6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 11:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764544AbXJQP6I
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 11:58:08 -0400
Received: from [83.140.172.130] ([83.140.172.130]:2867 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1765263AbXJQP6G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 11:58:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1B7E5146E990;
	Wed, 17 Oct 2007 17:49:27 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12749-09; Wed, 17 Oct 2007 17:49:26 +0200 (CEST)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id A87BC82758E;
	Wed, 17 Oct 2007 17:49:26 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <e5bfff550710170030y7778e96ax146acea7a0e57a67@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61387>

onsdag 17 oktober 2007 skrev Marco Costalba:
> On 10/17/07, Pete/Piet Delaney <pete@bluelane.com> wrote:
> >
> > While I'm looking at the diffs for a file if I pull down External Diff
> > it launches 'kcompare' but for a file with a large change it seems
> > to be running extremely slow.
> 
> qgit does not intergarte Kompare functionality, it just prepares the
> files and spawns a Kompare process.
> 
> So there's seem nothing qgit can do about Kompare speed. You can try
> with different diff viewers, meld,...etc..

You could avoid the temporary files if you just pipe the diff to kompare. That
would require an option to tell qgit that the external viewer can read a git diff.

At the time qgit 1.5 was written, kompare could not handle git diffs.

-- robin
