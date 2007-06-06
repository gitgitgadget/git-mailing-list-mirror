From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add git-filter-branch
Date: Wed, 06 Jun 2007 01:17:33 -0700
Message-ID: <7vy7ix5wf6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site>
	<4663BCDA.F1BADDD8@eudaptics.com>
	<Pine.LNX.4.64.0706041711500.4046@racer.site>
	<46643F2D.7C896CBC@eudaptics.com>
	<Pine.LNX.4.64.0706041850350.4046@racer.site>
	<46650A58.4934C07C@eudaptics.com>
	<Pine.LNX.4.64.0706051537360.4046@racer.site>
	<466665AD.CF5B85DF@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 10:17:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvqi3-0007mN-10
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 10:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbXFFIRg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 04:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbXFFIRf
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 04:17:35 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:40877 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbXFFIRe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 04:17:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606081734.QJNK1540.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 04:17:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 88HZ1X00E1kojtg0000000; Wed, 06 Jun 2007 04:17:34 -0400
In-Reply-To: <466665AD.CF5B85DF@eudaptics.com> (Johannes Sixt's message of
	"Wed, 06 Jun 2007 09:43:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49263>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> Johannes Schindelin wrote:
>> Okay, then. Are you okay with keeping the same options? (See proposed
>> patch below.)
>
> I can live with it. But what do you think of this in addtion? It
> replaces -k, -r, -s in favor of rev-list arguments.
> ...
> A subset of commits in a branch used to be specified by options (-k, -r)
> as well as the branch tip itself (-s). It is more natural (for git users)
> to specify revision ranges like 'master..next' instead. This makes it so.
> If no range is specified it defaults to 'HEAD'.

FWIW, I find this much more sensible and gittish ;-)
