From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] Clarify and fix English in git-rm documentation.
Date: Wed, 16 Apr 2008 00:06:40 -0700
Message-ID: <7vve2is2gv.fsf@gitster.siamese.dyndns.org>
References: <E1Jl91r-0000yT-8T@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Loeliger <jdl@jdl.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 09:07:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm1jy-0006P3-0r
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 09:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbYDPHGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 03:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbYDPHGt
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 03:06:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbYDPHGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 03:06:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 326E81C90;
	Wed, 16 Apr 2008 03:06:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7D9491C8F; Wed, 16 Apr 2008 03:06:43 -0400 (EDT)
In-Reply-To: <E1Jl91r-0000yT-8T@jdl.com> (Jon Loeliger's message of "Sun, 13
 Apr 2008 15:42:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79683>

Jon Loeliger <jdl@jdl.com> writes:

> diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
> index dc36c66..2066def 100644
> --- a/Documentation/git-rm.txt
> +++ b/Documentation/git-rm.txt
> @@ -11,28 +11,34 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> +Remove files from the index, or from the working tree and the index.
> +`git rm` will not remove a file from just your working directory.

The last sentence made me stop reading and read the paragraph twice and
half.  Perhaps it would make it easier to read if we make it

	(there is no option to remove a file only from work tree and keep
	it in the index; use regular "/bin/rm" if you want to do that).

a parenthesized note as the tail part of the previous sentence?

> +The files being removed have to be identical to the tip of the branch,
> +and no updates to their contents can be staged in the index.

Perhaps add "This can be overridden with the `-f` option" here?
