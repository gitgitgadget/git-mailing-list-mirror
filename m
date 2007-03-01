From: Junio C Hamano <junkio@cox.net>
Subject: Re: defaults for where to merge from
Date: Thu, 01 Mar 2007 00:18:58 -0800
Message-ID: <7vejo9xtot.fsf@assigned-by-dhcp.cox.net>
References: <es450f$d58$1@sea.gmane.org>
	<200702281522.14965.andyparkins@gmail.com>
	<Pine.LNX.4.64.0702281526270.15314@reaper.quantumfyre.co.uk>
	<Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0702281045u2e511ebfie14a7b718531f8c4@mail.gmail.com>
	<45E5DE8A.2080101@lu.unisi.ch>
	<81b0412b0702281607l6f9b1cadg9f3a84b06b9acd7d@mail.gmail.com>
	<Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>
	<45E68897.8000607@lu.unisi.ch>
	<81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bonzini@gnu.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 09:19:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMgVE-00053c-H2
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 09:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932993AbXCAITC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 03:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933001AbXCAITC
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 03:19:02 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43004 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932993AbXCAITA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 03:19:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070301081900.UXTO2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Mar 2007 03:19:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VLJy1W00N1kojtg0000000; Thu, 01 Mar 2007 03:18:59 -0500
In-Reply-To: <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
	(Alex Riesen's message of "Thu, 1 Mar 2007 09:10:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41049>

"Alex Riesen" <raa.lkml@gmail.com> writes:

>> If everyone hated the old behavior, old users should already be careful
>> about not git-pull'ing (without options) from any branch but master.  So
>> they won't see any difference.
>
> except for .git/config growing uncontrollably

I think this should be a new option, not the _modified default_.
Otherwise it would be harder to sell to olde timers.

	$ git checkout -B <newbranch> remotes/<blah>
        $ git branch --track <newbranch> remotes/<blah>

might be a good compromise.
