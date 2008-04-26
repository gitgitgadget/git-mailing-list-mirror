From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Simplify and fix --first-parent implementation
Date: Sat, 26 Apr 2008 12:13:38 -0700
Message-ID: <7vfxt8mntp.fsf@gitster.siamese.dyndns.org>
References: <20080425234556.D60FD5461@aristoteles.cuci.nl>
 <7viqy5o4om.fsf@gitster.siamese.dyndns.org> <20080426115956.GB19558@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sat Apr 26 21:14:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jppr7-00073O-DI
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 21:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759865AbYDZTNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 15:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760056AbYDZTNy
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 15:13:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759720AbYDZTNx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 15:13:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BF7D34D58;
	Sat, 26 Apr 2008 15:13:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EF1D74D57; Sat, 26 Apr 2008 15:13:45 -0400 (EDT)
In-Reply-To: <20080426115956.GB19558@cuci.nl> (Stephen R. van den Berg's
 message of "Sat, 26 Apr 2008 13:59:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80387>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> P.S. No reaction on the other patches means that they're accepted, or do
> I need to resubmit them as well (signed)?

No reaction means just that.  I either haven't looked at them, or after
having looked at them I did not find them interesting enough to comment
on.

The latter does not mean they are rejected, though.  Remember, my review
is NOT the only thing that counts here, other people's review and
comment too here, and it tends to take time.

The proposed commit log message would express why the change was needed.
It would present a use case that is useful (and argue why that use case is
worth supporting), that is not easily supported with the existing code,
and how the patch makes it so.  When I review a patch posted on the list,
here are the things I consider.  This is pretty much personal, and other
people may do things in different order:

 (0) The merit of the patch itself is not obvious from the diff, but there
     is no explanation; or

 (1) The argument to support the use case may not be convincing or may be
     outright wrong; or

 (2) Even if the argument is convincing, the claim that the current code
     does not support it may be false; or

 (3) The patch may not be the right way to support it and there may be
     better ways; or

 (4) The patch may make the new use case supported, but breaks existing
     use cases.

I look at (0) to _guess_ why the submitter thought the patch was a good
idea when I have nothing better to do (but that seldom happens these days)
or the submitter is new to the list.

Patches in (1) and (2) categories may get comments on what the patch tries
to achieve, and for that I do not have to look at the diff.  I tend start
to look at the diff for patches in categories (3) and (4).

The ideal case is obviously:

 (5) The merit of the patch itself is very clear and there is a good
     explanation in the commit log message.
