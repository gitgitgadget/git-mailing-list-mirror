From: Junio C Hamano <gitster@pobox.com>
Subject: Re: trailing whitespace problem
Date: Tue, 02 Oct 2007 11:54:08 -0700
Message-ID: <7vk5q5l54f.fsf@gitster.siamese.dyndns.org>
References: <b41dbf4a0710020507va40ef83u50c88094f8c2823b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "lode leroy" <lode.leroy@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 20:54:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcmtU-0003bB-1V
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 20:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756686AbXJBSyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 14:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755095AbXJBSyS
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 14:54:18 -0400
Received: from rune.pobox.com ([208.210.124.79]:53224 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754284AbXJBSyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 14:54:16 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 4672C1405E7;
	Tue,  2 Oct 2007 14:54:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B91C01404CB;
	Tue,  2 Oct 2007 14:54:31 -0400 (EDT)
In-Reply-To: <b41dbf4a0710020507va40ef83u50c88094f8c2823b@mail.gmail.com>
	(lode leroy's message of "Tue, 2 Oct 2007 14:07:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59709>

"lode leroy" <lode.leroy@gmail.com> writes:

> when I use git commit -a, I get the following message:
>
> *
> * You have some suspicious patch lines:
> *
> * In src/test.c
> * trailing whitespace (line 60)
> src/test.c:60: }
>
> when I fix the whitespace problem,  and do "git commit -a" again,
> I still get the same message.
>
> Only after adding the file again, with "git add src/test.c",
> I can commit my changes.

Interesting.  Are you doing anything unusual, like "assume unchanged"?

> git version 1.5.3.2 (on cygwin)
>
> ps: not related to CR/LF...
