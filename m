From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 3/3] diff: make "too many files" rename warning optional
Date: Tue, 06 May 2008 23:33:30 +0100
Message-ID: <4820DCBA.2050406@ramsay1.demon.co.uk>
References: <20080430172136.GA22601@sigill.intra.peff.net>	<20080430172553.GC23747@sigill.intra.peff.net>	<481CA227.1000801@ramsay1.demon.co.uk>	<20080504192332.GB13029@sigill.intra.peff.net> <18462.18066.769759.585596@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed May 07 00:38:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtVnb-0004IB-Pk
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 00:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbYEFWhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 18:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765977AbYEFWhV
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 18:37:21 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:4401 "EHLO
	anchor-post-33.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762981AbYEFWhT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 18:37:19 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-33.mail.demon.net with esmtp (Exim 4.67)
	id 1JtVmf-000Ivv-BQ; Tue, 06 May 2008 22:37:18 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <18462.18066.769759.585596@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81385>

Paul Mackerras wrote:
> Jeff King writes:
> 
>> Hrm. Is gitk on cygwin somehow squishing stderr and stdout together? Or
>> does gitk in general look at what happens on stderr?
>>
>> Because while I am happy that removing this message fixes your problem,
>> it is a little disconcerting to think that we can break gitk just by
>> issuing a warning diagnostic on stderr.
> 
> It's a more general Tcl thing - if you are reading from a process, and
> the process writes to stderr, and the script hasn't explicitly
> redirected stderr, the Tcl infrastructure assumes that the process is
> signalling an error, even if the exit status is 0.  Gitk does redirect
> stderr (to stdout) when it does a git reset, but not for other
> commands.
> 

Ah, OK. That explains it.

Actually, I seem to have a vague recollection of having had this
discussion before...

All the Best,

Ramsay Jones
