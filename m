From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] fmt-merge-msg: be quiet if nothing to merge
Date: Wed, 24 Mar 2010 19:39:30 -0700
Message-ID: <7vaatxdt0d.fsf@alter.siamese.dyndns.org>
References: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
 <1269414964-9518-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 03:39:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nucz2-0007h7-FY
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 03:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096Ab0CYCjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 22:39:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab0CYCji (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 22:39:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1F98A5600;
	Wed, 24 Mar 2010 22:39:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=a08HEN5+5RYfNvMnPjjqB2EeLko=; b=aVr19V
	F+bG52j3uIiE0iIEE0Dy84KvieRmhKIhlSstIST+v2RCondZHxlA7GsL9ZGZjbI+
	wp+iVKL14WhtrXGoYEgQePK3rj5sLz5Hp8HrlGLiFXlILWFuuuiZaBsvriLb4zOl
	WuWIxb0b4Aev6eugXYKXHxNiTSp9/uQPXKo2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qtfCJ7zgB3TEkjpLNClm2jZ3pY++2uUR
	l0PLtYf7loS+251x4yXmIbqW6zO8t+R7B5x9IypOivVywvihP8HSmfjHn3qXqtsm
	T8XUTWLDbjiS3tQ6YBkhyul1WqvT+yiluRtXt6rnF9QB4WaDJIMGNVBs7RL6Kreu
	TTSG6MjHQ3Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD519A55FE;
	Wed, 24 Mar 2010 22:39:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF6B5A55F9; Wed, 24 Mar
 2010 22:39:31 -0400 (EDT)
In-Reply-To: <1269414964-9518-2-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Wed\, 24 Mar 2010 00\:15\:58 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A5EA64D6-37B7-11DF-A560-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143143>

Stephen Boyd <bebarino@gmail.com> writes:

> When FETCH_HEAD contains only 'not-for-merge' entries fmt-merge-msg
> still outputs "Merge" (and if the branch isn't master " into <branch>").
> In this case fmt-merge-msg is outputting junk and should really just
> be quiet. Fix it.

Hmm, doesn't pull fail in such a case anyway?  Is there a real damage?

I am just trying asses if this is with a maint-worthy urgency.  The patch
looks sane.

Thanks.
