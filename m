From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Mon, 02 Aug 2010 15:47:10 -0700
Message-ID: <7vy6coiqdt.fsf@alter.siamese.dyndns.org>
References: <i372v0$3np$1@dough.gmane.org>
 <m3hbjcptyr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 00:47:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og3nK-0007fJ-PS
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348Ab0HBWr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 18:47:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab0HBWrS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 18:47:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 88DB2C998B;
	Mon,  2 Aug 2010 18:47:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FGoynyaKQ/jMgHowa8xnYwB8gRQ=; b=u7ly/D
	dA4rTTSu4MS0s0Q3sSB/lkVMYxZ0o0MRasj55/WG2T9zSI4sjZqp9VNjNSuJu2TL
	EWgh9pEL0dGGMWHgMMH69+PDzE3HujqT6v2Gpy9grsVHbIghvgLFU7hgQfOFfAwm
	nZMy02e8kFvGfAiO0p+2En2IJ3hsfM5CNuPBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cysHj0RF6y+4D4+Z7DT2Vz7ivKJmJZ3W
	OheklANfHjCGmvrkLzdhZsKxGB31OEqkR2VuFJ1fpJawysRMXNdmWDklutH3cslI
	kUMRClhEy58sd/VZ4J+oWPeOxa/MWomu5qC8D9sjt7ljeyHfwlJuoUXeuYl1GSG6
	PMT6qm52b3o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DE42C9989;
	Mon,  2 Aug 2010 18:47:15 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89C22C9983; Mon,  2 Aug
 2010 18:47:11 -0400 (EDT)
In-Reply-To: <m3hbjcptyr.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Mon\, 02 Aug 2010 14\:48\:32 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E584530E-9E87-11DF-8A91-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152480>

Jakub Narebski <jnareb@gmail.com> writes:

> The headers inside commit (and tag) objects are stored in text form,
> so they are not limited to 32-bit value.  You would have to use system
> that has 64-bit time_t, or patch git.

I thought the internal representation of our time was "unsigned long", no?
How can you represent anything before Unix epoch?
