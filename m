From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 3 Feb 2008 21:43:01 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802032138420.7372@racer.site>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 22:44:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLmdI-0007Rn-3s
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 22:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbYBCVnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 16:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbYBCVnj
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 16:43:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:58219 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752369AbYBCVni (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 16:43:38 -0500
Received: (qmail invoked by alias); 03 Feb 2008 21:43:37 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp053) with SMTP; 03 Feb 2008 22:43:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9uqdwvJ29ArLt+J9l3S+bTma7Zb8M4uP7G49HN7
	A1q/WjtENnG3Hj
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72407>

Hi,

On Sun, 3 Feb 2008, Junio C Hamano wrote:

> [On hold]
> 
> * js/remote (Wed Dec 5 19:02:15 2007 +0000) 4 commits
>  - Make git-remote a builtin
>  - Test "git remote show" and "git remote prune"
>  - parseopt: add flag to stop on first non option
>  - path-list: add functions to work with unsorted lists
> 
> I might have carefully looked at this in the past but I do not
> recall if there were issues.  Need re-reviewing and help from
> the list is appreciated.

You said that the test suit fails on one of your machines, and I looked at 
it with valgrind.  There was an odd problem accessing free()d memory, and 
I decided to come back to it after 1.5.4.

So please let me rework it first, before you re-review it.

> * synopsys: use {} instead of () for grouping alternatives (Jari Aalto)
>   $gmane/72243

Personally, I do not think the current form merits any change.

Ciao,
Dscho
