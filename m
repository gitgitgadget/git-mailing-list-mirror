From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default documented in "man git-push"?
Date: Tue, 02 Oct 2012 10:21:25 -0700
Message-ID: <7v8vboaiy2.fsf@alter.siamese.dyndns.org>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CAN7QDoJ=PKt_1zW58648tcaT7MP1MTVJo9E4PW5g93K_tO91Jw@mail.gmail.com>
 <CALkWK0nQu_vvLGu=j2CDkGcKtp-T401kDyhD5_iMqQrkGk9K8Q@mail.gmail.com>
 <vpqwqz89617.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 02 19:21:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ6A9-0001su-Ex
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 19:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106Ab2JBRV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 13:21:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39100 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204Ab2JBRV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 13:21:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14746814F;
	Tue,  2 Oct 2012 13:21:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w7OodfktH/1nRzVAiM5MaKdvoSY=; b=vFSmX2
	1W+I/0XCzAo9zLrsHbDtXCUTZlNBXHFixFaLVhDmJYAgnIksZQyoSvoDWn1K8+Jh
	8yhVOOd/qewfHxt9O3zIP6GTQIbCmjSEGnUsDHuEOj1ZPv/0H79p9QznOttl3y83
	8nZeAw4TvWoAKdZypBSV/+gXn6n+/ljY+lRdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nmud5fAWB6FhRt5J0JCtCO8xUALzSYwd
	ZDh5Apv/k7G5r6U9RPq9n3qrJ95256MnJqYg6nugwodus1cZ/jsVuh5HN/c4Sda/
	WB/nGQk481Rtb4824ZQTbbd409o8aToaeAN7KjiEqcy5tfueHBLBr+5htWFb+Lkd
	qPquSKVozaY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 003E3814D;
	Tue,  2 Oct 2012 13:21:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72642814C; Tue,  2 Oct 2012
 13:21:27 -0400 (EDT)
In-Reply-To: <vpqwqz89617.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Tue, 02 Oct 2012 18:45:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9947BD48-0CB5-11E2-AAA6-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206823>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> David Glasser wrote:
>>> Thanks Rankumar! There's also the reference in the "git push origin"
>>> example and the "This is the default operation mode if no explicit
>>> refspec is found".
>>
>> Sorry;  here's a revised patch.
>
> Sounds good, thanks (resend and Cc Junio if needed).

That's an Ack?
