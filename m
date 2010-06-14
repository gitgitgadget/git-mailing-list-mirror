From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Add library for string-specific memory pool
Date: Mon, 14 Jun 2010 06:36:00 -0700
Message-ID: <7v631lbutb.fsf@alter.siamese.dyndns.org>
References: <1276175389-6185-1-git-send-email-artagnon@gmail.com>
 <1276175389-6185-4-git-send-email-artagnon@gmail.com>
 <7vk4q5ictl.fsf@alter.siamese.dyndns.org>
 <AANLkTilr9Qa9RJ3TIaCTgGwgp75TDBZbqRENC41xRFlq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 15:36:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO9pw-0001G5-E4
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 15:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849Ab0FNNgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 09:36:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab0FNNgR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 09:36:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F049BB679;
	Mon, 14 Jun 2010 09:36:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=09tcT02oIG++8VIjGrEu5daAe1k=; b=vqkJtV
	JJXgDzItIiCZ+6kvC1S7kxF2gsTx95fD/3jreG/jaQv7mRwXJ8rjfhwhD71zKw5g
	NyoySwXMzm1DCRwVzoKe4Sgg19kLXKAc+wkgX4Pm74AT9lIIJNfXGcdec9TkyS70
	/fBvKXRNb13LE5FVPeDcXXFA00EFEW1hVtOdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i5GLlo0y9kWLk1UF7USa2Vf2pXTll0/E
	vjD0W2+wmQIGYUEG/4zmQbM/4V5Tad9K25TQJVpknk3WTgi7fhSu62bKkfFnVTnT
	aOeveISvygbZqUSxRhvG+MLO51XOAnJpP4IX2mdMiygMLjoLQmEF1p7tIBmxFQV+
	NVJwTOY5TEg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78ABABB678;
	Mon, 14 Jun 2010 09:36:09 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6706CBB676; Mon, 14 Jun
 2010 09:36:02 -0400 (EDT)
In-Reply-To: <AANLkTilr9Qa9RJ3TIaCTgGwgp75TDBZbqRENC41xRFlq@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon\, 14 Jun 2010 11\:26\:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA82EED4-77B9-11DF-B216-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149092>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I hand-edited the patch in Emacs and expected that diff-mode would
> take care of all this. Apparently, I was wrong- I will investigate
> this problem further,...

The problem with Emacs diff mode I already know about.  It gets confused
by the "-- SP LF" line at the end of the format-patch output when it
recounts diff.

> And thanks for getting the series into `pu`! Now I can focus on
> figuring out the SVN API.

Don't thank me.  You did all the work with others on the list.

Note that there isn't that much difference between being in 'pu' and being
in the mailing list archive.  Depending on how further discussions go, the
series can be replaced with an improvement or even can be dropped as a
whole.
