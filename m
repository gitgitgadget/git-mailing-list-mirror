From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: [PATCH 2/2] Be consistent in switch usage for tar
Date: Mon, 5 Jan 2009 21:19:50 +0300
Message-ID: <20090105181950.GA5403@myhost>
References: <1231169137-32653-1-git-send-email-henrik@austad.us> <1231169137-32653-2-git-send-email-henrik@austad.us> <1231169137-32653-3-git-send-email-henrik@austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: henrik@austad.us
X-From: git-owner@vger.kernel.org Mon Jan 05 19:21:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJu4l-0005ug-Nb
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 19:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbZAEST6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 13:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbZAEST6
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 13:19:58 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:57663 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZAEST5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 13:19:57 -0500
Received: by bwz14 with SMTP id 14so22981686bwz.13
        for <git@vger.kernel.org>; Mon, 05 Jan 2009 10:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=1pGBfpJ8lEhthJJmoU8Cdar/apAxL9ceGVz9wVvIt64=;
        b=ZXDJxY/FpSVWge1w+2zg4TqjNUP92FsXYaC2jAm+9BaRaJ7hQbvUSO338W9CzjBcH8
         UgwOwW4IAB9bB0+Md0TuxqONQOqOIZfTUkSP88mssqjS6hhXImOZp7RssdXnTOCISFAW
         YkAfcX23jfpf9c+bLFF13OK+4chNbvO4DxWOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vpnLoCLlgWQCymI8ZAtELt8JzAkg4MdMrIELEG4/lYvZsmFERuXagzvxQIC3MMxV6j
         i8umKyrYLVScYxNfyCPQLJ7OPO78+P7vsZMDK77/8nKoanOFrh6cFLkKI/6q/lEAxycA
         n+34WQbkm3y3QMFqezYhmH0q7Wu3TuqhM9dzs=
Received: by 10.223.112.201 with SMTP id x9mr14811517fap.69.1231179594104;
        Mon, 05 Jan 2009 10:19:54 -0800 (PST)
Received: from smtp.gmail.com (ppp91-77-14-132.pppoe.mtu-net.ru [91.77.14.132])
        by mx.google.com with ESMTPS id f31sm38489914fkf.26.2009.01.05.10.19.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Jan 2009 10:19:53 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Mon, 05 Jan 2009 21:19:50 +0300
Content-Disposition: inline
In-Reply-To: <1231169137-32653-3-git-send-email-henrik@austad.us>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104590>

On 16:25 Mon 05 Jan     , henrik@austad.us wrote:
> From: Henrik Austad <henrik@austad.us>
> 
> tar handles switches with and witouth preceding '-', but the documentation should be

s/witouth/without

> consistent nonetheless.
> 
> Signed-off-by: Henrik Austad <henrik@austad.us>
> ---
>  Documentation/user-manual.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 5242a7e..19f571a 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1009,7 +1009,7 @@ $ git init
>  If you have some initial content (say, a tarball):
>  
>  -------------------------------------------------
> -$ tar -xzvf project.tar.gz
> +$ tar xzvf project.tar.gz

Btw, tar manpage uses dashed options in usage examples:

	tar -xvf foo.tar
		verbosely extract foo.tar
	...


>  $ cd project
>  $ git init
>  $ git add . # include everything below ./ in the first commit:
> -- 
> 1.6.1.36.g8430e
