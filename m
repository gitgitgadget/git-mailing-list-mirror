From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request - discard hunk in add --patch mode
Date: Wed, 15 Aug 2012 11:46:10 -0700
Message-ID: <7vmx1w56z1.fsf@alter.siamese.dyndns.org>
References: <BLU0-SMTP37070ADBEC060E1EA15944693B60@phx.gbl>
 <87txw41okl.fsf@thomas.inf.ethz.ch> <7vvcgk58le.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mina Almasry <almasry.mina@hotmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 15 20:46:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1ibj-0007iQ-3O
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 20:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034Ab2HOSqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 14:46:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48128 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454Ab2HOSqM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 14:46:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C2929C6A;
	Wed, 15 Aug 2012 14:46:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=14Q3WjULyS6is7Gq7DC/K3A9PCc=; b=U1Wbfk
	lqsW44CexAFOqyc5zTlALhxIL8pe4jBABGyfyXthtBbLAAr7UWV+qIFJDHhZsvPS
	UDkRnUNA8eaoPOTYUbZ5xoJCzc2FcZxD8lmw20jngHbMAtbGZUx7SVx1QXD83HoO
	/rxBTCNvd62IMouaFGIZKYdPOpK3oY8JzNV7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Df3oXpsn5OEjVD2Aa42D5I4L/TZIODrG
	OcmE6F/M/qJU2ANw6F3eWQFo+WdDCzGY90vrTLnvhMaYdZbch5rshWpALUVmVpsZ
	/bN50WS/MmMtzok+m7HHYC3MRKUWhFulYPh0IWyOyFVjRwJ2AeOPNlAz5/znuZOp
	apAcsBPn4Ik=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 491C19C69;
	Wed, 15 Aug 2012 14:46:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB1919C68; Wed, 15 Aug 2012
 14:46:11 -0400 (EDT)
In-Reply-To: <7vvcgk58le.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 15 Aug 2012 11:11:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BEDFB26-E709-11E1-AC94-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203484>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> This has come up before, and actually led to the introduction of
>> 'checkout -p' and 'reset -p':
>>
>>   http://thread.gmane.org/gmane.comp.version-control.git/123854
>
> That is a blast from the past.
>
> Why is saying "git checkout ." too much work, after "add -p" that
> you excluded the debugging cruft?

Please forget this question.  A better way in the form of "stash -p"
was suggested in the old thread to get rid of debug cruft in the
tree before an "add -p" session (or during a series of "add -p"
sessions).

So is this still an issue?
