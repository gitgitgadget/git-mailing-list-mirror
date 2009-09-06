From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] push: make non-fast-forward help message
 configurable
Date: Sun, 06 Sep 2009 00:30:14 -0700
Message-ID: <7vocpoh6nt.fsf@alter.siamese.dyndns.org>
References: <20090906064454.GA1643@coredump.intra.peff.net>
 <20090906064816.GC28941@coredump.intra.peff.net>
 <7v8wgsk0rw.fsf@alter.siamese.dyndns.org>
 <20090906072322.GA29949@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 06 09:30:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkCCt-0004iw-BF
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 09:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644AbZIFHab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 03:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754663AbZIFHaa
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 03:30:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbZIFHa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 03:30:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 777FB27EE0;
	Sun,  6 Sep 2009 03:30:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kq298QuP/Gxy9t1zNLuS/hiMFJo=; b=crzL1+
	UvRP5qHo7tCf+irtJ7o57xjUxF4fhk+O312EHJRew5MmItWsc3QdLmEH51fWuuYm
	olXOacU8HFyF1MEiNvcUWT4r/ItjL3Z6y/Dn1xE13cEm36ZOjXGsRT21g9eL7bP5
	1WVr6+7fSAWaHTeboJ4K93bB741o+qH1pYz18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dYOJfhUUYPLGZCU/ZXlYmwCax/o//BCN
	WMthpeZylx6uVlXb0Bwae3m6SszrQN4e+OiCYNUnwW4n/PnJyblPa3W920GuWonU
	24E0dQvXw0g4gWPPmD6sjdym3viCPeDTKlIviMRCjIOSE4HCE5ioJaZqXVlZWQyF
	9/3ER5IJYZs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3803B27EDF;
	Sun,  6 Sep 2009 03:30:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0F6C27EDB; Sun,  6 Sep
 2009 03:30:15 -0400 (EDT)
In-Reply-To: <20090906072322.GA29949@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 6 Sep 2009 03\:23\:22 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 24A2D996-9AB7-11DE-AA20-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127842>

Jeff King <peff@peff.net> writes:

> I'll re-roll 3 and 4 based on that, but I will wait a bit to see any
> more comments. Probably you should consider patches 1 and 2 as a
> potential series for 'maint', and 3 and 4 should be spun off into their
> own series (they really only rely textually on the first two).

Yeah, thanks.

And no need to hurry.  I've decided to queue 1 and 2 to 'master' (was
Nana's reroll of Matthieu's patch on 'maint'???) and 3 and 4 merged to
'pu', but I seem to be having a problem ssh'ing into k.org, and it appears
that no pushout will happen tonight.
