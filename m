From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diff: add custom regular expressions for function names
Date: Wed, 04 Jul 2007 13:44:30 -0700
Message-ID: <7vejjnhpap.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
	<alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 22:44:55 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6BiY-0005eU-Az
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 22:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564AbXGDUoc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 16:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755048AbXGDUoc
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 16:44:32 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:43803 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804AbXGDUob (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 16:44:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070704204431.CEAP1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Jul 2007 16:44:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KYkW1X0041kojtg0000000; Wed, 04 Jul 2007 16:44:30 -0400
In-Reply-To: <alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 4 Jul 2007 11:41:34 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51639>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 4 Jul 2007, Johannes Schindelin wrote:
>> 
>> This patch introduces a config variable diff.functionNameRegexp
>> which replaces the default heuristics.  If the pattern contains
>> a group, the match of this group is used for the hunk header
>> instead of the whole match.
>
> Umm. Shouldn't it be a path-name based attribute instead?
>
> That way you can set it to be different things for different source files 
> in the same repository.. IOW, think mixed Java/C codebases.

Absolutely.  I'll take it from there.
