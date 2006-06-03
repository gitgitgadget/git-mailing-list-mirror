From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: Gitk feature - show nearby tags
Date: Sat, 3 Jun 2006 17:12:40 +0200
Message-ID: <20060603151240.GA4024@diku.dk>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com> <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 03 17:12:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmXnz-0005vv-81
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 17:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWFCPMn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 11:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWFCPMn
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 11:12:43 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:42176 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750947AbWFCPMn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 11:12:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 32D46770029;
	Sat,  3 Jun 2006 17:12:42 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13371-08; Sat,  3 Jun 2006 17:12:40 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id DF21777000E;
	Sat,  3 Jun 2006 17:12:40 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A40AE6DF8C8; Sat,  3 Jun 2006 17:09:25 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id C0EB1625C5; Sat,  3 Jun 2006 17:12:40 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21196>

Junio C Hamano <junkio@cox.net> wrote Sat, Jun 03, 2006:
> For a graphical interface like gitk it may not be such a big
> deal (you can always follow the line), but an interface like tig
> that shows commits in a linear fashion it would make a big
> difference in usability.

I already took your hint from the other day on irc and have begun on
implementing this revision graph visualization for tig. :)

The problem is of course to come up with some ascii-art which is both
readable and dense. Below is my mockup of something not using line
graphics, however using line graphics it might be possible to get
something more unambiguos but also more "edgy".

	* [release] Sync docs
	M Merge ...
	|`* [master] Fix spelling
	| * Implement ...
	M | Merge ...
	|`M Merge ...
	| |`* Topic B ...
	| | * Topic B ...
	| * | Topic A
	| * | Topic A
	| *' Update docs
	: :
	M | Merge ...
	|`M Merge ...
	| *`. Topic B ...
	| * | Topic B ...
	| | * Topic A
	| | * Topic A
	| *' Update docs
	: :
	M | Merge ...
	|`M Merge ...
	| *`. Topic B ...
	| * | Topic B ...
	| | * Topic A
	M  `.`. Merge
	|`* | | Update docs

-- 
Jonas Fonseca
