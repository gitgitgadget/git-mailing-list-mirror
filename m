From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add 'rm -f' equivalent to 'git rm' example of
 filter-branch --index-filter
Date: Thu, 12 Feb 2009 14:47:52 -0800
Message-ID: <7v4oyzjmqv.fsf@gitster.siamese.dyndns.org>
References: <AB13D1C5-4464-49B5-8314-FCB1E249BF22@semanticart.com>
 <1234461670-25657-1-git-send-email-jacob.helwig@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 23:49:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXkN6-0005Pb-No
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 23:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939AbZBLWsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 17:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754867AbZBLWsA
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 17:48:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbZBLWr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 17:47:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DDA8F998AF;
	Thu, 12 Feb 2009 17:47:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 651A9998AC; Thu,
 12 Feb 2009 17:47:54 -0500 (EST)
In-Reply-To: <1234461670-25657-1-git-send-email-jacob.helwig@gmail.com>
 (Jacob Helwig's message of "Thu, 12 Feb 2009 10:01:10 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 317EC7C6-F957-11DD-B826-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109674>

Jacob Helwig <jacob.helwig@gmail.com> writes:

> Signed-off-by: Jacob Helwig <jacob.helwig@gmail.com>
> ---
>  Documentation/git-filter-branch.txt |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index 451950b..1fbbbb4 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -212,6 +212,11 @@ git filter-branch --index-filter 'git rm --cached filename' HEAD
>  
>  Now, you will get the rewritten history saved in HEAD.
>  
> +As with using `rm filename`, `git rm --cached filename` will fail
> +if the file is absent from the tree of a commit.  If it is not important
> +whether the file is already absent from the tree, you can use
> +`git rm --cached --ignore-unmatch filename` instead.
> +
>  To rewrite the repository to look as if `foodir/` had been its project
>  root, and discard all other history:


Looks sane to me.  Objections?
