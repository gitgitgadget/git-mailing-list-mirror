From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 12:09:46 -0700
Message-ID: <7vmykhr6h1.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
 <7v7iblsnfh.fsf@gitster.siamese.dyndns.org>
 <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 21:12:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJCOs-0008KD-Eg
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbYGPTJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 15:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754149AbYGPTJz
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 15:09:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790AbYGPTJz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 15:09:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B1E722F83;
	Wed, 16 Jul 2008 15:09:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A2FB922F5F; Wed, 16 Jul 2008 15:09:48 -0400 (EDT)
In-Reply-To: <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
 (Avery Pennarun's message of "Wed, 16 Jul 2008 14:51:30 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C5635224-536A-11DD-A56A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88719>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> svn avoids these excess merges by default, albeit because it puts your
> working copy at risk every time you do "svn update".

By default?  As if it has other mode of operation.

Of course if you do not allow any commits in between to make the history
truly forked, you won't see merge commits.  It is like saying that you
like your broken keyboard whose SHIFT key does not work because you think
capital letters look ugly and your keyboard protects you from typing them
by accident.

Is that an improvement?

I won't waste my time further on the apples and rotten oranges comparison,
but you should perhaps listen to Linus's talk where he talks about why it
sucks that SVN/CVS _encourage_ you to keep your local changes uncommitted
for several weeks.

>>  You can skip merges with "git log --no-merges", just in case you didn't
>>  know.
>
> Perhaps this is mostly a user education or documentation issue.  I
> know about --no-merges, but it's unclear that this is really a safe
> thing to use, particularly if some of your merges have conflicts.
> Leaving them out leaves out an important part of history.  Do you use
> this option yourself?

Very rarely.  When I run "git shortlog" for summary, it often is handy,
but otherwise no.
