From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
 state
Date: Wed, 14 Jan 2009 16:43:14 -0800
Message-ID: <7vfxjlxuu5.fsf@gitster.siamese.dyndns.org>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Thu Jan 15 01:44:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNGLl-0007oZ-JP
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 01:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760579AbZAOAnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 19:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759198AbZAOAnW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 19:43:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758316AbZAOAnW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 19:43:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A35B9091D;
	Wed, 14 Jan 2009 19:43:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 26DEA9091A; Wed,
 14 Jan 2009 19:43:16 -0500 (EST)
In-Reply-To: <87ab9th0rh.fsf@cup.kalibalik.dk> (Anders Melchiorsen's message
 of "Thu, 15 Jan 2009 01:27:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 82120C50-E29D-11DD-B98B-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105744>

Anders Melchiorsen <mail@cup.kalibalik.dk> writes:

> I always have a hard time figuring out what to do during an
> interactive rebase. Recently, it dawned on me that the reason is that
> I have to do different things: one thing when editing on purpose, and
> a different thing when resolving a conflict. So my fingers never learn.
>
> With this change, I propose to make the UI more uniform. I think that
> the new way is more intuitive, too, if you will agree that a Git UI
> can be intuitive.
>
> As I expect this to not be acceptable due to compatibility concerns, I
> have not tested it much. The patch is mostly to catch some attention,
> but I will be happy to complete it if there is interest in the change.
>
> It was surprising for me to find the needed code already present. Now
> I know that I do not have to do "git commit --amend", it will happen
> automatically if I add some files. That trick alone is worth the time
> that I have spent on this :-).

We may need a version bump to 1.7.0 to update the UI for this command, but 
please do test rigorously to build a stronger case for a saner UI.

I've always had trouble with the instruction we give for splitting one
commit into two using the interactive rebase in the documentation, as it
always had a strong "Huh?" effect on me when it suddenly starts talking
about doing a "git reset HEAD^"; I suspect your change may improve this
situation quite a bit.
