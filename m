From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Tue, 02 Jan 2007 11:30:38 -0800
Message-ID: <7vtzz9usyp.fsf@assigned-by-dhcp.cox.net>
References: <560316.34562.qm@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Jan 02 20:31:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1pLl-0000vN-A2
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 20:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbXABTam (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 14:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbXABTam
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 14:30:42 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:62633 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964931AbXABTak (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 14:30:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102193039.ZYDZ16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jan 2007 14:30:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6KVs1W00C1kojtg0000000; Tue, 02 Jan 2007 14:29:52 -0500
To: ltuikov@yahoo.com
In-Reply-To: <560316.34562.qm@web31812.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Tue, 2 Jan 2007 10:48:50 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35806>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- Junio C Hamano <junkio@cox.net> wrote:
>> Luben Tuikov <ltuikov@yahoo.com> writes:
>> 
>> > Questions:
>> >
>> > What is the reasonining of defining branch.<name>.merge to point
>> > to the "remote's setup"?
>> 
>> See list archives.  
>> 
>> Because you are not required to use remote tracking branches.
>
> Then why does it point to the _remote_ mapping?  One shouldn't

Because [remote] is NOT about mapping.  It asks the fetch
mechanism to fetch from that remote, so the primary thing you
should look at is .url, not RHS of colon on .fetch lines.  Use
of tracking branches is strictly optional.
