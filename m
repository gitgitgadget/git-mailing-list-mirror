From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3 11/11] t6050-replace: use some long option names
Date: Sat, 31 Aug 2013 23:19:53 +0100
Organization: OPDS
Message-ID: <B7EE9969D317426D9897AE75E7A84462@PhilipOakley>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org> <20130831191215.26699.76207.chriscool@tuxfamily.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Thomas Rast" <trast@inf.ethz.ch>,
	"Johannes Sixt" <j6t@kdbg.org>
To: "Christian Couder" <chriscool@tuxfamily.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 01 00:19:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFtVa-0006xe-6A
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 00:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937Ab3HaWTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 18:19:01 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:59673 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753181Ab3HaWTA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 18:19:00 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvgLAGlrIlJOl3GZ/2dsb2JhbABagwc1iTa3fQQEAYEdF3SCHwUBAQQBCAEBLh4BASEFBgIDBQIBAw4HAgolFAEEGgYHDwgGARIIAgECAwGHawq5bY9/gySBAAOIfYYSmkyBOoFnOw
X-IPAS-Result: AvgLAGlrIlJOl3GZ/2dsb2JhbABagwc1iTa3fQQEAYEdF3SCHwUBAQQBCAEBLh4BASEFBgIDBQIBAw4HAgolFAEEGgYHDwgGARIIAgECAwGHawq5bY9/gySBAAOIfYYSmkyBOoFnOw
X-IronPort-AV: E=Sophos;i="4.89,999,1367967600"; 
   d="scan'208";a="430503261"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip05ir2.opaltelecom.net with SMTP; 31 Aug 2013 23:18:58 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233553>

From: "Christian Couder" <chriscool@tuxfamily.org>
Subject: [PATCH v3 11/11] t6050-replace: use some long option names


> So that they are tested a litlle bit too.
s /litlle/little/

>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> t/t6050-replace.sh | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index 0b07a0b..5dc26e8 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -122,9 +122,9 @@ test_expect_success '"git replace" listing and 
> deleting' '
>      test "$HASH2" = "$(git replace -l)" &&
>      test "$HASH2" = "$(git replace)" &&
>      aa=${HASH2%??????????????????????????????????????} &&
> -     test "$HASH2" = "$(git replace -l "$aa*")" &&
> +     test "$HASH2" = "$(git replace --list "$aa*")" &&
>      test_must_fail git replace -d $R &&
> -     test_must_fail git replace -d &&
> +     test_must_fail git replace --delete &&
>      test_must_fail git replace -l -d $HASH2 &&
>      git replace -d $HASH2 &&
>      git show $HASH2 | grep "A U Thor" &&
> @@ -147,7 +147,7 @@ test_expect_success '"git replace" resolves sha1' 
> '
>      git show $HASH2 | grep "O Thor" &&
>      test_must_fail git replace $HASH2 $R &&
>      git replace -f $HASH2 $R &&
> -     test_must_fail git replace -f &&
> +     test_must_fail git replace --force &&
>      test "$HASH2" = "$(git replace)"
> '
>
> @@ -278,7 +278,7 @@ test_expect_success 'replaced and replacement 
> objects must be of the same type'
>
> test_expect_success '-f option bypasses the type check' '
>  git replace -f mytag $HASH1 2>err &&
> - git replace -f HEAD^{tree} HEAD~1 2>err &&
> + git replace --force HEAD^{tree} HEAD~1 2>err &&
>  git replace -f HEAD^ $BLOB 2>err
> '
>
> -- 
> 1.8.4.rc1.31.g530f5ce.dirty
>
> 
