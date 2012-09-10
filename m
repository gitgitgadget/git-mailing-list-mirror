From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Sun, 09 Sep 2012 17:24:30 -0700
Message-ID: <7vwr02pvwh.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com>
 <7vpq61dfn9.fsf@alter.siamese.dyndns.org>
 <7v8vcpdat2.fsf@alter.siamese.dyndns.org>
 <7vk3w5woc4.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BtZzgi32kxVTbGC7eAjFG41bdae=MaK==sKq=9ohf8_w@mail.gmail.com>
 <7va9x0uyz9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 02:24:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TArnu-00026f-A9
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 02:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563Ab2IJAYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 20:24:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48509 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271Ab2IJAYd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 20:24:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D672A9710;
	Sun,  9 Sep 2012 20:24:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TIpFLb5E1UqaD4cVxfyTvxBMBFY=; b=epaHL3
	QjZro4lM1NnY5Zo5XXpAOSFXyeoWNzzYlescvG0bUKdTCLoPnUj9na2873hXdxC8
	6l6EnE1X8xLirK2Jyqye6+dNJyBZ9Bcfamzeb7YUs06D1H9JUw54bPMvKWdb/fAA
	jwn6lh1N7hjvNgSX6wt/wJNbe8gDvNtJpxIok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qgnflZqclmaAmv5JkPFOYZ9oHX7+OSxH
	6mWJj6Cq5aXhd6MTHh/8TrvlsxXknuHqaoApF++zrCUIqr2Ke8tVSYDgaZII52yr
	Y0HSa91P9h25My7nmVKytJXfIM2A9PWpALM87NNHxyx3dnj9gKdqKVDnWiacNRhW
	5mwdRe4YoM0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3554970F;
	Sun,  9 Sep 2012 20:24:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CF08970E; Sun,  9 Sep 2012
 20:24:32 -0400 (EDT)
In-Reply-To: <7va9x0uyz9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 08 Sep 2012 11:54:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E43FA4D0-FADD-11E1-B6F2-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205106>

Junio C Hamano <gitster@pobox.com> writes:

> Angelo Borsotti <angelo.borsotti@gmail.com> writes:
>
>> It makes quite clear that the command accepts wildcards
>> (not expanded by the shell), which was is not clear in the current
>> man page (although one could imagine that <path> could also be a
>> wildcard).
>>
>> P.S. In the man page there is also a <pathspec>
>>
>>     "*git checkout* [-p|--patch] [<tree-ish>] [--] <pathspec>...
>>
>> that should perhaps be a <path>
>
> That's backwards.  Saying <path> as if it means a plain vanilla
> pathname is a cause of confusion.  The command takes pathspec, which
> is a pattern (see "git help glossary"). The places in the text that
> say <path> may need to be fixed.
>
> It just happens that you do not realize that you are using pathspec
> when you say "git checkout hello.c", as the pattern "hello.c" only
> matches the one pathname "hello.c".

I've read Documentation/git-checkout.txt and looked at the use of
"paths".

the most of the "paths" (if not all) in the description are used as
short-hand to mean "paths that the end user specified by giving a
pathspec without repeating that expression over and over again.  And
it should be clear from the context, especially in places where we
say things like "It updates the named paths", "update the index for
the given paths", "checking out paths from the index", "when paths
are given" etc.

As long as readers notice that the command takes <pathspec> on the
command line, and understand <pathspec> has a specific meaning
(i.e. it is a way to specify set of paths to be manipulated) and
semantics, the existing text should be OK.  The <paths> in synopsis
section should be updated to <pathspec>, though.
