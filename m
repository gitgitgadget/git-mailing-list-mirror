From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] test: fix post rewrite hook report
Date: Thu, 30 May 2013 16:35:29 +0200
Message-ID: <87d2s8fscu.fsf@linux-k42r.v.cablecom.net>
References: <1369921595-30514-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 16:35:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui3x2-0002Qa-8q
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 16:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600Ab3E3Ofd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 10:35:33 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:49276 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932445Ab3E3Ofc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 10:35:32 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 30 May
 2013 16:35:29 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 30 May 2013 16:35:29 +0200
In-Reply-To: <1369921595-30514-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 30 May 2013 08:46:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226003>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> First expected, then actual.

Ack.  That is the prevalent (almost universal, but not quite) style.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t5407-post-rewrite-hook.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
> index baa670c..ea2e0d4 100755
> --- a/t/t5407-post-rewrite-hook.sh
> +++ b/t/t5407-post-rewrite-hook.sh
> @@ -31,8 +31,8 @@ clear_hook_input () {
>  }
>  
>  verify_hook_input () {
> -	test_cmp "$TRASH_DIRECTORY"/post-rewrite.args expected.args &&
> -	test_cmp "$TRASH_DIRECTORY"/post-rewrite.data expected.data
> +	test_cmp expected.args "$TRASH_DIRECTORY"/post-rewrite.args &&
> +	test_cmp expected.data "$TRASH_DIRECTORY"/post-rewrite.data
>  }
>  
>  test_expect_success 'git commit --amend' '

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
