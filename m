From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-scm.com refresh
Date: Sat, 05 May 2012 18:39:14 -0700
Message-ID: <7vwr4q6qbh.fsf@alter.siamese.dyndns.org>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
 <7vd36j8lc3.fsf@alter.siamese.dyndns.org>
 <CAP2yMaJsDysqwwUga+fyWhUV-r78FoK7psY7howNBOCnsKLhvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 03:39:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQqS2-0005Fy-Ej
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 03:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab2EFBjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 21:39:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45503 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636Ab2EFBjR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 21:39:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 620E081FC;
	Sat,  5 May 2012 21:39:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q8fV9fOV2Wsrzug6RQlYY1ewHLU=; b=kJATeR
	j0jczEytpKtnMxdxnc8lkFD39Dxmj34idWJ/1KnWpT9d9wUVn+h0h8voxF5HDYq4
	NlA3UsQH/5Vg1vGq+2G9YqvWpVqMQ7SnPVODja5kueLpZqLipCf81yW6LZngLCCJ
	eoQaStoPoEy8jTODRpZGXhpb3/1SjkRLHPHvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xezALgLldXKl1BiuzIwYAKbyqsSXD/VT
	y5hsmZq4YA90mIHzdgeaM3XURx5GhV7dh4A1wximORGpdCttbezWKSnTir9fy7pl
	TVuPC+ni1QIAritm1YDPtyY7mqLOtsvlWvu/htA45DWIZDNuywq4IGyJ9CwQvcSn
	GmPTJNMdm0s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 496C881FB;
	Sat,  5 May 2012 21:39:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB59F81FA; Sat,  5 May 2012
 21:39:15 -0400 (EDT)
In-Reply-To: <CAP2yMaJsDysqwwUga+fyWhUV-r78FoK7psY7howNBOCnsKLhvA@mail.gmail.com> (Scott
 Chacon's message of "Sat, 5 May 2012 15:38:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A365D40-971C-11E1-B52E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197143>

Scott Chacon <schacon@gmail.com> writes:

>> As "diff" is listed in "Basic Snapshotting", and it will not
>> be able to achieve that without being able to apply its output back to the
>> working tree or to the index, I would suggest moving "apply" to the
>> section as well.
>
> I have to disagree.  You are thinking of 'apply' from an internals
> perspective I have to assume, because I use 'diff' every single day
> for all sorts of stuff ("what is modified and unstaged?", "what is
> modified and staged?", "what is different between these two branches?"
> etc) ...

The other day when I was surfing the 'net, I found a blog that was
complaining about Git UI.  Some of the things were worth listening to, but
there was one item I really had to scratch my head where the misconception
behind the complaint came from.  I am typing from memory without bothering
to go back to the site to quote, but the complaint essentially was:

        Getting a patch is easy with "git diff", but to apply it you need
        to make it an email and feed it to "git am"???  That's crazy.

Of course it *is* crazy, if that were the case. I was wondering why the
obvious "patch" (or "git apply") did not get into the mind of the author,
and I think I now know why.

If the owner of the site that people call "git's home page" does not care
about those who take diffs and apply them as patches, and thinks "git
apply" as a mere implementation detail of "git am", it is understandable
that such a misconception is spread widely to harm users without getting
corrected. Who knows other Git fanboys are spreading misinformation in a
similar way. Sigh...

> ... where I can't think of a single time I've ever used 'apply'.  In
> fact, even the times when I have needed to apply a patch generated
> from 'diff' I used 'patch -p1' because I know it better.

As you are supposed to be one of the top-level Git Teachers, I wish you
knew better.  Here is a free Git lesson.  Consider "git apply" as

    a better version of "patch" that knows how to work better with Git by
    understanding rename and binary patches, and allows them to be applied
    to the working tree and the index (the latter is most useful when the
    patch contains new files)

and teach it as such.

"diff" pairs with "apply", and "format-patch" pairs with "am".

I wouldn't mind adding "git patch" as a built-in synonym/alias for "git
apply", if you think that would make the above pairing more obvious.  Many
computer users know what "patch" does already even they have never used
any SCM.

[Footnote]
