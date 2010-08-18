From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH re-roll] Do not display 'Switched to a new branch' when
 the branch existed
Date: Wed, 18 Aug 2010 16:38:12 -0700
Message-ID: <7v4oer8paz.fsf@alter.siamese.dyndns.org>
References: <AANLkTimaZF1Q6BPB7CN0Wa5-Ov2ejVfPsmL34vps2VqK@mail.gmail.com>
 <AANLkTi=3z9gJdT8LL3NANFyppUjvOVcrszjf5J5zAKPe@mail.gmail.com>
 <20100818091603.GA6263@burratino> <7voccz8wo8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 01:38:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlsDL-0003Rf-PY
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 01:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387Ab0HRXi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 19:38:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab0HRXiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 19:38:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 90474CE3A4;
	Wed, 18 Aug 2010 19:38:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XCK4cnjjeZUpQU2+RWBnLVG+bcY=; b=DZDHBm
	QvUkvnUu3hxFaoSaerhj769h5KUwprh2C+HKYwLvyqME/QOVEvfVaxpOwflTcAFr
	NGYnPHK8/bz7XOyxoxG4lz6FB4BrHui3Il5ojMePSUTcfdGKpidYfBFjZFRE+aW5
	gZlUBjIGJAP+scFhofBJ21EPP7vSLZsepsqCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fpw4yCqGWsGOe6raAEW8TC2iSgNQT0k7
	i9Lz7JND4x5W5jjKSLrWxQV6W0m6/5J1lgidl9jf6wv4n9mKQt1o+Degt27fohm5
	5kfzoxVPG7K6FA4ryOkvI3G8XBltw9oVgipa9L9nqiVKpCUlTbhRcMFgSTx4VSTL
	l9wz4jY7o/8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 41C7ECE39D;
	Wed, 18 Aug 2010 19:38:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 685D0CE39B; Wed, 18 Aug
 2010 19:38:14 -0400 (EDT)
In-Reply-To: <7voccz8wo8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 18 Aug 2010 13\:59\:03 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE628098-AB21-11DF-9B78-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153896>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> The functionality of your patch is obviously good.  Thanks.
>
> In what way is it good?  I am especially worried about the word "reset"
> being confusing.
>
> You are switching to a new context to work on something else, so I don't
> necessarily think it is confusing that the word "new branch" in this
> message does not mean "a branch that did not exist before this operation
> (i.e. a newly created branch)."

Ahh, please disregard the above; I somehow failed to see that this is only
in the "-b/-B" codepath.  Sorry for the noise.
