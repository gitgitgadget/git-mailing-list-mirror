From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Allow empty commits during rebase -i
Date: Sun, 17 Jan 2010 19:11:59 -0800
Message-ID: <7veilow1hc.fsf@alter.siamese.dyndns.org>
References: <4B53B561.0@pcharlan.com>
 <7vljfww686.fsf@alter.siamese.dyndns.org> <4B53C355.1010109@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 04:12:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWi2L-0005z8-8k
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 04:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169Ab0ARDMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 22:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755163Ab0ARDMN
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 22:12:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56213 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149Ab0ARDMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 22:12:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 310CC92FAB;
	Sun, 17 Jan 2010 22:12:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0nSqIk5+xsY0oxaYhqsb1zfVuB0=; b=g1sgCu
	/bMAhnIThihSOSgaOs4ZmtO0sXUXBKTL1uWShVZ7bDEP9aikuLKCtsQLsLyMCHtI
	q8Jq3IkzjykF8B1NdXM4/N3ZKuiE7B5yFzrn0DjoxN/41TQIwlpGOVrnbWkE1q8i
	X+mc4cKUO/qXw52CksULFuQXLTf8KemUKw4PM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B2sux9oflvam74sZyR9e9N3xOh7GeRvb
	wqlkXqq0PX/CrJXKyXmDyrUGaeHW02ljKSauXHDWOws04GMJcpLgXrRifVN5pjX/
	uvloZ5ojsob4iYIwfkQQYL+B1mii1/IqB6zrYk15bFns7wXVVp+x+vhsM6gIrc4B
	0HTJ4ito40A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DC64D92FAA;
	Sun, 17 Jan 2010 22:12:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F00B492FA7; Sun, 17 Jan
 2010 22:12:00 -0500 (EST)
In-Reply-To: <4B53C355.1010109@pcharlan.com> (Pete Harlan's message of "Sun\,
 17 Jan 2010 18\:11\:33 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 41AB29E4-03DF-11DF-92F8-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137362>

Pete Harlan <pgit@pcharlan.com> writes:

> ..., "git rebase --continue" does exactly what I would have
> wanted to happen, including putting me in an editor with all three
> commit messages and succeeding when I exit the editor.  But without a
> better message from git I don't expect a user to discover that.

There seems to be an idea for a good improvement ;-)  CC'ing Michael as he
has been most active in this area for the past few weeks.
