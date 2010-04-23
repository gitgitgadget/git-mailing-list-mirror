From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 17:01:41 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004231639180.7232@xanadu.home>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock> <87wrvzs590.fsf@frosties.localdomain>
 <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
 <87sk6n4426.fsf@frosties.localdomain>
 <alpine.LFD.2.00.1004221651590.7232@xanadu.home>
 <87vdbitu9v.fsf@frosties.localdomain>
 <25441792-181D-456D-8182-F33B49209EFF@wincent.com>
 <87aastx6sa.fsf@frosties.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Wincent Colaiuta <win@wincent.com>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 23 23:01:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5Q0Y-0007OU-NW
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 23:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687Ab0DWVBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 17:01:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36527 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831Ab0DWVBn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 17:01:43 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L1C00J4ZL2TME40@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 23 Apr 2010 17:01:42 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <87aastx6sa.fsf@frosties.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145641>

On Fri, 23 Apr 2010, Goswin von Brederlow wrote:

> I personaly have to work with different SCMs every day and every time I
> have to switch minds to work with each specific one. Making git commit
> work less surprising would be one less thing to keep in mind.

Please make yourself some git aliases and your problem will be solved.  
After all, the alias mechanism was created for a reason.

> You like that Git is different so don't use the --a-if-empty option. You
> will have lost nothing by allowing that option in. So far I have read
> arguments from people saying they don't want to USE the option. But no
> arguments why there could not be such an option. And I'm not the only
> one that would welcome such an option. Is there no room for a compromise?

I suggest you have a look at all the examples (some are simple, some are 
complex) here: https://git.wiki.kernel.org/index.php/Aliases. It should 
be simple to make an alias with all the safety valves you might think 
of, and then it could even be contributed to section 7 of that page.


Nicolas
