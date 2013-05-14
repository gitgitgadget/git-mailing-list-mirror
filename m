From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH v3 01/10] remote-hg: trivial cleanups
Date: Tue, 14 May 2013 15:12:58 -0500
Message-ID: <51929aca93f20_13a8f89e181462@nysa.mail>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
 <1368486720-2716-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 22:14:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLcZ-0001Vb-Um
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 22:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757963Ab3ENUOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 16:14:47 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:38585 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358Ab3ENUOr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 16:14:47 -0400
Received: by mail-ob0-f182.google.com with SMTP id va2so1079516obc.41
        for <git@vger.kernel.org>; Tue, 14 May 2013 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=YR3RMzCHglOLmd1o6A7oe8WkPvaelr/f7Mo4TgiNQQ0=;
        b=IlwzxL+nUrPkjZuUuLcDC3WuX9xt6HfxMbO63rxXOqmYcF9T+zWoGBK86zq4KZINFE
         ku91vgXNAdoltMYf6qEk6M/RzWPdqqQOwO9ScfawWWjVy6Hh+j814TJ9w4lEpF5JN3LE
         nkIr+Egb5kQFr7i36RWDUznwk7f5qdB+WTsA5iIE26CuObzUfnqzmEeXyuq9LY2xqOXf
         ktFC26XU2UDTtfhJ+NWOfh9Q+1zfLCaXf2HCS1s1Bh/OuQWVY2vWYAhw5DBIRvvywofo
         +kfgIfoJJMRnixNMcO0DvUF8FAkF7DGUXUCiW8XB0iSRK+7BTjZivdePY6gEjGT5s5+q
         BxNw==
X-Received: by 10.60.133.240 with SMTP id pf16mr11892654oeb.28.1368562485349;
        Tue, 14 May 2013 13:14:45 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id yx4sm12386212obb.11.2013.05.14.13.14.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 13:14:44 -0700 (PDT)
In-Reply-To: <1368486720-2716-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224333>

This is a trivial cleanup, cannot cause regressions.

Felipe Contreras wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg     | 2 +-
>  contrib/remote-helpers/test-hg-hg-git.sh | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 96ad30d..d33c7ba 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -538,7 +538,7 @@ def list_head(repo, cur):
>      g_head = (head, node)
>  
>  def do_list(parser):
> -    global branches, bmarks, mode, track_branches
> +    global branches, bmarks, track_branches
>  
>      repo = parser.repo
>      for bmark, node in bookmarks.listbookmarks(repo).iteritems():
> diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
> index 8440341..0c36573 100755
> --- a/contrib/remote-helpers/test-hg-hg-git.sh
> +++ b/contrib/remote-helpers/test-hg-hg-git.sh
> @@ -455,8 +455,6 @@ test_expect_success 'hg author' '
>  		git_log gitrepo-$x > git-log-$x
>  	done &&
>  
> -	test_cmp git-log-hg git-log-git &&
> -
>  	test_cmp hg-log-hg hg-log-git &&
>  	test_cmp git-log-hg git-log-git
>  '
> -- 
> 1.8.3.rc1.579.g184e698



-- 
Felipe Contreras
