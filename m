From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] commit: allow partial commits with relative paths
Date: Sun, 31 Jul 2011 17:05:25 -0700
Message-ID: <7vei16kncq.fsf@alter.siamese.dyndns.org>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
 <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net> <20110729133551.GA8707@toss.lan> <4E343534.8000604@drmicha.warpmail.net> <20110730170045.GA9900@toss.lan> <4E34399C.2080109@drmicha.warpmail.net> <20110730171347.GA10432@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Reuben Thomas <rrt@sc3d.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Aug 01 02:05:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qng0j-0001WE-T7
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 02:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246Ab1HAAFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 20:05:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40651 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752756Ab1HAAF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 20:05:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A60395AF0;
	Sun, 31 Jul 2011 20:05:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M3nTVztAcFECHCLOtXjlvz7r71U=; b=dx0puK
	h3442XgIHN9fe2LG0u2plipGZSSnLbxsFlvrS0Z0bVe/dpt8NyHgoh90a+27NmtD
	H2mRgZ5ux8TBEQ5k/XqzRy0e+Bei0AraxVDbUxMnRkU1DuaukgdNPPtwnemOcWqp
	ch7hUcO5BpZMw4F8Uki6w8WVs/22jlztMHFpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ftm4RyTIqcyYFiptYSECCnrUgVdZCpGB
	x/FBdjOCa+CIPpSnRz40fKqDYDi4UdKYE7d47rxXVJatS8FrvhWr4P+Vi1xMpWZB
	ZNURx6TTdn+RcTt2SiqzYgLaV2ed4jBShrHgxkeaVq3PFFdF5HsuOmINdB+7YdUD
	SyPMnPgQZ28=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B57C5AEF;
	Sun, 31 Jul 2011 20:05:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 141635AEC; Sun, 31 Jul 2011
 20:05:26 -0400 (EDT)
In-Reply-To: <20110730171347.GA10432@toss.lan> (Clemens Buchacher's message
 of "Sat, 30 Jul 2011 19:13:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F600F058-BBD1-11E0-AB24-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178286>

Clemens Buchacher <drizzd@aon.at> writes:

> ...
> But even if we cannot use the working directory as a prefix, we can
> still figure out if there is a common prefix for all given paths,
> and use that instead. The pathspec_prefix() routine from ls-files.c
> does exactly that.
> ...
> Only the commit message changed in this v2.

Looks sane; tests?

Thanks.
