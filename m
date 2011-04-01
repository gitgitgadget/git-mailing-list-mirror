From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/3] revisions.txt: language improvements
Date: Fri, 01 Apr 2011 15:05:40 -0700
Message-ID: <7vsju1eiff.fsf@alter.siamese.dyndns.org>
References: <cover.1301569271.git.git@drmicha.warpmail.net>
 <cover.1301649867.git.git@drmicha.warpmail.net>
 <cc9e86c7a7cacc7eea66090b38443739e6fbc672.1301649867.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 02 00:06:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5mTg-0004JF-Nn
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 00:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758519Ab1DAWFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 18:05:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758050Ab1DAWFy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 18:05:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 18D3C4661;
	Fri,  1 Apr 2011 18:07:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dq05x5f8RQ23fytdjNdwIHz8bPQ=; b=DgOmDf
	J5ofd1S8b2+NR9sC4gEXBSKY+GxS9pNJbVV0SNM7p4H1bGx4YwjDTrx/DLyOyNSF
	8pwtfLfy2SyA4SrEdj9C7YRGnfAxPBKTb0NNTanVRol/JYfxn6OXGFb8Yo4Yr1Gj
	HVcE+wItqPifWrz5wgYbKZzuDAaTYI1F+s+Hk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NazHMmK5d8T4U+PxuRbhu/EsB0WGwJxB
	exHtpIqbAPBa+kY9mX1kEVEJI/qrjDcFibLJD7gLzcofAMuLXO+kXLjnvq6ihHrx
	VK3HIUh+KgmweRDnOQyT1A6HlTXBKw4xyQ3GaVKX1Wkr3HVx6azfrJUTPqUUb1WP
	roE+W1aaA8I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CCF39465F;
	Fri,  1 Apr 2011 18:07:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 66C99465B; Fri,  1 Apr 2011
 18:07:32 -0400 (EDT)
In-Reply-To: <cc9e86c7a7cacc7eea66090b38443739e6fbc672.1301649867.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 1 Apr 2011 11:27:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 745D6736-5CAC-11E0-8949-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170630>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

Thanks.

>  Documentation/revisions.txt |   68 +++++++++++++++++++++---------------------
>  1 files changed, 34 insertions(+), 34 deletions(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 92bc662..25125c3 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -2,20 +2,20 @@ SPECIFYING REVISIONS
>  --------------------
>  
>  A revision parameter '<rev>' typically, but not necessarily, names a
> -commit object.  They use what is called an 'extended SHA1'
> +commit object.  It uses what is called an 'extended SHA1'
>  syntax.  Here are various ways to spell object names.  The
> -ones listed near the end of this list are to name trees and
> +ones listed near the end of this list name trees and
>  blobs contained in a commit.
>  
>  '<sha1>', e.g. 'dae86e1950b1277e545cee180551750029cfe735', 'dae86e'::
>    The full SHA1 object name (40-byte hexadecimal string), or
> -  a substring of such that is unique within the repository.
> +  a substring that is unique within the repository.

Do we need to rephrase this a bit more, so that it would be clear that
"e86e1950b" is not an abbreviated object name, even though it is a
substring and may be unique within the repository?

Perhaps "a prefix of such a full SHA-1 object name that is unique..."?

> @@ -79,8 +79,8 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
>  
>  '@\{<n>\}', e.g. '@\{1\}'::
>    You can use the '@' construct with an empty ref part to get at a
> +  reflog of the current branch. For example, if you are on
> +  branch 'blabla' then '@\{1\}' means the same as 'blabla@\{1\}'.

Is that "a reflog of the current branch", or because there is only one
reflog, should it be "the reflog of the current branch"?  Ah, we mean one
entry in the reflog (an entry of the reflog of the current branch), so
this probably is Ok.

> @@ -133,8 +133,8 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
>    a commit whose commit message matches the specified regular expression.
>    This name returns the youngest matching commit which is
>    reachable from any ref.  If the commit message starts with a
> +  '!' you have to repeat that;  the special sequence ':/!',
> +  followed by something else than '!', is reserved for now.

Hmm, shouldn't it be "something OTHER than" instead?

Grammar is hard; thanks for cleaning them up.
