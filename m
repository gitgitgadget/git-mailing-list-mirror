From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: [PATCH] Removed the printf("rm 'file'") from git-rm.
Date: Sun, 25 Mar 2007 16:38:59 +0000 (UTC)
Message-ID: <pan.2007.03.25.16.39.10@progsoc.org>
References: <11747590062554-git-send-email-tilman@code-monkey.de>
	<7vodmhc06f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 18:39:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVVki-0001Er-JY
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 18:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbXCYQjS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 12:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbXCYQjS
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 12:39:18 -0400
Received: from main.gmane.org ([80.91.229.2]:36781 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbXCYQjS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 12:39:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HVVkH-0000XM-TG
	for git@vger.kernel.org; Sun, 25 Mar 2007 18:39:05 +0200
Received: from user-54463d31.lns2-c12.dsl.pol.co.uk ([84.70.61.49])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Mar 2007 18:39:05 +0200
Received: from wildfire by user-54463d31.lns2-c12.dsl.pol.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Mar 2007 18:39:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: user-54463d31.lns2-c12.dsl.pol.co.uk
User-Agent: Pan/0.125 (Potzrebie)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43058>

On Sat, 24 Mar 2007 23:22:16 -0700, Junio C Hamano wrote:

> Tilman Sauerbeck <tilman@code-monkey.de> writes:
> 
>> We used to print that, because you actually had to run the output of
>> git-rm to get rid of the files before Git 1.5. Now that git-rm really
>> removes the files, it's not needed anymore.
> 
> Even though I admit I do not deeply care, as I never use 'git rm'
> myself, I do not necessarily agree with "because" part.
> 
> I suspect people are by now accustomed to see the assuring feedback from
> the command when used this way:
> 
> 	$ git rm -r one
>         rm 'one/1'
>         rm 'one/2'
>         rm 'one/3'

Heh. I didn't even know there was a recursive option.  So I'm definitely 
not 'accustomed' to any form of output.

If me being a data point helps at all.

Anand
