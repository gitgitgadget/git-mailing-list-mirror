From: Christopher Faylor <me@cgf.cx>
Subject: Re: CFT: merge-recursive in C
Date: Wed, 28 Jun 2006 11:06:47 -0400
Message-ID: <20060628150647.GA16935@trixie.casa.cgf.cx>
References: <20060626233838.GA3121@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 28 17:07:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvbcx-0005hg-Ok
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 17:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWF1PGt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 11:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWF1PGt
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 11:06:49 -0400
Received: from pool-71-248-179-197.bstnma.fios.verizon.net ([71.248.179.197]:235
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S1751135AbWF1PGs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 11:06:48 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id CB4E813C01F; Wed, 28 Jun 2006 11:06:47 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060626233838.GA3121@steel.home>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22810>

On Tue, Jun 27, 2006 at 01:38:38AM +0200, Alex Riesen wrote:
>It still uses some calls to git programs (git-update-index,
>git-hash-object, git-diff-tree and git-write-tree), and merge(1) has
>the labels (-L) missing - I was unsure how to tackle this on windows -
>it has only argv[1].

Actually, Windows should behave the same as Linux wrt argv handling.
You can use argv[1] ... argv[n] modulo any differences in command line
quoting.

On Windows the arguments are broken into individual components by the
runtime, e.g., MSVCRT.dll or Cygwin1.dll.

cgf
