From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git archive without path
Date: Mon, 30 Nov 2009 08:35:57 -0800
Message-ID: <7vljhootqq.fsf@alter.siamese.dyndns.org>
References: <20091130123203.GA11235@dpotapov.dyndns.org>
 <4B13C2FE.3040707@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 17:36:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF9EW-0007B9-0n
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 17:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbZK3QgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 11:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbZK3QgD
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 11:36:03 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbZK3QgC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 11:36:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B006B84897;
	Mon, 30 Nov 2009 11:36:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tZprjT1HS1AtZIJoSN/VDfDzY00=; b=n5n+hQ
	wY1AY6u48c1BrsBRG4cX6xH//mRmFqYUtoNjF5HsuFZM6jXLCTQ2Y6O4hGG78Xs9
	JC1mHAd98GTUlKRVzsXNfDQM9gZksAm8KlKYnBnUuFL0bkkvVdPEiKCfZ/0+4SzR
	MoRgu9YqitBgegS56qbVKAhyXraCdY/DC2T9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cSmuHx4gYOSzzeCjSqGc+cDlcBPOGbat
	S20daL1iDBiU4c9RWoH57U36Smvd96MiQ7JY767VNNnAjp3uwAA8Y0D6TfYT7mER
	KKLjgPiXPkz/vRIxppeqCW5y9Nrw3608F3AWqE9F6MQ/SFqF6nkXypEK5ukYUBs4
	LgILxbho61s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CE2B84894;
	Mon, 30 Nov 2009 11:36:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CA3B84892; Mon, 30 Nov
 2009 11:35:59 -0500 (EST)
In-Reply-To: <4B13C2FE.3040707@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon\, 30 Nov 2009 14\:05\:02 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7328BEBE-DDCE-11DE-8E18-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134118>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Depends on the definition of "all" :)
>
> In fact: Two mighty powers are fighting right now for the primacy in the
> Land of the Git, and both carry the name "consistency" on their flags.
> One is the "order of the consistency of generations", also named
> "backwards compatibility", and one is the "order of the consistency of
> commands", also named "user experience".

You need to throw in another "work similarly to the counterpart outside
git world" and you will have a better picture.  This third consistency
often sides with the first one.

In the case of "git archive" (and "git grep" in the other thread), it
works like you run "tar" (and "grep -r", for "git grep") both because the
original implementor wanted a version of "tar" ("grep") that works inside
git world, and early adopters and users found the third consistency easy
to work with, and that is why the third consistency grew into the first
one.
