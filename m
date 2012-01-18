From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Checking out orphans with -f
Date: Wed, 18 Jan 2012 14:40:36 -0800
Message-ID: <7vsjjcljmj.fsf@alter.siamese.dyndns.org>
References: <201201181207.05967.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Wed Jan 18 23:40:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RneBP-0000QZ-IJ
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 23:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289Ab2ARWkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 17:40:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61412 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336Ab2ARWki (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 17:40:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67C8B69E8;
	Wed, 18 Jan 2012 17:40:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0wn3rhBCUW8y8u3P6uzIFK66/ns=; b=pt2LSC
	k9s9qQncxZrQHmWXUDi+zsjQRKjdDVNvlO9sHQOjL9GaiN04OfQfmPq3+N1Z+Zyz
	lHeRWZF7oN6No6Va2tgGhBa2xG9KQ/XLfNJtYhbILAWjT80Ll9Z/sG2uoYtIivrI
	ZjbxkRo2wNwZaCe0NUGYeWbrRyprxcbAn0ZEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=atLazjn/yeUxpbbZTL2fBzb0PxFgnbui
	KlV0CbvjxdtGFn18CrN0gf008fN6+0pyFQeaXa+/WPHhOhfVLNoXCKw7fnx7bS8p
	MJef7+YWgPzZrIOy8vtqzW2RgJETTgZi46xOhm1+vm3WCGCsBSangv4816nc/CJr
	OM+KOBbIybA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EAE369E7;
	Wed, 18 Jan 2012 17:40:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D060A69E6; Wed, 18 Jan 2012
 17:40:37 -0500 (EST)
In-Reply-To: <201201181207.05967.mfick@codeaurora.org> (Martin Fick's message
 of "Wed, 18 Jan 2012 12:07:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 713970C2-4225-11E1-AE02-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188771>

Martin Fick <mfick@codeaurora.org> writes:

> I am trying to write some scripts which do various things to 
> a git repo and I have run into a issue where I think that 
> git behavior with respect to orphan branches is potentially 
> undesirable.  If I type:
>
>   git checkout --orphan a
>
> I cannot easily abandon this state

What do you mean by "abandon"?

If you want to remove a branch "a" because you do not need it, you can
check out some other branch and say "git branch -D a", no?
