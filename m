From: Junio C Hamano <gitster@pobox.com>
Subject: Re: send-email and in-reply-to = n
Date: Mon, 13 Aug 2012 16:53:21 -0700
Message-ID: <7vfw7qbb7y.fsf@alter.siamese.dyndns.org>
References: <CALaEz9WQJBQ+OtDOhjH7Gz5Uw9Hu+82fOikf20WuTZy4RJsBPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 01:53:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T14Ru-0001RH-TK
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 01:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103Ab2HMXxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 19:53:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41739 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111Ab2HMXxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 19:53:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07EC28E82;
	Mon, 13 Aug 2012 19:53:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lqPeWuj4R6O4/80wzT3JB8eyLhg=; b=SmOXBE
	IaLDSQS+w1McSmEVSS5XoXteYk8xJNVxquPmfqy6DN6dYqlUwj7arbmI0l9ralae
	jitdIOyFYVPne4jl10qQ+1Zi/nHtDYMPYIn5kgHHLl5vHVa8seZQNrPJoIi1FW52
	2+hmtHlykd8orlpqzoIb78aYUCtaojXJPCGmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bydCXSpj7fdF2VAOnB9LVxtSAAMAgei9
	58nwo6pLreAYWPUbM1diV9jE9ipW12VyxS7YVQf9OA74mqwTrCiVG+jKBnS5sTEb
	RaGq+2+iGtXrDlPvSRzJGjT+ixoYXuZS+lcTN0MGYNPKhrZMe6IB55zwKThuht3H
	OzRBwFmTUV4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA0FB8E81;
	Mon, 13 Aug 2012 19:53:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 696B98E80; Mon, 13 Aug 2012
 19:53:23 -0400 (EDT)
In-Reply-To: <CALaEz9WQJBQ+OtDOhjH7Gz5Uw9Hu+82fOikf20WuTZy4RJsBPg@mail.gmail.com> (Stephen
 Boyd's message of "Mon, 13 Aug 2012 16:50:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 113B55F2-E5A2-11E1-BDFB-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203376>

Stephen Boyd <bebarino@gmail.com> writes:

> Can we throw up a big warning or just outright fail if someone types
> 'n' or 'y' and hits enter for the in-reply-to question in
> git-send-email? I saw a git-send-email sent patch with an In-Reply-To
> header containing n on lkml today and it makes threading in my mail
> client get confused.

Yeah, I think it is a good idea to minimally sanity check the answer
to in-reply-to (and possibly other fields); perhaps "does it have @
and dot" would be a good enough heuristics.

Please make it so ;-)
