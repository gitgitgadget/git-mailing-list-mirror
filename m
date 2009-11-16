From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Doc: mention the crlf attribute in config autocrlf section
Date: Mon, 16 Nov 2009 19:50:48 +0900
Message-ID: <20091116195048.6117@nanako3.lavabit.com>
References: <1258223700-4009-1-git-send-email-mmogilvi_git@miniinfo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 11:51:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9zAy-0002aX-Rr
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 11:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbZKPKuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 05:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbZKPKuv
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 05:50:51 -0500
Received: from karen.lavabit.com ([72.249.41.33]:48141 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545AbZKPKut (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 05:50:49 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 68D2911B94E;
	Mon, 16 Nov 2009 04:50:52 -0600 (CST)
Received: from 6910.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id NQQXHWABJO6N; Mon, 16 Nov 2009 04:50:52 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=hRyh+YS0dQHi8fu1V4TOzSkstVqebxFvMWlt59JlQ5ZpOFXoyuDcxGqivCpxiTtLDIBX5Zgv1gnsgm0aFJmgU656iEWwYajC2J82kdIcR9JPDhRfBDcVpykhxp/EjZ+h9MumXfJn1ldsnLld4DpzmlAxEiYqN9gEPiz3f6WdPSE=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1258223700-4009-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132997>

Quoting Matthew Ogilvie <mmogilvi_git@miniinfo.net>

> The reverse reference has long existed, and the autocrlf description
> was actually obsolete and wrong (saying only file content is used),
> not just incomplete.

What do you mean by "reverse reference"?

> Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
> ---
>  Documentation/config.txt |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d1e2120..0dc6b12 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -169,9 +169,10 @@ core.autocrlf::
>  	writing to the filesystem.  The variable can be set to
>  	'input', in which case the conversion happens only while
>  	reading from the filesystem but files are written out with
> -	`LF` at the end of lines.  Currently, which paths to consider
> -	"text" (i.e. be subjected to the autocrlf mechanism) is
> -	decided purely based on the contents.
> +	`LF` at the end of lines.  A file is considered
> +	"text" (i.e. be subjected to the autocrlf mechanism) based on
> +	the file's `crlf` attribute, or if `crlf` is unspecified,
> +	based on the file's contents.  See linkgit:gitattributes[5]. 
>  
>  core.safecrlf::
>  	If true, makes git check if converting `CRLF` as controlled by

The updated text looks correct to me.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
