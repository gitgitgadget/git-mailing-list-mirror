From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-format-patch should include a checksum
Date: Tue, 26 Jan 2010 17:35:13 -0800
Message-ID: <7vvdeowcry.fsf@alter.siamese.dyndns.org>
References: <871vhcmr5b.fsf@trurl.pps.jussieu.fr>
 <7vljfkxxj9.fsf@alter.siamese.dyndns.org>
 <7ir5pccp9n.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
X-From: git-owner@vger.kernel.org Wed Jan 27 02:35:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZwoX-0007jq-Ch
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 02:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384Ab0A0BfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 20:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776Ab0A0BfV
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 20:35:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab0A0BfT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 20:35:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C66C94092;
	Tue, 26 Jan 2010 20:35:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wpkzspw0zPy9JAXNu7qsv4Gw1Gs=; b=LzEeNU
	baGMqOmGb1A0o0wuyZkHWFS5zZ1dv7ZQZ2Z9c5ctmy72WEe4+iW3bUEczCYz4mbT
	PPKXmKSfpjUN6+uP0jJeW5tm42LdziDVGWdUFyM8lgP1PWSzknqdxaw96gL6xW26
	Drt61AgFxV/eSvcp5SmOS50hIZa2hOjgutsZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rg1YT/Hc1akYvvX0JImL65Y+eg956KbA
	ykkbtD9mLAQEVnXxdjl303nBpliywkRT24Rxqq5CFrSTEdmDwm7CnK4bEbyfPNwU
	JS42sTPdOa4tbqPnPc9R2l0MxqUaKytzNuhACn7VW3AQVWb2hLOJQ7ImqNZCvRZM
	pd7zFEx0Ieg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 475DF94090;
	Tue, 26 Jan 2010 20:35:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB4A594089; Tue, 26 Jan
 2010 20:35:14 -0500 (EST)
In-Reply-To: <7ir5pccp9n.fsf@lanthane.pps.jussieu.fr> (Juliusz Chroboczek's
 message of "Wed\, 27 Jan 2010 02\:25\:40 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 392F43E8-0AE4-11DF-93CE-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138101>

Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr> writes:

>> That wouldn't work either. People can, should, and do add extra things to 
>> the message before applying it.
>
> Shouldn't they remove the checksum line at the same time as they edit
> a patch?

Why force extra work on people, especially the ones who _receive_ patches,
when they say they _don't_ want to have such a noise by default?
