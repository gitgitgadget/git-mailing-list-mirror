From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: new 'add-envelope' option
Date: Sun, 22 Nov 2009 08:42:25 -0800
Message-ID: <7v4oomjytq.fsf@alter.siamese.dyndns.org>
References: <1258825410-28592-1-git-send-email-felipe.contreras@gmail.com>
 <20091121193600.GA3296@coredump.intra.peff.net>
 <94a0d4530911211159l1fadad0ldb0d760439ceb57@mail.gmail.com>
 <7v1vjrmfjw.fsf@alter.siamese.dyndns.org>
 <94a0d4530911220403w7238dab7saf18830a89f2add5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 17:42:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCFWP-0001l4-Du
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 17:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316AbZKVQmc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 11:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755275AbZKVQmb
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 11:42:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50190 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202AbZKVQmb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Nov 2009 11:42:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4350C82A04;
	Sun, 22 Nov 2009 11:42:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=l5tO2DiKX576
	IV2wS3UuZvISu+M=; b=ot10fDrEGuJyGmp1Jurmw3GZzIsXLnVngQNONYhYYSaU
	ZHkPDfL+zVfc7OyMqDgKuFZbrYvEA9OqPaN1fXkGwNWPBr767nRIktgT0dc/9Q52
	qLDyMJ9eqSZo8u9bKzIgaRpqhKDnrtGf2RbcEBq+I0APmEak8s833vlhKtfZN6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kYBmDj
	LHT3BiZUUjWydMIeK69tsR5oaxy7NMvFFToRP674nbTMWUJGnMDV4sWuEQCYm9RL
	nVvp9LwnI1HfLR5SRF2CH7owZI2wt3DQGvGAo0tCW1YjWoRlbt4CxpgnJ/SjIOBk
	RiqExrDH/5KQ7bfQcrMEJsRZpaDDIrVOu4RhI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2850482A03;
	Sun, 22 Nov 2009 11:42:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6508282A00; Sun, 22 Nov
 2009 11:42:27 -0500 (EST)
In-Reply-To: <94a0d4530911220403w7238dab7saf18830a89f2add5@mail.gmail.com>
 (Felipe Contreras's message of "Sun\, 22 Nov 2009 14\:03\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 07090A34-D786-11DE-8325-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133443>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

>> I do use --envelope-sender when sending patches out via msmtp. =C2=A0=
What
>> wonderful things this patch adds am I missing in my current setup?
>
> You need to specify your mail address when setting the variable, righ=
t?
> I use multiple email addresses, so that when I change it ($EMAIL or
> user.email) the right one will be used in the envelope. If I use
> 'sendemail.envelopesender' I would need to change it as well.

Ahh, I see.  The above would be a good addition to the documentation pa=
rt
of the patch.
