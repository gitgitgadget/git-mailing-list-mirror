From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 5/7] i18n: am: mark more strings for translation
Date: Sat, 21 Jul 2012 18:27:40 +0200
Message-ID: <500AD87C.3010201@gmail.com>
References: <cover.1342884458.git.worldhello.net@gmail.com> <a7d2248051ddc62e38e67d9efbb41c01498c7a4c.1342884459.git.worldhello.net@gmail.com> <0fd901035a418562d3d9282553a96124814a298a.1342884459.git.worldhello.net@gmail.com> <77cbbce0450735a66ef1d9101af0bc82e3fc545c.1342884459.git.worldhello.net@gmail.com> <941f7bd695e8a14c940a5b8e4214d2773ae82557.1342884459.git.worldhello.net@gmail.com> <d5c4000b859f4b30af6fc3faec008403b82246bf.1342884459.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 18:27:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SscX1-0004ea-EN
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 18:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757Ab2GUQ1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 12:27:47 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37703 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525Ab2GUQ1q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 12:27:46 -0400
Received: by bkwj10 with SMTP id j10so4172476bkw.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=n8GcPTyxxfuYokkq2W+9fC1FELxTvnbODjVYDnMFSnM=;
        b=ouOS5/P1wf66iY2T56vShwfgrbrcl9BaTSJwSP2hkf/4FvkffAuFCGExhwUetQ705g
         tzdw86jfGGm2BSMLpIUIwgLfGLLGF8jZg5Cc061PXVH5x9pd1NjFBcDbLC9tXPdounH3
         6RI2TJLm25cFFh88zsa9Ob7qcg5bVtcBB95z8bzxZDRHhLncIl5Cg9euU9N2Hh45XZVf
         F7WAbCAwIeW6GcSgUu2WRdL+qRSYKPv2TiOySTY7PnBCAVE3vqh1s5dQQmvZTLWeekBh
         mtTqqw/5F91m9XeS9Q7KsO5W+PSnFhGppZx686aArNRIS3wNeqUXjnLzeaxzLwodGYlg
         lXMQ==
Received: by 10.204.136.215 with SMTP id s23mr4863126bkt.32.1342888065201;
        Sat, 21 Jul 2012 09:27:45 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id z19sm4256448bkw.10.2012.07.21.09.27.43
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 09:27:44 -0700 (PDT)
In-Reply-To: <d5c4000b859f4b30af6fc3faec008403b82246bf.1342884459.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201826>

On 07/21/2012 05:50 PM, Jiang Xin wrote:
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  git-am.sh | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/git-am.sh b/git-am.sh
> index b6a53..20c1a 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -92,7 +92,7 @@ safe_to_abort () {
>  	then
>  		return 0
>  	fi
> -		gettextln "You seem to have moved HEAD since the last 'am' failure.
> +	gettextln "You seem to have moved HEAD since the last 'am' failure.
>
Spurious whitespace change?  It certainly is unrelated with what you say in
the commit message ...

Regards,
  Stefano
