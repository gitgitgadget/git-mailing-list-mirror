From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Update t3508 status
Date: Tue, 29 Jun 2010 19:04:33 +0200
Message-ID: <201006291904.34009.chriscool@tuxfamily.org>
References: <1277775091-13313-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 29 19:04:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTeEu-0004m4-G1
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 19:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223Ab0F2REn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 13:04:43 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:36198 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932206Ab0F2REn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 13:04:43 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8A879818085;
	Tue, 29 Jun 2010 19:04:35 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-22-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <1277775091-13313-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149921>

On Tuesday 29 June 2010 03:31:31 newren@gmail.com wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Test #8 of t3508-cherry-pick-many-commits.sh has been fixed since
> 3af0bba8bff88ec1b078aae966a59af26c7a0718.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t3508-cherry-pick-many-commits.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/t/t3508-cherry-pick-many-commits.sh
> b/t/t3508-cherry-pick-many-commits.sh index 93d7189..f90ed3d 100755
> --- a/t/t3508-cherry-pick-many-commits.sh
> +++ b/t/t3508-cherry-pick-many-commits.sh
> @@ -82,7 +82,7 @@ test_expect_success 'revert fourth fourth~1 fourth~2
> works' ' git diff --quiet HEAD first
>  '
> 
> -test_expect_failure 'cherry-pick -3 fourth works' '
> +test_expect_success 'cherry-pick -3 fourth works' '
>  	git checkout -f master &&
>  	git reset --hard first &&
>  	test_tick &&

I tried to put this hunk in the following patch:

http://thread.gmane.org/gmane.comp.version-control.git/149156/

but Junio said in a private mail that the test did not pass for him so he 
dropped this hunk.

By the way it looks like the third patch in the series has been lost:

http://thread.gmane.org/gmane.comp.version-control.git/149157

Thanks,
Christian.
