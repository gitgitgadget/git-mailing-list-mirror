From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 9 Jan 2008 13:41:38 +0100
Message-ID: <04EF2652-9AA8-4976-903F-DBE4E7AA13D7@zib.de>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LFD.1.00.0801071332530.3148@woody.linux-foundation.org> <alpine.DEB.1.00.0801082226110.21686@perkele.intern.softwolves.pp.se> <alpine.LSU.1.00.0801091054400.31053@racer.site>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 09 13:41:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCaFQ-0001iu-PC
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 13:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbYAIMlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 07:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbYAIMlE
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 07:41:04 -0500
Received: from mailer.zib.de ([130.73.108.11]:40627 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbYAIMlB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 07:41:01 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m09CeYiC006745;
	Wed, 9 Jan 2008 13:40:34 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m09CeXQ1029324
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 9 Jan 2008 13:40:33 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0801091054400.31053@racer.site>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69985>


On Jan 9, 2008, at 11:56 AM, Johannes Schindelin wrote:

> Hi,
>
> On Tue, 8 Jan 2008, Peter Karlsson wrote:
>
>> Linus Torvalds:
>>
>>> So defaulting to (or asking) "autocrlf" at install time is probably
>>> the safest thing, and then people can edit their  
>>> global .gitconfig to
>>> turn it off.
>>
>> Indeed. A checkbox in the Windows installer (like Cygwin has)  
>> would be
>> nice.
>
> No.  There are different needs for different projects, and having
> different defaults just adds to the confusion.
>
> I am no longer opposed to setting crlf=true by default for Git  
> (although
> this does not necessarily hold true for msysGit, but that could be
> helped by explicitely unsetting crlf for the repositories we check out
> with the netinstaller).

I'll further think about "crlf=safe" (see another mail in this
thread). I like the idea of safe because it guarantees that data
will never be corrupted.  But I have no time to think about it
immediately.

	Steffen
