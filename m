From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation/remote-helpers: Add invocation and see
 also  sections
Date: Mon, 05 Apr 2010 15:28:02 -0700
Message-ID: <7v8w91mt59.fsf@alter.siamese.dyndns.org>
References: <f3271551003282104v384d2dc7qe0d3c092c01bc505@mail.gmail.com>
 <7vljd1mu48.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 00:28:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nyuml-0008K2-2D
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 00:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756749Ab0DEW2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 18:28:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756439Ab0DEW2k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 18:28:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 32F34A8C99;
	Mon,  5 Apr 2010 18:28:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QPiv9aRTHj3dI+aJqe4SKRtszPk=; b=w20Luk
	oNOmy3MIg5Trm8aMFNSS3mEgdtaP1BPOHKNKaUM5r+9E0wUpPrwVt/oUBCpPLgBr
	jZExiBOa+VZLHyVq/xHc6I7316NGgt24LrhOs5Zc7jz6Y7vTXvvVTIOelcklHr2O
	ITSu8vZR3QNUeRo7CVyNU8Rf+XePsMwe9kV1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GLpc62E1mkLuMRLmda8IbYNTxaUiqxRD
	uGCAG5l0PM97f3znUAXoO9k3VnT2pN6fp9wvRnbPvCvyH2LCurz/VsAZWTH3mUNY
	ai46ufpVX7TiCKLHnQ7CDJPqcOWSY4rR202QFtLu1/gA2qeoN3IXMrGjv4bHFTkF
	iYQ0hcqbglY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 635D2A8C82;
	Mon,  5 Apr 2010 18:28:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50A34A8C70; Mon,  5 Apr
 2010 18:28:03 -0400 (EDT)
In-Reply-To: <7vljd1mu48.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 05 Apr 2010 15\:07\:03 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8C33CC0E-4102-11DF-98A9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144071>

Junio C Hamano <gitster@pobox.com> writes:

>> +INVOCATION
>> +----------
>> +
>> +These programs can always be invoked as 'git remote-<transport>' by
>> +the end user.
>
> That directly contradicts with what you wrote in the other [1/2] patch to
> the same file, where you said "are normally not used directly by end
> users".

Scratch this comment; you are already up to v4.  Sorry.
