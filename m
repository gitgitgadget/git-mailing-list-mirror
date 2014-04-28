From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Mention "git blame" improvements in release notes
Date: Mon, 28 Apr 2014 12:35:02 -0700
Message-ID: <xmqq38gxqmc9.fsf@gitster.dls.corp.google.com>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
	<1398470210-28746-2-git-send-email-dak@gnu.org>
	<7vmwf8huey.fsf@alter.siamese.dyndns.org>
	<87zjj86j4a.fsf@fencepost.gnu.org>
	<xmqqzjj5s8hs.fsf@gitster.dls.corp.google.com>
	<87y4yp4ame.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:35:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerKh-0002IR-By
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136AbaD1TfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:35:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755761AbaD1TfI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:35:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDCD381DF3;
	Mon, 28 Apr 2014 15:35:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KEroGDS5n1vdc8AEnKDaSXF/MuQ=; b=JV+QiN
	lvnBMghb/EUe00bZdBvPemtdUV45XwL8rKPE4aV0mFdAS3deCMOb81FyNvEH0kMj
	6naDkTTZZvb15WCcUFAnt7Fmre+qbninb6nVE/WBOxSuhGWWGdhuzb2Rb+PWjAxZ
	QLHcdQbQOUetwhQXK2Mo9OeXwxWV6f5wTmAcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MupNEUTF0Ey4OrxDv1RIxwQv/Ox2yNYL
	ozIBysA4d9UHTpi22ykVa4gtw9gHZhqP+rQhpZCjZ4iXAh/z5gGzpTRpqawZzL7L
	sfDiMLMuLImcHzWzTX8ByvNWY4y2zSI5Ys9PBxPaJ0oH8yQDdrMXMfGgtr+l7DUb
	fmLjECS153s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D37F381DF2;
	Mon, 28 Apr 2014 15:35:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1987481DE8;
	Mon, 28 Apr 2014 15:35:04 -0400 (EDT)
In-Reply-To: <87y4yp4ame.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Mon, 28 Apr 2014 19:39:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3245C106-CF0C-11E3-99F7-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247413>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> But still, I am not convinced that the release notes is a good place
>> to do this, and would be happier if you can think of a better venue.
>
> "This change has been contributed by an independent developer on a
> contingency base.  To make this approach work, please contact him if you
> consider it worth recompensating."

I write things under three personalities.  As just one of the people
active in the Git development community, as the maintainer of the
project, and saying things on behalf of "the Git project".

The distinction between the latter two may be subtle, but it matters
to me.  And in my mind, I write the Release Notes on behalf of the
project.

 * The performance of "git blame" has been greatly improved.  Thanks
   David Kastrup for his huge effort.

is perhaps as far as I can go in that capacity, without singling out
one contributor among 80+ contributors with changes between 1.9 and
2.0 (among which a dozen or so have more than 10 patches---some are
trivial and patch count alone does not do justice, though) with
similar "pay them to show your appreciation" pleas.

I however feel that I can certainly do that as an active (and highly
visible) contributor, and even as the maintainer.

I guess we probably can add "See $URL if you are interested in his
further plans" after that two-line item and let you write whatever
you want at that page pointed at by the URL, though.
