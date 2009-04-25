From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Add an option not to use link(src, dest) && unlink(src) when that is unreliable
Date: Sat, 25 Apr 2009 20:52:10 +0200
Message-ID: <200904252052.10327.j6t@kdbg.org>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 25 20:53:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxn0Z-0005Iv-UL
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 20:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbZDYSwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 14:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074AbZDYSwR
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 14:52:17 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:35024 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbZDYSwR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 14:52:17 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9C363A7EB4;
	Sat, 25 Apr 2009 20:52:10 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6AE9D4264E;
	Sat, 25 Apr 2009 20:52:10 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117571>

On Samstag, 25. April 2009, Linus Torvalds wrote:
> If you _don't_ do this patch, does
>
> 	[core]
> 		fsyncobjectfiles = true
>
> hide the bug?

Most likely not because our fsync() on Windows is a noop :(

-- Hannes
