From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Filter-branch's "move tree to subdirectory" example fails with
 BSD sed?
Date: Sat, 14 Apr 2012 21:25:05 +0200
Message-ID: <4F89CF11.7060309@kdbg.org>
References: <20120414160028.GD1012@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 21:25:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ8aw-00066k-LS
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 21:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab2DNTZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 15:25:08 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:33361 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753859Ab2DNTZH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 15:25:07 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9A99C13004A;
	Sat, 14 Apr 2012 21:25:05 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2766F19F69F;
	Sat, 14 Apr 2012 21:25:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.28) Gecko/20120306 SUSE/3.1.20 Thunderbird/3.1.20
In-Reply-To: <20120414160028.GD1012@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195508>

Am 14.04.2012 18:00, schrieb Christopher Tiwald:
> The "Move tree to subdirectory" example in the 'git filter-branch'
> manpage fails on Mac OSX 10.7.3, but succeeds on Ubuntu 10.04.

> git init "test"
> cd "test"
> mkdir -p subdirA/subdirB
> echo content > subdirA/subdirB/file
> git add .
> git commit -m "initial commit"
> git ls-files -s | sed "s-\t\"*-&newsubdir/-"
> 
> On Mac 10.7.3 the final command outputs:
> 100644 d95f3ad14dee633a758d2e331151e950dd13e4ed 0	subdirA/subdirB/file
> 
> On Ubuntu 10.04:
> 100644 d95f3ad14dee633a758d2e331151e950dd13e4ed 0	newsubdir/subdirA/subdirB/file

Perhaps a literal TAB instead of \t makes the example work?

It would be difficult, though, to write this down in the manual in an
unambiguous way.

-- Hannes
