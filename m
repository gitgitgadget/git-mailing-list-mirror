From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] diff stat calculation adjustments
Date: Mon, 16 Apr 2012 12:30:48 -0700
Message-ID: <7vobqrtqxj.fsf@alter.siamese.dyndns.org>
References: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lucian Poston <lucian.poston@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 21:31:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJrdY-0007ME-Nw
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 21:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275Ab2DPTaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 15:30:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62893 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633Ab2DPTav (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 15:30:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6272B6DBC;
	Mon, 16 Apr 2012 15:30:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R09LRlw5RbJcle6CM5lmM3jpQr8=; b=ElyU6j
	HJf/MU+TiHUYPpUhBE6NgMJgjznatK+Ta8LhhmhstNsP7jEqfXmdAexchZriOFDM
	Bq27ljRUz84ZuwBrQfF+OCqffNFNjiDbKRYP3kG5H+KRnKwZZJMtf3VhxQQi9EKo
	HLxXC555LS3Q+mc1zDNOUG47SABprV14KQ9b8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xsLEJ7aOKhxPN+lzZAMgMeW/JNHQ0JQk
	4hVwGXMv79nuJKPKOhK1Od31ShVmPXCkUwL5laIGoD3HUjtaj5uJ85VvAHNaBIk0
	qqADHUJODBt1FdYOoPxDEUf6MWL0T/6hVqC+ucC2zKPv9BJeSfC77OUnJsGBGdAF
	vxyDgaoRs7U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A1296DBB;
	Mon, 16 Apr 2012 15:30:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E31736DBA; Mon, 16 Apr 2012
 15:30:49 -0400 (EDT)
In-Reply-To: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
 (Lucian Poston's message of "Mon, 16 Apr 2012 03:44:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC423526-87FA-11E1-BB7B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195680>

Lucian Poston <lucian.poston@gmail.com> writes:

> I broke the patch series up into smaller patches. Hopefully this makes the
> intent of the changes easier to follow.
>
> Zbigniew's tests were added as PATCH 1/7.

Thanks.  Overall it looks nicely done, except that the structure of the
series may want a few squashing, moving and use of test_expect_failure
that later turns into test_expect_success.

When I learned from you that you will be rerolling, I was expecting to see
the other series, i.e.

 * lp/maint-diff-three-dash-with-graph (2012-03-20) 3 commits
  - t4202: add test for "log --graph --stat -p" separator lines
  - log --graph: fix break in graph lines
  - log --graph --stat: three-dash separator should come after graph lines

but I think this was $gmane/193490 split into three and didn't have
anything controversial.

I'll merge it to 'next'.

Thanks.
