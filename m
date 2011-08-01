From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fixed pluralization in diff reports
Date: Sun, 31 Jul 2011 22:06:54 -0700
Message-ID: <7v4o21k9e9.fsf@alter.siamese.dyndns.org>
References: <4E3624F9.7070406@gmail.com>
 <7v8vrdkc19.fsf@alter.siamese.dyndns.org> <4E36277B.9020208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 07:07:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnkiW-0006y0-Lz
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 07:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485Ab1HAFG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 01:06:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34091 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291Ab1HAFG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 01:06:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23E274AF3;
	Mon,  1 Aug 2011 01:06:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sPDY7fu2h2dkoFuJigEsukdTh9o=; b=chQ9gK
	t5yRC9BS5W4KxocDlCG3963+tV5+Abs3YHz5eVVdseEifjO5RX2R3sGYJ3dr/GS1
	J0W245i0TK6rQdaBvZIZkOKkgIUxiJ6mZcnHJEnw+1PzuhsEmzO/l7n1YK8EF6to
	Ne1ZFXjZS4xhkEejz7YbnGrPN+YFkqqZWCsqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f3+7lOYb0cK5SYnvzreYQERshhRyFyXM
	mEb3TAVRLQ8O674S72FgMk7tyjTiBqhKau+5+QoD0MeJ/Pojc7ievZRqLEIAcgC8
	xdMc8Mx1zjAZsCbxH8U3LcBWKofWrLPwYiNLHlHnkKQpSBBwigr6EBi/1penjNzv
	T/yMZlX7Lp4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1949A4AF1;
	Mon,  1 Aug 2011 01:06:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83CE94AEF; Mon,  1 Aug 2011
 01:06:56 -0400 (EDT)
In-Reply-To: <4E36277B.9020208@gmail.com> (Jon Forrest's message of "Sun, 31
 Jul 2011 21:11:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 142901C2-BBFC-11E0-AD43-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178319>

Jon Forrest <nobozo@gmail.com> writes:

>> This is how the other diff implementation has always showed this line, no?
>
> Maybe, but it's not grammatical English no matter who does it.

It does not matter it is grammatical or not; changing it would break
expectation by scripts that are used to the output both by the other
implementation and by us.
