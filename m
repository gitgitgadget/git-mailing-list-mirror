From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Incorrect man page for git-diff
Date: Tue, 18 Dec 2012 10:11:14 -0800
Message-ID: <7vwqwffcxp.fsf@alter.siamese.dyndns.org>
References: <50D0AA78.5090603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 19:11:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl1dg-00067z-1P
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 19:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559Ab2LRSLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 13:11:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33166 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348Ab2LRSLR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 13:11:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D628BAF77;
	Tue, 18 Dec 2012 13:11:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sl6LYfqnlfEUqiWp5guoYI2FIkk=; b=WM9LcK
	ovA7NqLQUxajUCbBt2aGCU10U0zFv8nFD4Pi/ImNbRB+GZblVrArcsoyqcOX8X2N
	X1PFquudlch/1QJz17Hoot4AHq4zk9fKKX55pW+5r+xzRMP+B4Nrrhwdrc3Rkujm
	UkIS6Q4PVI0sxxC3/D4ovSOOpW/PzpSVIQI4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i0sTcPS312wPdTfw3eAPsCBFpLOU5JXp
	NHPSWrmeVWpIki9zDSPaIY43J6RQqHucfq7U4r0U2oaPpUVvl4NfalW9MDeCuuSh
	WdUbwP9n7/ZVcJB1JpQuHpsvifrSHwk0rq5en6FaSdySWRlRBqJ62Mj2XblMWEeM
	GIVQHqZzlBQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C47B6AF76;
	Tue, 18 Dec 2012 13:11:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F216AF75; Tue, 18 Dec 2012
 13:11:16 -0500 (EST)
In-Reply-To: <50D0AA78.5090603@gmail.com> (Manlio Perillo's message of "Tue,
 18 Dec 2012 18:40:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 508B9A1E-493E-11E2-BF72-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211769>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> Documentation seems to suggest this is supported, but it is not true:
>
>   $ git diff HEAD:git.c HEAD~100:git.c -- git.c
>   usage: git diff [<options>] [<commit> [<commit>]] [--] [<path>...]
>
> unless I'm missing something.

Neither HEAD:git.c nor HEAD~100:git.c are commits.  You are
comparing two blob objects in their raw forms without textconv nor
filter.
