From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] builtin/remote: remove postfixcmp() and use suffixcmp()
 instead
Date: Mon, 4 Nov 2013 09:56:02 -0800
Message-ID: <20131104175602.GB31881@google.com>
References: <20131103201303.14446.7508.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Nov 04 18:56:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdONp-0001bi-Hk
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 18:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab3KDR4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 12:56:08 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:43334 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab3KDR4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 12:56:07 -0500
Received: by mail-pd0-f179.google.com with SMTP id y10so7045283pdj.10
        for <git@vger.kernel.org>; Mon, 04 Nov 2013 09:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ykm4OWdseE8IiUMb2VLrwNvqEiJJ8H0jtDvIZRLkQlE=;
        b=JchjG71fPHg8qa+JeueR9oxRMFkZTbzYToC4kXKbbrycn8hWn0+410x4caDnPJq+6d
         YflEPDzV7yyFawntFrTVW+pCHqJxV15HWkvNfzCDnqSSLZ/HN2VNzKNpfx+GEUoDHVVO
         WDShW03AwYslJPjbTifgVlSLwA7/FUuG8oP+XWQ7i/ct28uJrZc88mBTaOzoRmUxFZiJ
         2I4Qk4EmXBoMZkLGQQ1vh2E+CC4r14OXWkZu0sni2oWSrMiagMdZqK7Sox2bwMXppwMF
         7zdBgLc71k/72Wh0CAdrNKSMVF/T1JFPW+LErMCS7vnRt6ZKZCSwoDS6g2gF/mHGThcW
         jV0w==
X-Received: by 10.66.145.40 with SMTP id sr8mr12725687pab.60.1383587767015;
        Mon, 04 Nov 2013 09:56:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id zq10sm34558706pab.6.2013.11.04.09.56.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 04 Nov 2013 09:56:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131103201303.14446.7508.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237291>

Christian Couder wrote:

> Commit 8cc5b290 (git merge -X<option>, 25 Nov 2009) introduced
> suffixcmp() with nearly the same implementation as postfixcmp()
> that already existed since commit 211c8968 (Make git-remote a
> builtin, 29 Feb 2008).
[...]
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/remote.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)

Makes sense.  Thanks for noticing.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
