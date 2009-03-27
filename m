From: =?ISO-8859-1?Q?Jonas_Flod=E9n?= <jonas.floden@gmail.com>
Subject: Re: Problem Creating Commit Messages
Date: Fri, 27 Mar 2009 08:56:07 +0100
Message-ID: <gqi0qn$i3k$1@ger.gmane.org>
References: <22735968.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 08:58:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln6x7-0007he-Mf
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 08:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649AbZC0H4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 03:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754422AbZC0H4X
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 03:56:23 -0400
Received: from main.gmane.org ([80.91.229.2]:41830 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806AbZC0H4W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 03:56:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ln6vK-0002rW-E9
	for git@vger.kernel.org; Fri, 27 Mar 2009 07:56:18 +0000
Received: from c-10a5e155.260-1-64736c10.cust.bredbandsbolaget.se ([85.225.165.16])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 07:56:18 +0000
Received: from jonas.floden by c-10a5e155.260-1-64736c10.cust.bredbandsbolaget.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 07:56:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-10a5e155.260-1-64736c10.cust.bredbandsbolaget.se
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <22735968.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114869>

bggy wrote:
> Hello, I'm new to git and I haven't been able to create commit messages in
> either vim or textmate(changed core.editor to mate).  I can create commit
> messages when I use the -m option, but I like creating multiple-line
> messages and it's easier to do it with a fresh line-break in the terminal.
> 
> Using textmate I saved and closed the textmate file that pops up after $git
> commit -a, but git responds that the commit was terminated due to an empty
> message.
> 

Hi there,
For TextMate to work with Git you need to add the option -w to "mate"
which will specify that it should wait for the file to be closed.

So set EDITOR="mate -w" and it should work with TextMate.


With regards,
Jonas
