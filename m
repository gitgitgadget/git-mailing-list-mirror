From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Remove obsolete commit-walkers
Date: Wed, 04 Jul 2007 09:57:27 -0700
Message-ID: <7vabuchzt4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707030128110.14638@iabervon.org>
	<7vwsxiroqa.fsf@assigned-by-dhcp.cox.net>
	<18058.17778.692974.122271@lisa.zopyra.com>
	<7vsl84lpo3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707041228290.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 18:57:36 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I68AV-0004iY-30
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 18:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbXGDQ53 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 12:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753958AbXGDQ52
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 12:57:28 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:55798 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbXGDQ52 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 12:57:28 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070704165728.ENAK11062.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Jul 2007 12:57:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KUxS1X00i1kojtg0000000; Wed, 04 Jul 2007 12:57:27 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51624>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Actually these fetch backend shouldn't even be needed by the end
>> users.  "git fetch" simply does not drive them these days.
>
> You forget that this backend is a plumbing component, which might well be 
> used by other porcelains. IIRC cogito uses it, optionally.

You are correct that these plumbing commands can be called by
Cogito, but we are not removing them but merely deprecating
them.  And I thought Cogito itself is deprecated these days,
so...
