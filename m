From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add examples section to 'git fetch' manual
Date: Sun, 13 Apr 2008 18:02:45 -0700
Message-ID: <7vprstb64q.fsf@gitster.siamese.dyndns.org>
References: <20080413093102.GC12107@mithlond.arda.local>
 <20080413093424.GA12861@mithlond.arda.local>
 <7v63uld1nu.fsf@gitster.siamese.dyndns.org>
 <20080413200500.GA5464@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon Apr 14 03:03:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlD6n-0006E9-4E
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 03:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbYDNBC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 21:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754334AbYDNBC7
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 21:02:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbYDNBC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 21:02:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 26A223294;
	Sun, 13 Apr 2008 21:02:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7E02B3292; Sun, 13 Apr 2008 21:02:54 -0400 (EDT)
In-Reply-To: <20080413200500.GA5464@mithlond.arda.local> (Teemu Likonen's
 message of "Sun, 13 Apr 2008 23:05:00 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79445>

Teemu Likonen <tlikonen@iki.fi> writes:

> ... I still feel that refspecs need more
> explaining ...

Perhaps.  The basic syntax is "src colon dst" and they are used to copy
what's in src to dst, and that is pretty much what's there to it.  Some
details such as how the wildcard matching works may be missing from the
description part of the manual, and filling them in would be a good idea.

I however strongly suspect that what new people need to get explained may
not be what the mechanism does (e.g. copies the object name recorded as
the src ref to the dst ref), nor the syntax you use to tell the mechanism
what to copy where (e.g. src is LHS, dst is RHS, copying "emptyness" into
dst means deleting dst).  I actually think that is an easier part.

What is more important is the basic concepts like what a ref is, how they
can be used and what you can do with them --- understanding of which would
be essential in being able to decide when and how you maywant to keep a
copy of ref you get from elsewhere and under what name.  I think tutorial
is the best place, and then the description section of the manual the
second best one, to document that kind of things.
