From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Better cooperation between checkouts and stashing
Date: Thu, 18 Feb 2010 12:09:06 -0800
Message-ID: <7vaav6b925.fsf@alter.siamese.dyndns.org>
References: <4B67227A.7030908@web.de>
 <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B71B574.3010609@web.de>
 <7vbpfy9nt4.fsf@alter.siamese.dyndns.org> <4B7D7C5E.7060807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 18 21:09:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiCgb-0006vi-H1
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 21:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758388Ab0BRUJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 15:09:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397Ab0BRUJO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 15:09:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 399A89B5FB;
	Thu, 18 Feb 2010 15:09:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wbry10kzb1FXgIz3K2jJRgkuLA0=; b=eG3XrP
	FtmU0GbCdBxoI/wdDCyQ5LFbrdq4UNqHtZwpY99wZqOlJbiLPGGB0GkG0h+TNpVn
	Bzcua0SLp+1H+W13+OD/f6ZbJC6nybP5Q9VqQQt4Wd6Y1Zsfe6JckhJ3qWLDQKAs
	uGe+OTcQKugwJfNC7qt4HW20gZX9zYX2+48gY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ke9wSCcmMgRbHNAHdGXgYPZ+gBUG07lm
	HRtYPXbCTv+V5fiDcrmf0v/DJhxe28W6BG3RoYbetVlOBRIVgszsXS2V9gwEf0vZ
	MGVReytg8QVXo8LtuOzVXB7pe19WiO25rkTzgbYpuCEhLTH3VYWb2/qnhIFBIDoY
	dfXc3gFLa/c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A96F39B5FA;
	Thu, 18 Feb 2010 15:09:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FFF79B5F6; Thu, 18 Feb
 2010 15:09:08 -0500 (EST)
In-Reply-To: <4B7D7C5E.7060807@web.de> (Markus Elfring's message of "Thu\, 18
 Feb 2010 18\:43\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7AADD70C-1CC9-11DF-AE33-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140368>

Markus Elfring <Markus.Elfring@web.de> writes:

>> I did say and still think that it would be good to have in the documentation 
>> a separate section that teaches the users what happens to their uncommitted 
>> changes when checking out a different branch (or an unnamed branch).
>
> How are the chances to achieve progress on this issue?

How would _I_ know?  It depends on the probability of somebody who cares
about improving the documentation having enough time and motivation to do
the actual work, and submitting the patch.  It also depends on the quality
of the result.
