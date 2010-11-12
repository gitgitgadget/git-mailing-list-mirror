From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rebase -X: do not clobber strategy
Date: Fri, 12 Nov 2010 12:55:27 -0800
Message-ID: <7vaalefeio.fsf@alter.siamese.dyndns.org>
References: <1289373266-32593-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <AANLkTimEvp2mQu1QWhx-FDEx37NLi8jose_p+A1y1iHK@mail.gmail.com>
 <AANLkTiks87caBYo78Xh1hwnEfDF9yKwBn5q3wa87hBo3@mail.gmail.com>
 <7vpqubfrkj.fsf@alter.siamese.dyndns.org>
 <AANLkTinrhfmeeToMZfW942xvJGz9vgiQd6+2bXkSawJU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 21:55:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH0et-0004BM-OJ
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 21:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab0KLUzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 15:55:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab0KLUzh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 15:55:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 39A5C360E;
	Fri, 12 Nov 2010 15:55:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EJxtdLp8g8U/NjSFuyqWxYeEo+w=; b=iky6FC
	NFZc9/mbgucJFkxk/EGOYRosTtxyVzfuyN5kr1gup7a7BBluseH3e8Ldl4I8BIHE
	t8x6dh8oGYumz2gcYB5lxxofWoC07ECYQbrbgpe+hZvVGLqgDrdCpPkCn+dqxUO3
	Zra6RJzpbMGPM0EjIWPi6hhNofFaZ5vI/tFxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kNWFb0qfqNEo0qeFtxdRB0NIdp1Sm7bq
	Bv88Q37PHEB6CWmvCmsw1I3Z5wjIoWKHwDXmG8e/H1jz6+ypgr100g9pjT4hWNHD
	VLA+2FJ5QhJN+jX3j+5A54la2nLw8GOsi6e7UjBKH0w6q/9P8qUR7yCTj4Uock/Q
	XKV63heXH9A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B5D6360B;
	Fri, 12 Nov 2010 15:55:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B8B8B35FB; Fri, 12 Nov 2010
 15:55:33 -0500 (EST)
In-Reply-To: <AANLkTinrhfmeeToMZfW942xvJGz9vgiQd6+2bXkSawJU@mail.gmail.com>
 (Martin von Zweigbergk's message of "Thu\, 11 Nov 2010 20\:31\:08 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 345C55DC-EE9F-11DF-A673-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161362>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> That's clever. Thank you!
>
> The fix for this bug touches the same parts of the code as my
> refactoring of git rebase. If you don't mind, I will post your test
> case and the fix as part of the refactoring series.

Nah, I'd rather squash the test script into the fix.
