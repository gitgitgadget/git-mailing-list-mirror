From: Junio C Hamano <gitster@pobox.com>
Subject: Re: reflog weirdness
Date: Fri, 28 Dec 2007 16:06:36 -0800
Message-ID: <7vprwqcqk3.fsf@gitster.siamese.dyndns.org>
References: <87ve6iegny.fsf@ambire.localdomain>
	<7vhci2ectr.fsf@gitster.siamese.dyndns.org>
	<87prwqec4a.fsf@ambire.localdomain>
	<7vtzm2cwbw.fsf@gitster.siamese.dyndns.org>
	<87fxxme8x9.fsf@ambire.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thien-Thi Nguyen <ttn@gnuvola.org>
X-From: git-owner@vger.kernel.org Sat Dec 29 01:07:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8PER-0005Uz-28
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 01:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbXL2AGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 19:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbXL2AGs
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 19:06:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52178 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbXL2AGs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 19:06:48 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 42F02362B;
	Fri, 28 Dec 2007 19:06:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BFD5D362A;
	Fri, 28 Dec 2007 19:06:42 -0500 (EST)
In-Reply-To: <87fxxme8x9.fsf@ambire.localdomain> (Thien-Thi Nguyen's message
	of "Fri, 28 Dec 2007 23:44:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69303>

Thien-Thi Nguyen <ttn@gnuvola.org> writes:

> () Junio C Hamano <gitster@pobox.com>
> () Fri, 28 Dec 2007 14:01:55 -0800
>
>    Was it a buggy "git commit" command, or a bad commit log
>    message was fed to "git commit" by the user, and there is
>    nothing for me to worry about?
>
> i'm sorry, even though it was only a couple days ago, the actual
> events are far back in my memory, so i can't say.  i wouldn't
> worry about it -- probably user error.  (i'm new w/ git.  most of
> the time i drive it from w/in emacs, which is well behaved; it is
> when i leave that comparative safety to do some flailing from the
> command-line that things go weird.)
>
> i suppose one way to improve git would be to test how it handles
> interruption (control-c in the middle of a commit, for example).
> a bit tricky to arrange (reproducibly), though...
>
> now i go search the docs for how to replace that log message.

"git-rebase -i"
