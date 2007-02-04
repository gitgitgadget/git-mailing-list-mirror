From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/8] bash: Remove short option completions for branch/checkout/diff.
Date: Sun, 04 Feb 2007 02:49:48 -0800
Message-ID: <7vr6t6rycz.fsf@assigned-by-dhcp.cox.net>
References: <20070204073817.GA17603@spearce.org> <eq4ccg$9ae$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 11:49:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDewS-0006Cc-5E
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 11:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbXBDKtu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Feb 2007 05:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbXBDKtu
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 05:49:50 -0500
Received: from fed1rmmtai18.cox.net ([68.230.241.41]:34788 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752274AbXBDKtu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Feb 2007 05:49:50 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204104950.NXBA1302.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Feb 2007 05:49:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KNpo1W00C1kojtg0000000; Sun, 04 Feb 2007 05:49:49 -0500
In-Reply-To: <eq4ccg$9ae$1@sea.gmane.org> (Jakub Narebski's message of "Sun,
	04 Feb 2007 11:27:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38684>

Jakub Narebski <jnareb@gmail.com> writes:

> [Cc: git@vger.kernel.org]
>
> Shawn O. Pearce wrote:
>
>> The short options (-l, -f, -d) for git-branch are rather silly to
>> include in the completion generation as these options must be fully
>> typed out by the user and most users already know what the options
>> are anyway, so including them in the suggested completions does
>> not offer huge value. =A0(The same goes for git-checkout and git-dif=
f.)
>
> Not true. It is nice to have on "git branch -" TAB TAB list of all=20
> (well, all included in completion) short options to git-branch.
>
> So I'd vote NAK.

Ah, sorry, but it's already done.

I tried "git branch <TAB>" and saw hundreds of possibilities
offered, and thought mixing -d/-l and friends are useless.  I
didn't think of the possibility of saying "git branch -<TAB>".

Presumably it was trying to suggest the <start-point> argument
but that does not make much sense actually either.
