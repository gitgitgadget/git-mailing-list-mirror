From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Warning: cvsexportcommit considered dangerous
Date: Sun, 4 Nov 2007 19:16:20 +0100
Message-ID: <623F4AFA-FE43-4046-9D3F-435396BBE17D@zib.de>
References: <Pine.LNX.4.64.0711041638270.4362@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Alex Bennee <kernel-hacker@bennee.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 04 22:22:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iomvm-0004F8-Vg
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 22:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbXKDVWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 16:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbXKDVWk
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 16:22:40 -0500
Received: from mailer.zib.de ([130.73.108.11]:44643 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040AbXKDVWj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 16:22:39 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA4LMUPv008027;
	Sun, 4 Nov 2007 22:22:30 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1be86.pool.einsundeins.de [77.177.190.134])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA4LMSV6007554
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 4 Nov 2007 22:22:29 +0100 (MET)
In-Reply-To: <Pine.LNX.4.64.0711041638270.4362@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63444>


On Nov 4, 2007, at 5:41 PM, Johannes Schindelin wrote:

> ever since the up-to-date check was changed to use just one call to  
> "cvs
> status", a bug was present.  Now cvsexportcommit expects "cvs  
> status" to
> return the results in the same order as the file names were passed.
>
> This is not true, as I had to realise with one of my projects on
> sourceforge.
>
> Since time is so scarce on my side, I will not have time to fix  
> this bug,
> but will instead return to my old "commit by hand" procedure.

I introduced this 'optimization', which turned out to be a bug.
So, I feel responsible. Sorry for the trouble.

In August this was already recognized and a patch submitted:

http://marc.info/?t=118718458000004&r=1&w=2

I do not know why it wasn't applied. I forgot re-checking after my
vacation.

I put all on CC who replied to the patch in August.

	Steffen
