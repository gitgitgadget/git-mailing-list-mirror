From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsimport: document that -M can be used multiple times
Date: Thu, 21 Feb 2008 14:52:35 -0800
Message-ID: <7vhcg1sz0s.fsf@gitster.siamese.dyndns.org>
References: <1203604906-29113-1-git-send-email-book@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Philippe Bruhat (BooK)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 00:00:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSKOR-0004Hz-2M
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 23:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757965AbYBUW6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 17:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935717AbYBUW6t
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 17:58:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935710AbYBUW6r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 17:58:47 -0500
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Feb 2008 17:58:47 EST
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F74D1281;
	Thu, 21 Feb 2008 17:52:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9306B1280; Thu, 21 Feb 2008 17:52:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74674>

"Philippe Bruhat (BooK)" <book@cpan.org> writes:

> Also document the capture behaviour (source branch name in $1)
>
> Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>
> ---
>  Documentation/git-cvsimport.txt |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
> index 6f91b9e..5e0a314 100644
> --- a/Documentation/git-cvsimport.txt
> +++ b/Documentation/git-cvsimport.txt
> ...
> @@ -110,6 +110,11 @@ If you need to pass multiple options, separate them with a comma.
>  	regex. It can be used with '-m' to enable the default regexes
>  	as well. You must escape forward slashes.
>  
> +	The regex must capture the source branch name in $1.
> +
> +	This option can be used several times to provide several
> +	detection regexes.
> +
>  -S <regex>::
>  	Skip paths matching the regex.

Hmmm.  Have you tried formatting this to see it produces a
sensible result?
