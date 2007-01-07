From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-reset --hard: use quotes when we tell the user what HEAD was reset to
Date: Sun, 07 Jan 2007 13:10:59 -0800
Message-ID: <7vfyam1r18.fsf@assigned-by-dhcp.cox.net>
References: <20070106102322.7468.57615.stgit@c165>
	<7v8xgg553u.fsf@assigned-by-dhcp.cox.net>
	<4c8ef70701070456k2f0585f4ga6c35bd77c939c59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 22:11:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3fIH-0001jR-Mk
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 22:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbXAGVLB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 16:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbXAGVLB
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 16:11:01 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:34566 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965169AbXAGVLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 16:11:00 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070107211059.ZMMH19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Sun, 7 Jan 2007 16:10:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8MAA1W0051kojtg0000000; Sun, 07 Jan 2007 16:10:10 -0500
To: "Fredrik Kuivinen" <frekui@gmail.com>
In-Reply-To: <4c8ef70701070456k2f0585f4ga6c35bd77c939c59@mail.gmail.com>
	(Fredrik Kuivinen's message of "Sun, 7 Jan 2007 13:56:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36198>

"Fredrik Kuivinen" <frekui@gmail.com> writes:

>> >     I think we need to delimit the name better, probabally we need to quote
>> >     it.  Perhaps something like:
>> >
>> >     HEAD is now at ac9c110: "git-fetch: remove .keep file at the end".
>> ...
> I don't think the second point is much of an issue. Is it really that
> irritating to
> read a word-wrapped line of text? I agree with the first point though, in most
> cases it will not be a problem in other projects.
>
> I still think it is worth doing it, but it certainly isn't super
> important. Feel free
> to drop the patch if you want to.

I do not care much either way, but the third point is that the
quoted output would look "interesting" if the original title
text has double-quoted words.  I.e.

    HEAD is now at 9945d98: "Add "--cacheinfo" option to update-cache."

Notice also your hand-wrapped example has the final full-stop
outside the quote, which your patch would not produce ;-).
