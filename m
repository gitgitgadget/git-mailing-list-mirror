From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Documentation: replace SHA1 by SHA-1
Date: Fri, 24 Apr 2009 17:30:56 -0400
Message-ID: <20090424213056.GC14435@coredump.intra.peff.net>
References: <1240584575-5702-1-git-send-email-git@drmicha.warpmail.net> <1240584575-5702-2-git-send-email-git@drmicha.warpmail.net> <1240584575-5702-3-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 23:32:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxT0k-0005tJ-S5
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 23:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757626AbZDXVbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 17:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757462AbZDXVbH
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 17:31:07 -0400
Received: from peff.net ([208.65.91.99]:59704 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757083AbZDXVbG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 17:31:06 -0400
Received: (qmail 31618 invoked by uid 107); 24 Apr 2009 21:31:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 17:31:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 17:30:56 -0400
Content-Disposition: inline
In-Reply-To: <1240584575-5702-3-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117492>

On Fri, Apr 24, 2009 at 04:49:35PM +0200, Michael J Gruber wrote:

> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -47,7 +47,7 @@ base-name::
>  	Write into a pair of files (.pack and .idx), using
>  	<base-name> to determine the name of the created file.
>  	When this option is used, the two files are written in
> -	<base-name>-<SHA1>.{pack,idx} files.  <SHA1> is a hash
> +	<base-name>-<SHA-1>.{pack,idx} files.  <SHA-1> is a hash
>  	of the sorted object names to make the resulting filename
>  	based on the pack content, and written to the standard
>  	output of the command.

Same complaint as the last patch. The extra hyphen is really
distracting, as it is in the midst of an already hyphenated filename.
Interestingly, I don't find <base-name> as bad. I think it is because
the single numeric character with the punctuation is just hard on the
eyes.

-Peff
