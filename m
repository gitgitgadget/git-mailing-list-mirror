From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Minor wording changes in the keyboard descriptions in
 git-add --interactive.
Date: Fri, 07 Mar 2008 15:47:14 -0800
Message-ID: <7vk5ke14hp.fsf@gitster.siamese.dyndns.org>
References: <1204928211-7168-1-git-send-email-vineet@doorstop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vineet Kumar <vineet@doorstop.net>
X-From: git-owner@vger.kernel.org Sat Mar 08 00:48:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXmII-0006b3-Iv
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 00:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbYCGXrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 18:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbYCGXrY
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 18:47:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbYCGXrX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 18:47:23 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 67F0E2299;
	Fri,  7 Mar 2008 18:47:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B716C2297; Fri,  7 Mar 2008 18:47:18 -0500 (EST)
In-Reply-To: <1204928211-7168-1-git-send-email-vineet@doorstop.net> (Vineet
 Kumar's message of "Fri, 7 Mar 2008 14:16:51 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76532>

Vineet Kumar <vineet@doorstop.net> writes:

> There were some inconsistent mixing of "this hunk" and "that hunk" referring
> to the same hunk; I switched them all to "this".  There was also a missing
> "the".
> ---
>  Documentation/git-add.txt |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 4779909..bc74fc0 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -207,10 +207,10 @@ patch::
>    and the working tree file and asks you if you want to stage
>    the change of each hunk.  You can say:
>  
> -       y - add the change from that hunk to index
> -       n - do not add the change from that hunk to index
> -       a - add the change from that hunk and all the rest to index
> -       d - do not the change from that hunk nor any of the rest to index
> +       y - add the change from this hunk to index
> +       n - do not add the change from this hunk to index
> +       a - add the change from this hunk and all the rest to index
> +       d - do not add the change from this hunk nor any of the rest to index
>         j - do not decide on this hunk now, and view the next
>             undecided hunk
>         J - do not decide on this hunk now, and view the next hunk

Hmm.  Do we perhaps want to match this with the help text in
"sub help_patch_cmd" of git-add--interactive.perl?

