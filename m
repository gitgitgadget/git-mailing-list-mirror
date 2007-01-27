From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/4] Teach git-describe to display distances from tags.
Date: Sat, 27 Jan 2007 00:47:13 -0800
Message-ID: <7v4pqcluum.fsf@assigned-by-dhcp.cox.net>
References: <a23c4e55ca5c09f742fa2a047e45613e7797e720.1169880681.git.spearce@spearce.org>
	<20070127065413.GC10380@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 09:47:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAjDS-000692-DG
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 09:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbXA0IrP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 03:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbXA0IrP
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 03:47:15 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:64787 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbXA0IrO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 03:47:14 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070127084714.EXGB16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sat, 27 Jan 2007 03:47:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id G8mG1W00F1kojtg0000000; Sat, 27 Jan 2007 03:46:16 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37935>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net>:
>> However, I suspect that we could do better with Shawn's new
>> fangled describe implementation that actually counts the
>> distance between what is described and the tag.  We could add
>> "number of commits since the tag" somewhere, to describe:
>>
>>   v2.6.20-rc5-256-g419dd83
>>   v2.6.20-rc5-217-gde14569
> ...
>     v2.6.20-rc5+256-g419dd83
>     v2.6.20-rc5+217-gde14569
>
> The + format is much easier to read and understand than the - format
> original proposed by Junio.

I tend to disagree (I do not claim + is _less_ easier to read,
though).

They are of comparable readability, and I think plus breaks
GIT-VERSION-GEN (the primary reason it replaces '-' to '.' is
to work around RPM limitation IIRC, and I do not know what '+'
does to RPM offhand).

But I do not have a strong feeling either way.
