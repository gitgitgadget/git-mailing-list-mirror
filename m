From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ensimag students projects, version 2013
Date: Tue, 16 Apr 2013 11:16:31 -0700
Message-ID: <7v4nf6mjcw.fsf@alter.siamese.dyndns.org>
References: <vpqobdg515m.fsf@grenoble-inp.fr>
 <CALkWK0nFB1dzmp6yC9XS4ADmWf9tfQYtsSH0K1u0dtBWT0CRNw@mail.gmail.com>
 <vpqzjwzkb4e.fsf@grenoble-inp.fr>
 <CALkWK0m=ZFK_+Za=_JabO4fiGTQ4K-Bxpr1hiZTrL_T4XuZKog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>, Phil Hord <phil.hord@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 20:16:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USAQo-0007Z2-Ff
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 20:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384Ab3DPSQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 14:16:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46047 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550Ab3DPSQd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 14:16:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A1021730D;
	Tue, 16 Apr 2013 18:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gmEzRjF1TJuC3dCZFcR21ViSYt0=; b=Bw/f9q
	Aov4OF0nqoRyB5Y+o1wiNcckLl1rD3NN9E0Q1i0AjnAb7tWLzy2TlEWEdcU+tUs9
	QJHBbeB7Goc3W5rBYaVEnZTnj3esullpiuVYjbSYedtP8FiGb87WoMCS1B5ti/zj
	kqHiUEreX4FVthtFQOW8fR5nbWDnf8Z8Omr/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yJlq96N3l+cBMrHnCiglQ7V3MO/A+1JE
	0DrRnSD+vCaJ1hRUWCRc/xaiLk3vb4sDoi902JLM4FX1MSrlxt3xUXGQMvqiwucf
	HIx1LaKn+MgdCD7L3gCGb9KLLPhWK6OfBKD13OV+6oNoV3Hptu3FIoH3jH+e6qtp
	PMszN1s95sk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D3A11730B;
	Tue, 16 Apr 2013 18:16:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87AE517309; Tue, 16 Apr
 2013 18:16:32 +0000 (UTC)
In-Reply-To: <CALkWK0m=ZFK_+Za=_JabO4fiGTQ4K-Bxpr1hiZTrL_T4XuZKog@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 16 Apr 2013 12:54:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C43B6DA0-A6C1-11E2-8092-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221444>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Matthieu Moy wrote:
>> I tend to agree with you, but the idea has explicitly been rejected in
>> the past. The problem with an option like this is that it would also
>> disable the advices that may be added in the future. By letting people
>> disable the advices one by one, people see new advices as they arrive.
>> You may think of it like "do not show this message again" tickboxes in
>> some graphical user interfaces.
>>
>> Too controversial area for newcommers I guess ;-).
>
> This is the kind of nonsense that I absolutely won't stand for.  Am I
> a less important customer than a newcomer?

Who said anything about a customer?

A newcomer to a community (i.e. Matthieu's student) needs not just
to show technical excellence with patches, but needs to make a good
argument on a larger design decision; old timers already tried to
achieve a concensus on it, and did not manage to do so the last time
we tried.

It is a tough topic for a newcomer developer to tackle.
