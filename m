From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a git-completion rpm subpackage to the spec
Date: Sat, 20 Mar 2010 18:20:08 -0700
Message-ID: <7v1vfe8o8n.fsf@alter.siamese.dyndns.org>
References: <1269045134-28072-1-git-send-email-icomfort@stanford.edu>
 <1269109086-8887-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7v8w9mda6l.fsf@alter.siamese.dyndns.org>
 <1269119663-sup-5823@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>,
	Ian Ward Comfort <icomfort@stanford.edu>
X-From: git-owner@vger.kernel.org Sun Mar 21 02:20:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt9qE-0006zo-W3
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 02:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297Ab0CUBUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 21:20:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab0CUBUS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 21:20:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B5021A3091;
	Sat, 20 Mar 2010 21:20:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lbplMBR8+MXIMP0K2DHA2ZShV6Q=; b=m5T6hT
	mKGDhIeY+y0qNlei0cFNKzvU8DIJ23P2Q2tb2kX/qr7XeWKbEGG7kvU/cR6qdoPH
	7Rwe5OJ9aBmPSJDikTXPT7rhSHhj3e1G+FWRN1wemngdRFUzxQLNlFcjZOP2vlZQ
	eSJQMvVZIBXrrKvqxLMcRqNWsfOUNwL91Xgvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xCp6OohE74eF4RalWpuU1xMZMMOF8vU/
	Y/vC9F/C2tcEBoRB9sSMHLORds5IRQO5LVpioWJCgxUUsTxWou38u46ZGYFsofyu
	lzgDnCl2kvf9TqnD/EW9876Fz5XdvFyNvBw58IqwPav9EDCzPUP/k4Nnwb/IjPW8
	4ZZS5M2D1NM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 83C14A308D;
	Sat, 20 Mar 2010 21:20:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC22BA308C; Sat, 20 Mar
 2010 21:20:09 -0400 (EDT)
In-Reply-To: <1269119663-sup-5823@pinkfloyd.chass.utoronto.ca> (Ben Walton's
 message of "Sat\, 20 Mar 2010 17\:14\:41 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E664E87A-3487-11DF-8654-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142783>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> Excerpts from Junio C Hamano's message of Sat Mar 20 16:12:34 -0400 2010:
>
>> looks sensible.  May I ask for what distribution you are "handling
>> it"?  The last thing I want to do is to get in the way of distro
>> packagers.
>
> I can't say it's _the_ global definition for RPM based distros, but I
> suspect the redhat derived ones would use this location.  I'm working
> against RHEL5.
>
> The info that Ian provides seems to corroborate this hypothesis.
>
> HTH.

Yes, it helps a lot---thank you, both!

Will queue.
