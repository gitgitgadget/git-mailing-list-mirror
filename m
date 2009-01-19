From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Documentation: mention branches rather than heads
Date: Sun, 18 Jan 2009 19:46:02 -0800
Message-ID: <7vhc3wrm9x.fsf@gitster.siamese.dyndns.org>
References: <1232289418-25627-1-git-send-email-mail@cup.kalibalik.dk>
 <1232289418-25627-2-git-send-email-mail@cup.kalibalik.dk>
 <1232289418-25627-3-git-send-email-mail@cup.kalibalik.dk>
 <1232289418-25627-4-git-send-email-mail@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Mon Jan 19 04:47:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOl6r-0001J7-AK
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 04:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757952AbZASDqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 22:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757919AbZASDqK
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 22:46:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757711AbZASDqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 22:46:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 440261CD27;
	Sun, 18 Jan 2009 22:46:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1DFFE1CD26; Sun,
 18 Jan 2009 22:46:04 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B4AA9D1C-E5DB-11DD-85F4-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106314>

Anders Melchiorsen <mail@cup.kalibalik.dk> writes:

> Most of the git push page talks about branches, so make it consistent
> also in this paragraph.

> Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
> ---
>  Documentation/git-push.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 6d3c711..a7a6f4c 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -57,8 +57,8 @@ Pushing an empty <src> allows you to delete the <dst> ref from
>  the remote repository.
>  +
>  The special refspec `:` (or `+:` to allow non-fast forward updates)
> -directs git to push "matching" heads: for every head that exists on
> -the local side, the remote side is updated if a head of the same name
> +directs git to push "matching" branches: for every branch that exists on
> +the local side, the remote side is updated if a branch of the same name
>  already exists on the remote side.  This is the default operation mode
>  if no explicit refspec is found (that is neither on the command line
>  nor in any Push line of the corresponding remotes file---see below).

Consistency is good, and I agree "head" may be suboptimal here as this
part tries to give formal semantics to what various refspecs do.

I first thought it would make more sense to say "ref" instead, just like
the previous paragraph that talks about :<dst> form explains it is a way
to remove a "ref".  But we do only matching branches with : syntax these
days since 098e711 ("git-push $URL" without refspecs pushes only matching
branches, 2007-07-01); I agree with the updated text for that reason, but
I think the commit log message is wrong.

Thanks.
