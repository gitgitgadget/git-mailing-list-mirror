From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 14:13:40 -0700
Message-ID: <7vehr1dl2z.fsf@alter.siamese.dyndns.org>
References: <4F9F128C.5020304@palm.com>
 <201204302331.q3UNVo7o032303@no.baka.org> <4F9F28F5.2020403@palm.com>
 <201205010137.q411bxaU002449@no.baka.org> <4F9F52B9.9060508@palm.com>
 <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
 <4FA2D8EA.7030809@palm.com> <87obq5ggpu.fsf@an-dro.info.enstb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rich Pixley <rich.pixley@palm.com>, git@vger.kernel.org
To: Ronan Keryell <Ronan.Keryell@hpc-project.com>
X-From: git-owner@vger.kernel.org Thu May 03 23:13:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ3LP-0000Xh-HB
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 23:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758739Ab2ECVNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 17:13:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41973 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456Ab2ECVNm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 17:13:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87C9D79D8;
	Thu,  3 May 2012 17:13:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Dk7lECjAZiG9/Kn85PVT1EIX30=; b=c/wZCT
	OlK6oNLn9Rla4X1eavX9IKz8bwiGdyhc+qmy8F0SW8mGfPp/c/Jilvr8tvgNaEAn
	G8zFvfOUC8pV0IxwkZ3Q+QSt2ppHgYanJtS14WHiU9thorHD4LCvKicHVygp5IMO
	jE45cMYDMVr1oLYupMJheFsJOUkgMf+SI7J14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xRDw1u9ApKFwc1ZP3zrm0oeho4jxSMYe
	6QGSc+w/MlseKmmJUD9FnobMRyo3UXg7WzVO3XDP2qESEbnT7tRzTn/BGDYqiKCE
	lmy4+geVu1nYjLMwanvDDaQnVz30p+rekTLu97a5HD3jP0Gq3nfnuDKWXalt45tz
	vbO8VPlJYOA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 802B079D7;
	Thu,  3 May 2012 17:13:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A4C979D6; Thu,  3 May 2012
 17:13:42 -0400 (EDT)
In-Reply-To: <87obq5ggpu.fsf@an-dro.info.enstb.org> (Ronan Keryell's message
 of "Thu, 03 May 2012 13:19:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC2F4702-9564-11E1-9315-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196961>

Ronan Keryell <Ronan.Keryell@hpc-project.com> writes:

>>>>>> On Thu, 03 May 2012 12:13:46 -0700, Rich Pixley <rich.pixley@palm.com> said:
>
>     Rich> * the hg error messages are straightforward, clear, and don't
>     Rich> require any deep knowledge of the source code control system
>     Rich> or it's limitations.  (I still don't understand what the git
>     Rich> message on collision is saying.)
>
> This is a very good suggestion.
> ...
> At least, print a simpler message with some typical use case causing
> this and some workflow ideas before the detailed explanation.

It indeed is a good starting point to make a suggestion, but there is
nothing actionable in the above by itself, especially since "typical use
case" is quite different for different Git users.
