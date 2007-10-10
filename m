From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [BUG] git-filter-branch and filename case changes on insensitive file systems
Date: Wed, 10 Oct 2007 14:49:30 +0100
Message-ID: <21D113DE-FEA8-4CD4-BFC6-3C57C1980597@steelskies.com>
References: <80A15F58-5A53-419B-9E22-E967CD590A12@steelskies.com> <Pine.LNX.4.64.0710101436570.4174@racer.site>
Mime-Version: 1.0 (Apple Message framework v907)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 15:49:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfbwV-0004aV-Gx
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 15:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163AbXJJNtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 09:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754159AbXJJNte
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 09:49:34 -0400
Received: from juliet.asmallorange.com ([207.210.105.70]:57054 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbXJJNte (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 09:49:34 -0400
Received: from gir.office.bestbefore.tv ([89.105.122.147]:51530)
	by juliet.asmallorange.com with esmtpa (Exim 4.68)
	(envelope-from <maillist@steelskies.com>)
	id 1IfbwL-0008FM-Tl; Wed, 10 Oct 2007 09:49:34 -0400
In-Reply-To: <Pine.LNX.4.64.0710101436570.4174@racer.site>
X-Mailer: Apple Mail (2.907)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60498>


On 10 Oct 2007, at 14:39, Johannes Schindelin wrote:

> On Wed, 10 Oct 2007, Jonathan del Strother wrote:
>
>> My repo has a change where a directory named Src was renamed to src.
>
> That is no problem for git-filter-branch.
>
>> I'm using case insensitive HFS+.
>
> That is the problem.

...

> I vote for wont-fix (or more accurately "invalid") in git and
> please-fix-in-your-setup.

Would love to switch to case sensitive HFS+, but it causes a number of  
problems for OS X users - a number of 3rd party applications don't  
bother supporting case sensitive formatting (notably Adobe :/ ).


I appreciate that it's difficult and/or impossible to make certain  
operations work on case insensitive FS's, but it seems like git ought  
to at least complain noisily when it encounters such a situation...
