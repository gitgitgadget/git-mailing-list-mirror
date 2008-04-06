From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I set the committer with cherry-pick? (or is there a
 better way to get changes from someone?)
Date: Sat, 05 Apr 2008 18:18:45 -0700
Message-ID: <7vwsnbu6fe.fsf@gitster.siamese.dyndns.org>
References: <810a540e0804051642r79dc10a7h2a231561062b13ea@mail.gmail.com>
 <7vhcefvoeg.fsf@gitster.siamese.dyndns.org>
 <810a540e0804051758j5daea9a8vfe36396ecbb36a08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Pat Maddox" <pergesu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 03:20:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiJYB-000463-9V
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 03:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbYDFBTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 21:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbYDFBTB
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 21:19:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbYDFBTA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 21:19:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 85D406387;
	Sat,  5 Apr 2008 21:18:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DA5A46385; Sat,  5 Apr 2008 21:18:52 -0400 (EDT)
In-Reply-To: <810a540e0804051758j5daea9a8vfe36396ecbb36a08@mail.gmail.com>
 (Pat Maddox's message of "Sat, 5 Apr 2008 17:58:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78874>

"Pat Maddox" <pergesu@gmail.com> writes:

> And finally, when I experimented with doing a pull instead of
> cherry-pick, it listed the original author as the committer instead of
> myself.  I think you're absolutely right that the burden should be on
> them, so I can tell them to create a clean commit branch and just pull
> from it, but I still need to be listed as the committer.

Well, at that point, you are not the committer for their changes on their
clean history, and you shouldn't expect to be recorded as such.  Your
contribution to the project might still be recorded as the committer of
the merge commit that pulled their contributions in, though.

Any history is just as valid as your integration branch's history.  There
may be hundreds of potential histories in the universe --- each and every
contributor, anybody who clones and plays with the project may create his
own history.  Each contributor in their repository will be commiting their
changes and building their histories.  If one of these alternative
histories is so agreeable for you that makes you happy to pull from it,
that means the creator of that history did extra work to keep it clean (or
rebuilt it to look like clean).  Give the contributor the credit for his
own segment of the history when you merge from him.

Among these many alternate histories, yours may happen to be the one many
people consider more authoritative than others', but other than that, you
are not any more special than them.

That's what distributed means.
