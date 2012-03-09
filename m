From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push default behaviour?
Date: Fri, 09 Mar 2012 09:44:55 -0800
Message-ID: <7v7gyt7joo.fsf@alter.siamese.dyndns.org>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
 <87k42vs8pi.fsf@thomas.inf.ethz.ch>
 <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
 <1331202483.21444.11.camel@beez.lab.cmartin.tk>
 <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
 <1331203321.21444.13.camel@beez.lab.cmartin.tk>
 <4F58C977.8000400@xiplink.com> <vpq62efjeqd.fsf@bauges.imag.fr>
 <CAHkcotiOGaOdDvibpoiEgys3PnSPfSw0mT3DeEOix+FuboULiA@mail.gmail.com>
 <vpqfwdjas0m.fsf@bauges.imag.fr>
 <20120309033826.GA6164@sigill.intra.peff.net>
 <7vsjhi9wku.fsf@alter.siamese.dyndns.org> <vpqobs65gfc.fsf@bauges.imag.fr>
 <7vwr6u6qrn.fsf@alter.siamese.dyndns.org> <vpq4ntyrn3c.fsf@bauges.imag.fr>
 <7vobs57nij.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 09 18:45:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S63sG-0000Ur-Dy
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 18:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab2CIRo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 12:44:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62055 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753Ab2CIRo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 12:44:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30D3873C6;
	Fri,  9 Mar 2012 12:44:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mfJkMwMhTVdf5mi57G8fzS0ynCE=; b=b0u2Vl
	TK7PQSvK7/xCugnyHRAhKxL3NYhjmB2pQToc3xwPAzr2KUlmmLJGfgGR2HBg/dVu
	ljAlN4/Y12O34UZEE0W5vHo/TQnLmyB5MLnb1vNtWr/qaU3kuDifqDHbQzRBQvqw
	ejMXx7Jwt63pCp7TWf2+ukYNy2cDxTws6/M5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PxqbOg4SX5BZIp3TJCBZRStIFYqfWTlJ
	5nOwZNUmGdiKYyo8HmY7WBp0rFubX7xsNL7qyZWBvZf3i9rPKiu7PLxrGxJE+ix3
	kbckHwZ6gOKc9NbJ0axjI1IwL1yXuRwyjH4OH0euVWpQFWRX3SV+xCem9SqUke60
	8raHWvYSx4g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26FD973C5;
	Fri,  9 Mar 2012 12:44:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E97F73C4; Fri,  9 Mar 2012
 12:44:56 -0500 (EST)
In-Reply-To: <7vobs57nij.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 09 Mar 2012 08:22:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95BA57A6-6A0F-11E1-A897-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192730>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> I can send a message saying "[...]" to the kernel list. Anybody could,
>>> for that matter.
>> ...
> But I obviously *WILL* *NOT* be able to do so for *all* communities
> whose members may be negatively affected.

Oh, let's avoid any misunderstanding before it happens.

I am not saying that we need to get involvement only from people who
might like the current default.  If you read the "[...]" part you
omitted from your quote again, you will notice that the RFH message was
carefully crafted to take a neutral position, and solicit input from
both sides, and that was very much on purpose.

I was hoping that the reaction to my reply would be that "let's
change the default" folks to help polishing the wording of the RFH
message further, and post the final one to help spreading the word,
both in the forums of projects that will be helped by the change,
and of those that will be irritated by the change.

I didn't mean to suggest anybody to play politics by asking input
from only one side to skew the discussion, even though it is not
like we will decide by majority vote anyway.  Deciding in favor of
whichever position you happen to like is not the goal. Avoiding user
surprises and unnecessary harm is.

And that is why the lesson the older thread from 1.6.3-1.6.4 era
teaches us is important.
