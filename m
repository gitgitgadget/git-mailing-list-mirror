From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Let --decorate show HEAD position
Date: Mon, 12 Oct 2009 22:06:21 +0200
Message-ID: <200910122206.23044.trast@student.ethz.ch>
References: <4c70c935ab67266684aa14e38e276795cf1776db.1255337211.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-15?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 22:08:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxRC8-0005A5-JE
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 22:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758052AbZJLUIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 16:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758046AbZJLUIJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 16:08:09 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:9927 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756772AbZJLUII (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 16:08:08 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 12 Oct
 2009 22:07:22 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 12 Oct
 2009 22:07:01 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <4c70c935ab67266684aa14e38e276795cf1776db.1255337211.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130059>

Thomas Rast wrote:
> diff --git a/log-tree.c b/log-tree.c
> index 1618f3c..f7d54f2 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -43,6 +43,7 @@ void load_ref_decorations(int flags)
>  	if (!loaded) {
>  		loaded = 1;
>  		for_each_ref(add_ref_decoration, &flags);
> +		head_ref(add_ref_decoration, &flags);
>  	}
>  }

Damn, this fails tests and I only just noticed while testing another
series.  Sorry for the noise, reroll upcoming...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
