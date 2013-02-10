From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/15] user-manual: Update for
 receive.denyCurrentBranch=refuse
Date: Sun, 10 Feb 2013 14:36:19 -0800
Message-ID: <7v1ucnssnw.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <ba62167be6df7a6ba666373913bfd235bcc29c9d.1360508415.git.wking@tremily.us>
 <7vd2w7uajk.fsf@alter.siamese.dyndns.org>
 <20130210214621.GA8000@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:36:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4fVx-00027x-S2
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856Ab3BJWg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:36:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59048 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756748Ab3BJWg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:36:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02548C027;
	Sun, 10 Feb 2013 17:36:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gXmuLhdKRMW8KHuYrZU+GgHqLXg=; b=XNvNKd
	j6eQ+5JSCnPijSi1vBxDYmwPC1hhQNN4qtbszLIw4aeXEFm8uc16YJ/VzftyLOvL
	/tl/iH0WUQhBO7mBpgAgFcj6mTYWG3TSX5/9fhpJuC9l0ewufM3LcOcbgbIHCsH/
	QFPda38Pr6jHOBwHrl53NEUlq4wSfkzcklwsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MrHrJclnNpQnDZrP1xYALlzSzZvtqJHL
	cSNz034pZOWUuQpZOk1rwKCb+jLUjAcAjL047FuvNKuYeC0waH1TOq51/vx79sV3
	xC+E8YEiojbjUn4WSkPgvkbbDjPeKF/MeNRJkUUg6Wg8kGzulAG7UR/+g/ln4H3K
	ZEnqNnQh/mg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97B24C020;
	Sun, 10 Feb 2013 17:36:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4E8BC012; Sun, 10 Feb 2013
 17:36:23 -0500 (EST)
In-Reply-To: <20130210214621.GA8000@odin.tremily.us> (W. Trevor King's
 message of "Sun, 10 Feb 2013 16:46:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D2B99BE-73D2-11E2-8069-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215958>

"W. Trevor King" <wking@tremily.us> writes:

> On Sun, Feb 10, 2013 at 01:24:47PM -0800, Junio C Hamano wrote:
>> I would not be surprised if some readers felt as if "then why not
>> update it instead of rejecting?" were a valid question, without a
>> bit more explanation.
>>
>> 	You can also push to a repository that has a working tree,
>>   …
>
> Looks good to me :).  Shall I just drop this patch from v3 and leave
> it to you?

No.

Others need to object to, comment on and polish what you saw from
me, before it turns into a commit.  And you need to be credited for
identifying the problem, initiating the discussion, and collecting
responses to result in the final patch.
