From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Wed, 17 Mar 2010 12:23:21 -0700
Message-ID: <7vfx3yiwgm.fsf@alter.siamese.dyndns.org>
References: <4B67227A.7030908@web.de> <4B898F97.90706@web.de>
 <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de>
 <4b8bf32f.0706c00a.26cb.691d@mx.google.com> <4BA104C7.5020207@web.de>
 <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com>
 <7vaau6q18q.fsf@alter.siamese.dyndns.org> <4BA11D8C.5020007@web.de>
 <7v8w9qkd5z.fsf@alter.siamese.dyndns.org>
 <b4087cc51003171150g303cf1c0uf2e0227594eef3fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 20:24:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NryqB-0005Yj-WE
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 20:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572Ab0CQTXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 15:23:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755552Ab0CQTXd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 15:23:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 51551A201A;
	Wed, 17 Mar 2010 15:23:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2CT3DvKAbKnloETfP15vHWtIPIk=; b=DcXDy/
	o5bNgJJcYhSCDOKRCvgNnt/OnIVO4st63slIOw/p1fL51BwaYcX6JJEVNc4yXsSb
	j/tt2S/9Zh9mNMIVPMY9Y7xISzFrHI25MZ2YfFSGIktCh5yjbiNHVwdhqUkPPIxy
	gV4hgMT5rHSsi0fg1H8CV5VK4YkDEfr4ZYWr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lddH6OZ4w3MIgk/N6qmXqyZqyc5ag77G
	1Ooy75kfxyEsnlaxA8faiIa06A6XOoFOZElM25OuMeLegSLg+99Yfec3LcpLE9LY
	6R2xvzhAaJWwLIWcAgg1YkDHob+kLx1UYilI7GIJP8k0zd24ViM49pWqN5UcPP2U
	iG8W9lWvu/k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D688AA2019;
	Wed, 17 Mar 2010 15:23:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17034A200F; Wed, 17 Mar
 2010 15:23:22 -0400 (EDT)
In-Reply-To: <b4087cc51003171150g303cf1c0uf2e0227594eef3fc@mail.gmail.com>
 (Michael Witten's message of "Wed\, 17 Mar 2010 13\:50\:15 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 90648A46-31FA-11DF-BA41-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142432>

Michael Witten <mfwitten@gmail.com> writes:

> On Wed, Mar 17, 2010 at 13:37, Junio C Hamano <gitster@pobox.com> wrote:
>> such local changes may conflict with the change
>> made between A and B, and stops the command.
>
> I'm sensing that it needs to be clarified what a conflict is.

Hmm, a conflict is "you changed it in one way, and I am trying to change
the same thing in another way, you two have to fight it out".  What other
interpretations are there, especially in a context of SCM?

I wouldn't mind a patch to add the definition to glossary, though.
