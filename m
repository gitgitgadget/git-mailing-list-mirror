From: Thien-Thi Nguyen <ttn@gnuvola.org>
Subject: Re: reflog weirdness
Date: Fri, 28 Dec 2007 23:44:34 +0100
Message-ID: <87fxxme8x9.fsf@ambire.localdomain>
References: <87ve6iegny.fsf@ambire.localdomain>
	<7vhci2ectr.fsf@gitster.siamese.dyndns.org>
	<87prwqec4a.fsf@ambire.localdomain>
	<7vtzm2cwbw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 23:46:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8Nyg-0001Fb-0h
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 23:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbXL1WqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 17:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbXL1WqZ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 17:46:25 -0500
Received: from ppp-88-39.21-151.libero.it ([151.21.39.88]:60979 "EHLO
	ambire.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752483AbXL1WqY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 17:46:24 -0500
Received: from ttn by ambire.localdomain with local (Exim 4.63)
	(envelope-from <ttn@gnuvola.org>)
	id 1J8NwQ-0004x9-Tg; Fri, 28 Dec 2007 23:44:34 +0100
In-Reply-To: <7vtzm2cwbw.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 28 Dec 2007 14:01:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69301>

() Junio C Hamano <gitster@pobox.com>
() Fri, 28 Dec 2007 14:01:55 -0800

   Was it a buggy "git commit" command, or a bad commit log
   message was fed to "git commit" by the user, and there is
   nothing for me to worry about?

i'm sorry, even though it was only a couple days ago, the actual
events are far back in my memory, so i can't say.  i wouldn't
worry about it -- probably user error.  (i'm new w/ git.  most of
the time i drive it from w/in emacs, which is well behaved; it is
when i leave that comparative safety to do some flailing from the
command-line that things go weird.)

i suppose one way to improve git would be to test how it handles
interruption (control-c in the middle of a commit, for example).
a bit tricky to arrange (reproducibly), though...

now i go search the docs for how to replace that log message.

thi
