From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH v3 09/10] remote-hg: test: be a little more quiet
Date: Tue, 14 May 2013 15:27:21 -0500
Message-ID: <51929e298955c_13a8f89e18228b@nysa.mail>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
 <1368486720-2716-10-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 22:29:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLqT-0002ic-4v
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 22:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758152Ab3ENU3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 16:29:08 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51187 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757626Ab3ENU3H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 16:29:07 -0400
Received: by mail-ob0-f174.google.com with SMTP id un3so1115666obb.33
        for <git@vger.kernel.org>; Tue, 14 May 2013 13:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=HWd7z0HahN3dnAYiFvnkFjTG8VZlr8JS0eXFHPeJGcw=;
        b=HnilHmrzQlLPiixDYGZ2ApCg7vHLpPAxctHoEtrCzf6xzAJ00qQznkJYpRy+Iulnvj
         J2T1zoolXJK9vOwTT9lrxjxGwa1XvwABWPloAWhz/jQ6HlShxNO87RbJGG5zjH4s7Bgd
         KRhep6T5EjnOkA2hC4TtJElrCvlHjTID+o5tPfQn5xrLo5olzZd5jcwnp99e1g5rrjAl
         UrFxmQITP96HmKKVtqniE1zyhlaH/5U0sLmCGapBUgT6+WxtDDNkN4hTr5pU/Al33aUJ
         jPdKXsTlDcE8VuMSxP+TC2IzMuyXew15vUFulvi28pn8Fi1mr3YEwrBp2uprcuhn1BRe
         m8Rw==
X-Received: by 10.182.47.196 with SMTP id f4mr15476411obn.31.1368563346481;
        Tue, 14 May 2013 13:29:06 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm23751993oez.4.2013.05.14.13.29.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 13:29:05 -0700 (PDT)
In-Reply-To: <1368486720-2716-10-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224341>

No-brainer; improve one test.

Felipe Contreras wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/test-hg.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
> index 8de2aa7..f8d1f9e 100755
> --- a/contrib/remote-helpers/test-hg.sh
> +++ b/contrib/remote-helpers/test-hg.sh
> @@ -109,10 +109,10 @@ test_expect_success 'update bookmark' '
>    (
>    git clone "hg::$PWD/hgrepo" gitrepo &&
>    cd gitrepo &&
> -  git checkout devel &&
> +  git checkout --quiet devel &&
>    echo devel > content &&
>    git commit -a -m devel &&
> -  git push
> +  git push --quiet
>    ) &&
>  
>    hg -R hgrepo bookmarks | egrep "devel[	 ]+3:"
> -- 
> 1.8.3.rc1.579.g184e698



-- 
Felipe Contreras
