From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Add support for GIT_ONE_FILESYSTEM
Date: Sun, 28 Mar 2010 09:44:09 -0700
Message-ID: <7vr5n44crq.fsf@alter.siamese.dyndns.org>
References: <1268855753-25840-1-git-send-email-lars@pixar.com>
 <1268855753-25840-4-git-send-email-lars@pixar.com>
 <20100328092253.GA17563@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Lars R. Damerow" <lars@pixar.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 28 18:44:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvvb6-0003s1-Eu
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 18:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794Ab0C1QoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 12:44:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711Ab0C1QoS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 12:44:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ABF5CA693B;
	Sun, 28 Mar 2010 12:44:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9cKg1noIwKylgo7GCt4fRM5IZ1I=; b=KP4EXz
	Dg+bwqrgX+w64YOJux4A3YMZRuuIo5aYnvbs9D+aO046qf4Qop2+IZnT0MlO9lCm
	vegNrTXVCfOcrmsQWT9Cj0NxVM2aFbVGI424FS84KkuiFyp96C9txPYo4f8xiAsp
	dof8os8sVLC/guN4walzit9kdlI9cJZtK0ppc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WPHuItx5DeGf6JoaJr6zMqBe+JZ6c1ZM
	Y37npr/DTv6GRzJjY4QPwLg7MIPRTdV6kYRCXOlXsjYIKWkmXJSptTvun5JUFOUV
	Qxalggqhm1GZ6NnHyaebLcMDnpoyMDHiQB5WN2+W/li/0ViqDfX0Smf3DFXI7nI1
	kPaA8oNM8D8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 57A01A6939;
	Sun, 28 Mar 2010 12:44:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACBFCA6938; Sun, 28 Mar
 2010 12:44:10 -0400 (EDT)
In-Reply-To: <20100328092253.GA17563@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 28 Mar 2010 05\:22\:54 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2494F020-3A89-11DF-A261-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143401>

Jeff King <peff@peff.net> writes:

> With those fixes, I think it should be ready for 'next'.

Yeah, looks nice; thanks both.
