From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Encrypted repositories
Date: Wed, 05 Sep 2012 22:37:24 -0700
Message-ID: <7vvcfr4sq3.fsf@alter.siamese.dyndns.org>
References: <fcbea7c0-b433-414b-abd3-b0e205a96fc5@zcs>
 <f6682453-92bc-4f3b-9bf3-1910ca6fb307@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Thu Sep 06 07:37:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9UmU-0003n7-Nd
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 07:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423Ab2IFFh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 01:37:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56654 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab2IFFh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 01:37:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 434A145A5;
	Thu,  6 Sep 2012 01:37:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=34Q4u6zvqJ1j7REh511rwGbtcSE=; b=dFdqK7
	v3UE0o84IjoeGPgc5qplSvA6Vpwk6ZRx9VeCyvqSdIsACd4ohFzGCn76rMqTwWIw
	WYuA6JYWuGRvhU2b8jyktTVRDdQ+VWxdMTHFdPYFubA6tfW1cqn1AUM8e0Uz6vpC
	MY+lDxGQGKCwJzUDZOFJAIatvVhXThhj/uwso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZBxO+9b6zdJl/I5IttS9TRtKXUHxvy6d
	RxaBssC/2wk87VhHrmYHpCJm/5WuOv6LABJwhDAI1VDnyUBuruaFBWa0K8lUIzdN
	jWTMrcD324We7FdBW7Q+woYgoQUTgahXv0U0rQr94aP7Je/iuFWnLSPWub9cuU+/
	7KC2TB/OlUw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30D4E45A4;
	Thu,  6 Sep 2012 01:37:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A516B459A; Thu,  6 Sep 2012
 01:37:25 -0400 (EDT)
In-Reply-To: <f6682453-92bc-4f3b-9bf3-1910ca6fb307@zcs> (Enrico Weigelt's
 message of "Thu, 06 Sep 2012 04:23:32 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0782CC8-F7E4-11E1-BB33-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204864>

Enrico Weigelt <enrico.weigelt@vnc.biz> writes:

> * blobs are encrypted with their (original) content hash as
>   encryption keys

What does this even mean?

Is it expected that anybody who has access to the repository can
learn names of objects (e.g. by running "ls .git/objects/??/")? If
so, from whom are you protecting your repository?

How does this encryption interact with delta compression employed in
pack generation?
