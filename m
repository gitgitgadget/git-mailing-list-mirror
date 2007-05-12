From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] format-patch stuff
Date: Sat, 12 May 2007 16:03:24 -0700
Message-ID: <7viraxve4j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705121109520.18541@iabervon.org>
	<Pine.LNX.4.64.0705121553300.31357@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun May 13 01:03:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn0cm-00012U-3g
	for gcvg-git@gmane.org; Sun, 13 May 2007 01:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306AbXELXDg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 19:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755346AbXELXDg
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 19:03:36 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:64914 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306AbXELXDf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 19:03:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512230336.JDFF13903.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 19:03:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yP3P1W0031kojtg0000000; Sat, 12 May 2007 19:03:30 -0400
In-Reply-To: <Pine.LNX.4.64.0705121553300.31357@asgard.lang.hm>
	(david@lang.hm's message of "Sat, 12 May 2007 15:54:28 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47107>

david@lang.hm writes:

> On Sat, 12 May 2007, Daniel Barkalow wrote:
>
>> It would be nice if git-format-patch would generate a [PATCH 0/n] message
>> at the start of the series if some option were given. This would, of
>> course, have to be editted afterwards to include actual information, but
>> it would at least be pre-generated in series and with the configured
>> headers and such.
>
> instead of the 0/n message be empty, have it start off listing the
> subject lines of the patches to follow (makeing it easier to add any
> comments about them)

Sounds sane.  "git-format-patch -n --cover origin..master"?
