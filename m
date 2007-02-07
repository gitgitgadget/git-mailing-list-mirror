From: Junio C Hamano <junkio@cox.net>
Subject: Re: Deprecation/Removal schedule
Date: Wed, 07 Feb 2007 01:37:44 -0800
Message-ID: <7v64aeb95j.fsf@assigned-by-dhcp.cox.net>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
	<7vsldibfva.fsf@assigned-by-dhcp.cox.net>
	<200702070933.21804.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Mark Wooding <mdw@distorted.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Ericsson <ae@op5.se>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 07 10:38:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEjFk-00061z-A1
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 10:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbXBGJhs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 04:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbXBGJhr
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 04:37:47 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:59304 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161092AbXBGJhq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 04:37:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207093745.FCTV1343.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 04:37:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LZdk1W00U1kojtg0000000; Wed, 07 Feb 2007 04:37:45 -0500
In-Reply-To: <200702070933.21804.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 7 Feb 2007 09:33:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38902>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> In 1.5.0, you will still see git-resolve and git-diff-stages,
>> but they will be removed by 1.5.1.
>
> Well, it is not as if we cannot obtain equivalent of git-diff-stages
> without this command. Stages are <ours>, <theirs> and <ancestor>
> (git-merge-base <ours> <theirs>) so I think we can use git-diff-tree
> with appropriate arguments...

Well, sorry for wasting the bandwidth if it was not obvious from
my message, but that's exactly why I am announcing officially
that they *will* be removed with a definite timeframe.
