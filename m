From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 01 Jan 2007 22:32:55 -0800
Message-ID: <7vzm92x7jc.fsf@assigned-by-dhcp.cox.net>
References: <20070102001044.GB32148@fieldses.org>
	<65526.67561.qm@web31806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 02 07:33:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1dCn-0005iC-Fu
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 07:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281AbXABGc6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 01:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755282AbXABGc6
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 01:32:58 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:38989 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbXABGc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 01:32:58 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102063257.IGAZ7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jan 2007 01:32:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 66Y91W00K1kojtg0000000; Tue, 02 Jan 2007 01:32:10 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <65526.67561.qm@web31806.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Mon, 1 Jan 2007 17:28:15 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35773>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- "J. Bruce Fields" <bfields@fieldses.org> wrote:
> ...
>> Remote branches are stored in separate namespaces under
>> .git/refs/remotes/, so that they don't muck up your view of your local
>> branches, and so git can enforce different policies for them (such as
>> forbidding committing to them).
>
> Smells like another "newbie" protection.
>
> Let me understand, someone here installed git, didn't read the then
> man page of git-clone/pull/fetch, screwed up their repo, and decided
> to change established behavior.

You smelled and understood wrongly in this case.  Another point
in separate-remote layout is that it makes it easier to interact
with more than one remotes, and we do not have to treat 'master'
and 'origin' as branch names any more specially than necessary.
