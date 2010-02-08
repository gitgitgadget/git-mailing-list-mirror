From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: fix Gmail workaround
 advice
Date: Mon, 08 Feb 2010 09:42:55 -0800
Message-ID: <7veikvpqsg.fsf@alter.siamese.dyndns.org>
References: <1265555642-40204-1-git-send-email-git@aaroncrane.co.uk>
 <7v8wb4gaef.fsf@alter.siamese.dyndns.org>
 <bc341e101002071203x52bceaach8d42c6188630f1d1@mail.gmail.com>
 <20100207215311.GA2177@progeny.tock> <20100207221645.GA2862@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Crane <git@aaroncrane.co.uk>,
	Tom Preston-Werner <tom@github.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	John Tapsell <johnflux@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 18:43:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeXdu-0006Va-ED
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 18:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981Ab0BHRnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 12:43:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36604 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab0BHRnT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 12:43:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67CEF9895A;
	Mon,  8 Feb 2010 12:43:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=CVNuBw0GNapE/t3YaQOm5NxrPfs=; b=IuEObELE5sfFImuQA8BJx54
	Kk2tMTDfXBQ8Gagovez3wOatNOmM6D9C8oNFcpdb679f9gGoQ/YgUhFOiCZ/fx+d
	SdiMG1nVfjs9RXEalFE1a7RqxsE/GO7yYKYX94VXtNycts7zUeisVfRTTwBmgEnK
	ReiuPg1qUlNIVhlTgVn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=W/ofJt1/qFfwd5qi+0+NyJaAcISXvmyofNK6+sNzO0vuQJOU1
	oVJKFuIGcKjxSRlXgVRQotASIDwQ3sde8JWDkN1BjtuRHmY35OdAVa36udCm8PZV
	69G3bB3uyW2/EuKvdVxoI1IJOGKLA1eqdmgPCDFlPx8nWknpPVVYNNamq4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C078898956;
	Mon,  8 Feb 2010 12:43:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 508F69894C; Mon,  8 Feb
 2010 12:42:57 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6ADAE5A6-14D9-11DF-9753-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139299>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Scratch that: it looks like it once did.
>
> http://thread.gmane.org/gmane.comp.version-control.git/99721/focus=99775
>
> Tom, any clues?  Are you still able to avoid spurious line wrapping in
> gmail?

The example Tom cites $gmane/99759 does not have long enough lines to be
linewrapped, so perhaps the problem was there from day one but was not
noticed.

I just tried it myself (I don't even regularly use Gmail), following the
procedure outlined in SubmittingPatches.  It does look like Gmail web
interface mangles longer lines in the message.
