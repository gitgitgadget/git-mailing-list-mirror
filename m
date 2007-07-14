From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: CVS -> SVN -> Git
Date: Sat, 14 Jul 2007 20:14:24 +0200
Message-ID: <EC3B307E-EA83-4128-BABD-D9BDB78F987E@zib.de>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>	 <469804B4.1040509@alum.mit.edu> <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com> <4699034A.9090603@alum.mit.edu>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Git Mailing List <git@vger.kernel.org>,
	dev <dev@cvs2svn.tigris.org>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Shawn Pearce <spearce@spearce.org>,
	Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Sat Jul 14 20:14:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9m8C-0003F2-8O
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 20:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758711AbXGNSNt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 14:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758706AbXGNSNt
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 14:13:49 -0400
Received: from mailer.zib.de ([130.73.108.11]:37346 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758678AbXGNSNs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 14:13:48 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6EIDZ1D010310;
	Sat, 14 Jul 2007 20:13:35 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1b7ba.pool.einsundeins.de [77.177.183.186])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6EIDSMY005765
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 14 Jul 2007 20:13:29 +0200 (MEST)
In-Reply-To: <4699034A.9090603@alum.mit.edu>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52492>


On Jul 14, 2007, at 7:09 PM, Michael Haggerty wrote:

> Martin Langhoff wrote:
>> On 7/14/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> Incidentally, now that cvs2svn 2.0.0 is nearly out, I am thinking  
>>> about
>>> what it would take to write some other back ends for cvs2svn-- 
>>> turning
>>> it, essentially, into cvs2xxx.  Most of the work that cvs2svn  
>>> does is
>>> inferring the most plausible history of the repository from CVS's
>>> sketchy, incomplete, idiomatic, and often corrupt data.  This work
>>> should also be useful for a cvs2git or cvs2hg or cvs2baz or ...
>>
>> Great to hear that. I'm game if we can do something in this direction
>> - surely we can make it talk to fastimport ;-)
>
> We added some hooks to cvs2svn 2.0 to start working in this direction.
> But I don't really know what information is needed for a git import.
> One quick-and-dirty idea that I had was to have cvs2svn output
> information compatible with cvsps's output, as I believe that several
> tools rely on cvsps to do the dirty work and so could perhaps be
> persuaded to use cvs2svn out of the box.

 From my understanding, piping data to git fast-import would be
a sane gateway to git. The input format of fast-import is document
in [1].

Maybe Shaw Pearce has some comments on that. Shawn did most
(maybe all) of the work on git-fast-import.

Simon Hausmann wrote a p4 importer that uses fast-import as
its backend. Maybe, Simon can give hints how to get started.

I have no experience with neither git-fast-import nor the p4
importer but would be happy to test any improved way of importing
cvs to git. I experienced problems using git-cvsimport on a rather
large cvs repository. Hence it would be a real test of the superior
capabilities of cvs2svn.

	Steffen


[1] http://www.kernel.org/pub/software/scm/git/docs/git-fast-import.html
