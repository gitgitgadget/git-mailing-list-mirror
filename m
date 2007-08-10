From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH 1/2] Fix an illustration in git-rev-parse.txt
Date: Fri, 10 Aug 2007 21:30:56 +0200
Message-ID: <1b46aba20708101230v31c801e4u5ba104b178a1dc84@mail.gmail.com>
References: <7v643nvng8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 21:31:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJaCx-0001lJ-Hn
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 21:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937262AbXHJTa6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 15:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933577AbXHJTa5
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 15:30:57 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:34255 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936275AbXHJTa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 15:30:56 -0400
Received: by rv-out-0910.google.com with SMTP id k20so757610rvb
        for <git@vger.kernel.org>; Fri, 10 Aug 2007 12:30:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aLrdSFSMvouotSJ1Q3OYHRDsS3yXZ4DHnydpsUuce/C7CyIH9ii131TN3+8z/gRX6bs9EsJY/ggPwC/mhNEbMvpHHrXk+DyRAjsywKpyAfnocXqZn6Jx0KmWAPG8CHyf9NcxBkydudbol3xUM9HtNZp97e2YNQDfr34gKSqhOhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PPbpzd1AOd+xeUNx7Y9LEziVt97hRawZqI4uQl40gMXFDDTLDOG9JN3AhwOr3X5Wkey4A8stpCF0Qyw6Bah+vMVe4stLE3UxyKfvfevKjEiOhZDowjAKP5dZm1vJ5eBTpSx1hbNO7LH/gtfNkdTrI5AKYvUycao0u4KLt25VYX0=
Received: by 10.114.59.1 with SMTP id h1mr2868796waa.1186774256059;
        Fri, 10 Aug 2007 12:30:56 -0700 (PDT)
Received: by 10.114.57.10 with HTTP; Fri, 10 Aug 2007 12:30:56 -0700 (PDT)
In-Reply-To: <7v643nvng8.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55568>

Could it be also work to have two backslashes to disable the special
behaviour of that one? I cannot test it now, but it would be the right
way to do it, I think.

2007/8/10, Junio C Hamano <gitster@pobox.com>:
> This hides the backslash at the end of line from AsciiDoc
> toolchain by introducing a trailing whitespace on one line in an
> illustration in git-rev-parse.txt.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Obviously this needs to be applied without --whitespace=strip
>
>  Documentation/git-rev-parse.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index eea9c9c..4b4d229 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -224,7 +224,7 @@ left-to-right.
>      G   H   I   J
>       \ /     \ /
>        D   E   F
> -       \  |  / \
> +       \  |  / \
>          \ | /   |
>           \|/    |
>            B     C
>
>
