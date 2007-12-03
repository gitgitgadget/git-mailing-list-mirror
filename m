From: Christoph <christoph.duelli@gmx.de>
Subject: Re: importing bk into git
Date: Mon, 3 Dec 2007 21:59:56 +0100
Message-ID: <200712032159.57017.christoph.duelli@gmx.de>
References: <200711292232.03352.christoph.duelli@gmx.de> <t1o1wa432gc.fsf@ednux512.dsto.defence.gov.au>
Reply-To: christoph.duelli@gmx.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kettler <David.Kettler@dsto.defence.gov.au>
X-From: git-owner@vger.kernel.org Mon Dec 03 22:00:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzIP2-0002fV-6f
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 22:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbXLCVAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 16:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbXLCVAL
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 16:00:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:50642 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751106AbXLCVAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 16:00:09 -0500
Received: (qmail invoked by alias); 03 Dec 2007 21:00:07 -0000
Received: from dslb-084-057-014-012.pools.arcor-ip.net (EHLO dslb-084-057-014-012.pools.arcor-ip.net) [84.57.14.12]
  by mail.gmx.net (mp040) with SMTP; 03 Dec 2007 22:00:07 +0100
X-Authenticated: #2486746
X-Provags-ID: V01U2FsdGVkX185r7NtYg85d8b/cyUt/mBwAUBwsp3YVwfB0w86cp
	v+ahKH90ZByM60
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <t1o1wa432gc.fsf@ednux512.dsto.defence.gov.au>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66956>

On Monday 03 December 2007 04:02:43 you wrote:
> G'day,
>
> I modified that script to convert a number of our repositories in
> February.  The version below worked for me at the time, but I'm not
> able to test it now as our BK license has expired.  In particular I'm
> not sure if the bk_info.split line is correct; I had a reduced form of
> this line in the file which now looks obviously wrong.
>
> The script is slow; most of the time is in the bk export for every
> revision.  There are probably dumb things in there; I don't know
> python and I was just starting with git.
>
> Changes from the version I downloaded from the web include:
>   - sundry changes to make it work for me
>   - separate committers file to translate user names to full names
>   - specify a git dir template
>   - copy tags from BK
>   - minimal conversion of ignore files
>   - increased recursion limit to handle large number of commits
>
> I hope this is useful to someone.
Thanks,

I have made some modifications to get the script working as well. I was able 
to convert some simple (really small test repos).I wanted to try to convert 
my real big repo (>10k files, >5000 revisions) before mailing it. However, as 
running this conversion will probably take more than 24hours I will do so 
next weekend.
I will check your script and integrate my changes (if there are any relative 
to yours) after that.

best regards
Christoph
