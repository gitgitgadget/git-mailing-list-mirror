From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git clone -s documentation: force a new paragraph for the NOTE
Date: Mon, 11 Feb 2008 19:07:39 -0800
Message-ID: <7v4pce7tz8.fsf@gitster.siamese.dyndns.org>
References: <20080212001257.GG25954@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 04:08:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOlVU-0006bI-QQ
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 04:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583AbYBLDHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 22:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756581AbYBLDHw
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 22:07:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563AbYBLDHv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 22:07:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A7FF37AD;
	Mon, 11 Feb 2008 22:07:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AF9B37A4;
	Mon, 11 Feb 2008 22:07:42 -0500 (EST)
In-Reply-To: <20080212001257.GG25954@genesis.frugalware.org> (Miklos Vajna's
	message of "Tue, 12 Feb 2008 01:12:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73623>

Miklos Vajna <vmiklos@frugalware.org> writes:

> It should be loud and clear.
> ...
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 2341881..9758243 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -62,12 +62,13 @@ OPTIONS
>  	.git/objects/info/alternates to share the objects
>  	with the source repository.  The resulting repository
>  	starts out without any object of its own.
> -	*NOTE*: this is a possibly dangerous operation; do *not* use
> -	it unless you understand what it does. If you clone your
> -	repository using this option, then delete branches in the
> -	source repository and then run linkgit:git-gc[1] using the
> -	'--prune' option in the source repository, it may remove
> -	objects which are referenced by the cloned repository.

The "Note" is already in bold and quite loud.  I am not sure if
this is worth it.
