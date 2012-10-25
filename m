From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Doc User-Manual: Patch cover letter, three dashes, and
 --notes
Date: Thu, 25 Oct 2012 06:26:38 -0400
Message-ID: <20121025102638.GP8390@sigill.intra.peff.net>
References: <1350855250-2844-1-git-send-email-philipoakley@iee.org>
 <1350855250-2844-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Blake <eblake@redhat.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 12:27:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRKeU-0004g6-4i
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 12:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080Ab2JYK0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 06:26:42 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56108 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964967Ab2JYK0k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 06:26:40 -0400
Received: (qmail 7664 invoked by uid 107); 25 Oct 2012 10:27:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 06:27:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 06:26:38 -0400
Content-Disposition: inline
In-Reply-To: <1350855250-2844-2-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208384>

On Sun, Oct 21, 2012 at 10:34:08PM +0100, Philip Oakley wrote:

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 85651b5..d918c53 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1787,6 +1787,11 @@ $ git format-patch origin
>  will produce a numbered series of files in the current directory, one
>  for each patch in the current branch but not in origin/HEAD.
>  
> +`git format-patch` can include an initial "cover letter". You can insert
> +a commentary on individual patches using a three dash line after the
> +commit message, and before the patch itself. `git format-patch --notes`
> +(v1.8.1) will include the commit's notes in the similar manner.

I'd rather not mention a version number here, as we do not yet know
which version (if any) will contain the feature. Besides, we write our
documentation to match the current version, so as long as this is queued
on top of the new code, I do not see any reason to mention a version at
all.

I'll tweak it while queueing.

-Peff
