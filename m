From: Junio C Hamano <gitster@pobox.com>
Subject: Re: stopping patches from just floating by
Date: Sun, 11 Jan 2009 15:06:17 -0800
Message-ID: <7vprito32u.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0901111524110.19665@iabervon.org>
 <874p05k1ie.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: barkalow@iabervon.org, git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Mon Jan 12 00:07:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM9PJ-000246-7V
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 00:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbZAKXGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 18:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbZAKXGZ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 18:06:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbZAKXGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 18:06:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0CC948F3A8;
	Sun, 11 Jan 2009 18:06:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1C1EF8F3A7; Sun,
 11 Jan 2009 18:06:18 -0500 (EST)
In-Reply-To: <874p05k1ie.fsf@jidanni.org> (jidanni@jidanni.org's message of
 "Mon, 12 Jan 2009 04:53:45 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 77001C8C-E034-11DD-97B6-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105250>

jidanni@jidanni.org writes:

> I see. Say, for my forthcoming 40 minor grammar fixes that affect 20
> files in Documentation/*, I just couldn't bear spamming this list with
> more that one or two [PATCH] mails. OK one long mail it will be then,
> with several commits encompassing many diffs. Hope that will be OK.

It probably won't be Ok, as earlier documentation patches from you that
were smaller had good bits that were applied and not so good bits that
were dropped, and I'd refuse to pick and choose only good bits from one
single large patch myself.  The tradeoff between "minor grammar fixes" and
my time spent to do so is not good enough.

Please send in small isolated pieces so that people do not have to comment
"in this patch, this and that rewordings are very good clarification, but
this other hunk adds noise without adding much signal".

And by "isolated", I do not mean "one mail per patched file".

For example, if you fix many misused 3rd person singular verbs that ends
with 's' that are used for subject that is not 3rd person singular, that
is one topic and one patch can fix an error of that kind in all of 20
files.

On the other hand, if you conflate such a fix with a new explanation of an
option (which may or may not be adding more noise than the signal) to the
same file in a single e-mailed patch, you will force people to say "this
part is good but that part is not".  That's not the isolation I am
referring to.
