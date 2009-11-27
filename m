From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Give the hunk comment its own color
Date: Thu, 26 Nov 2009 23:27:40 -0800
Message-ID: <7v4oogwhoz.fsf@alter.siamese.dyndns.org>
References: <1258543836-799-1-git-send-email-bert.wesarg@googlemail.com>
 <20091118142320.GA1220@coredump.intra.peff.net>
 <7vaayjebu5.fsf@alter.siamese.dyndns.org>
 <36ca99e90911260405y42a9a07cx419d2973ec673039@mail.gmail.com>
 <7v4oogzo74.fsf@alter.siamese.dyndns.org>
 <20091127065202.GD20844@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 08:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDvFG-00044P-K7
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 08:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbZK0H1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 02:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751971AbZK0H1r
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 02:27:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbZK0H1q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 02:27:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 44477A1E5F;
	Fri, 27 Nov 2009 02:27:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fsPEAie5xtjg7GccBXddta5Dwf4=; b=RXtUzs
	nPk6bDLQG9l7sH9CrEFAR+QlifxFyO54yb0RBK8hOfvSA+tCiE+jzGQWTOn9Du83
	DqQF131rhnDJhHQXgKGDQJeDTFOUUi6XvZfUnZMRM9OwZel2IlqCVF19wuLM5nBp
	C0ByRRu0LbSWwMV5ULhd3SQN//KZQmvVwt/M4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tn5HDnIC4++igg79SGEmQk+MeXiAMYvG
	gPueWBHMya4RrzidIhvqR+KSeM5GdVgnuio9u0KBg+LGiWOXPjIK6vQB54RVRjUY
	Pp3AfpCmb9TVeL+5KiiURa62JoHaPZJ/uzkLHOzgpp7tMIcKo9853mpGAeHf6Esy
	Tv7KyOhkJ5U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F368A1E5E;
	Fri, 27 Nov 2009 02:27:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8E49DA1E5D; Fri, 27 Nov 2009
 02:27:42 -0500 (EST)
In-Reply-To: <20091127065202.GD20844@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 27 Nov 2009 01\:52\:03 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5CCEB088-DB26-11DE-A617-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133868>

Jeff King <peff@peff.net> writes:

> On Thu, Nov 26, 2009 at 06:38:55PM -0800, Junio C Hamano wrote:
>
>> > ... If it is only the nen-existing
>> > consensus of the default color, than please use the die.
>> 
>> If you are having me go find the mail and apply I would probably use
>> "plain" as I suggested.
>
> As the other person in the discussion, I'll just chime in that I also
> think "plain" is the best of the suggested defaults.

Ok, I tweaked the patch locally and applied.

Thanks.
