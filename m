From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: git-svn dcommit should send deltas upstream
Date: Sun, 31 Aug 2008 10:03:53 -0700
Message-ID: <7vsksl2k1y.fsf@gitster.siamese.dyndns.org>
References: <87myj0f3mb.fsf@mid.deneb.enyo.de>
 <20080829082311.GA7128@yp-box.dyndns.org> <87tzd4p1lt.fsf@mid.deneb.enyo.de>
 <87y72dkvq4.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Sun Aug 31 19:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZqMN-0001dP-PS
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 19:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbYHaREB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 13:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753055AbYHaREB
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 13:04:01 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbYHaREA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 13:04:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7CA416F0EA;
	Sun, 31 Aug 2008 13:03:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 70E8F6F0E8; Sun, 31 Aug 2008 13:03:55 -0400 (EDT)
In-Reply-To: <87y72dkvq4.fsf@mid.deneb.enyo.de> (Florian Weimer's message of
 "Sun, 31 Aug 2008 18:14:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CDE685A0-777E-11DD-83F0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94495>

Florian Weimer <fw@deneb.enyo.de> writes:

> * Florian Weimer:
>
>>> It's been too long since I've looked at the SVN TxDelta API, but I
>>> thought SVN::TxDelta::apply would take care of the delta computation for
>>> us...
>>
>> SVN::Git::Editor::M does not seem to make use of the base text.
>
> Here's an attempt at delta generation.  I don't know if it is entirely
> correct, but it does work in the sense that it passes "make test" and
> the test cases I reported eariler.
>
> Sorry for the format.  Has anybody got some Emacs code to submit diffs
> using Gnus?

What's wrong with using "C-x C-i" in the message mode to read format-patch
output in (alternatively "C-u M-! git format-patch --stdout -1 $commit"
in the message mode), move "Subject: " up and remove the remainder of the
fake headers?
