From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Tue, 02 Sep 2008 22:26:29 +0200
Message-ID: <vpq3aki1eh6.fsf@bauges.imag.fr>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Tue Sep 02 22:29:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KacVK-0004bz-Lo
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 22:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbYIBU23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 16:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbYIBU23
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 16:28:29 -0400
Received: from imag.imag.fr ([129.88.30.1]:40045 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646AbYIBU22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 16:28:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m82KQhTU019448
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Sep 2008 22:26:44 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KacSL-0001db-LC; Tue, 02 Sep 2008 22:26:29 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KacSL-0003J8-Il; Tue, 02 Sep 2008 22:26:29 +0200
In-Reply-To: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl> (Pieter de Bie's message of "Tue\,  2 Sep 2008 21\:31\:45 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 02 Sep 2008 22:26:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94705>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> +       if (!strcmp("HEAD", head))
> +               printf("You are on a detached head, so this commit "
> +                       "has not been recorded in a branch.\n"
> +                       "If you don't want to lose this commit, checkout a "
> +                       "branch and then run:\n"
> +                       "       git merge %s\n", sha1_to_hex(sha1));

I'd say

+                       "If you don't want to lose this commit, run "
+                       "git branch <some-name>\n"
+			"to create a named branch for the commit you just made");

(or whatever better wording you find, but I think suggesting to name
the branch makes more sense that merging it)

-- 
Matthieu
