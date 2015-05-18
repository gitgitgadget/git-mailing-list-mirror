From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 4/8] t5520: test work tree fast-forward when fetch
 updates head
Date: Mon, 18 May 2015 17:22:29 +0200
Organization: gmx
Message-ID: <621e954c6904ca5af59cbe4158035788@www.dscho.org>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
 <1431955978-17890-5-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 17:22:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMsQ-0003kx-Ef
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026AbbERPWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:22:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:55651 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754022AbbERPWg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:22:36 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MJBRC-1Yrcmi0tPW-002oR4; Mon, 18 May 2015 17:22:30
 +0200
In-Reply-To: <1431955978-17890-5-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:JtqBLQUGj420GSvURCp/SL1YLwADokyMwT0KMZ2/vpxcNmSuv2q
 T09EVJRubw5r1PaDjUUuWDjfBIBBKZVXx+lZIxA40hqIslK05ecVe+7/KhajtHF+dGJfBUr
 RokzlOGw8qm1RDlXIOY4DtCVCHOJUCFBMDs86a37maPEfo3/bGJUYzL9J8ouy3VBUzZDBNN
 4KRbg2e2ax8+7b3qr5qGQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269278>

Hi Paul,

On 2015-05-18 15:32, Paul Tan wrote:

> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 3bc0594..3a53a5e 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -184,6 +184,27 @@ test_expect_success 'fail if the index has
> unresolved entries' '
>  	test_cmp expected file
>  '
>  
> +test_expect_success 'fast-forwards working tree if branch head is updated' '
> +	git checkout -b third second^ &&
> +	test_when_finished "git checkout -f copy && git branch -D third" &&

If you follow my argument in 2/8, this line, and...

> [...]
> +test_expect_success 'fast-forward fails with conflicting work tree' '
> +	git checkout -b third second^ &&
> +	test_when_finished "git checkout -f copy && git branch -D third" &&

... this line should be dropped, too.

This comment concludes my review of v4 of this patch series. Well done!

Ciao,
Dscho
