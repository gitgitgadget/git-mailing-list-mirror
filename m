From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git cvsimport branches not consistent with CVS branches
Date: Sun, 8 Jul 2007 16:38:53 +0200
Message-ID: <3BA4D1AE-D5C9-42CB-81B4-38DC3946A966@zib.de>
References: <46903396.1010507@heydon.com.au> <20070708054520.GD4087@lavos.net> <200707081253.06129.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Brian Downing <bdowning@lavos.net>,
	Gordon Heydon <gordon@heydon.com.au>
X-From: git-owner@vger.kernel.org Sun Jul 08 16:38:23 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7Xu2-0003zw-Kh
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 16:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbXGHOiG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 10:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753771AbXGHOiF
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 10:38:05 -0400
Received: from mailer.zib.de ([130.73.108.11]:33610 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257AbXGHOiE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 10:38:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l68EbptY008546;
	Sun, 8 Jul 2007 16:37:51 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db115bd.pool.einsundeins.de [77.177.21.189])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l68EbnvQ029906
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 8 Jul 2007 16:37:50 +0200 (MEST)
In-Reply-To: <200707081253.06129.robin.rosenberg.lists@dewire.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51887>


On Jul 8, 2007, at 12:53 PM, Robin Rosenberg wrote:

> Corecode's fromcvs is pretty fast and incremental and AFAIK  
> accurate. I had
> plenty problems with cvsimport, but fromcvs keeps in sync with the  
> CVS repo.
> Get  it at http://ww2.fs.ei.tum.de/~corecode/hg/fromcvs/ .
>
> It does not convert regular tags, only branches, however so there  
> is something to
> do for those that want a complete cvs import.

Did anyone compare
    * git-cvsimport with cvsps patches from [1]
    * parsecvs [2]
    * fromcvs
and can give a recommendation?

My experience with plain git-cvsimport (without cvsps patches from [1])
is that it has a lot of problems. I'd recommend not to use it for
incremental import and be very suspicious about the git repository
created by git-cvsimport. You need to carefully validate the repository.
It's likely that you need to fix imported branches. The trunk seems to
be ok.

	Steffen

[1] http://ydirson.free.fr/en/software/scm/cvsps.html
[2] http://anongit.freedesktop.org/git/users/keithp/repos/parsecvs.git/
