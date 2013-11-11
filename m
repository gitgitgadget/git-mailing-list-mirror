From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH 6/7] test-hg.sh: help user correlate verbose output with
 email test
Date: Mon, 11 Nov 2013 05:42:59 -0600
Message-ID: <5280c2c3e066c_6841541e7824@nysa.notmuch>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
 <1384142712-2936-7-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 12:50:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfq0R-0003wu-Vp
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 12:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079Ab3KKLuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 06:50:08 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:37084 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab3KKLuH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 06:50:07 -0500
Received: by mail-ob0-f175.google.com with SMTP id va2so4164675obc.20
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 03:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=z4FeAvKtJ2EgHnfY6C7l5rWw9qKSr+aPp18nRHDHzYo=;
        b=zW2UtmbQjAzyq6LX/rbonUTlo/w2yjLuIvUppg0XetHr0Vw9vmtDzg6QRk3jYle3hX
         GZ3aNOJnfLEt1sodJsiTI5DB6t226/T7kb1V/3T814tS+CiRfkonXNOYmZSRB5yYij3s
         oRZWWng/fIWc9cOJLL0S0yGuw/5/+ztj5EWsjYfvMdlVe4h8i0MSVZV8dYpBq7ZQys1A
         VArE5O3uTW6OyO6ZjwZsnWcG8uKIB78Rv2hcCwD/jaZ/GZG/NuAa195IQx8FDuYhNiYD
         b1MAfJfzy9uHcoutct5xUZB5KkhoctPN3oN3L/Am+lMVHLmZlAGlq7fHtaxx6SCUEUb1
         MKSA==
X-Received: by 10.182.38.228 with SMTP id j4mr576623obk.94.1384170606653;
        Mon, 11 Nov 2013 03:50:06 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm27065260oeb.7.2013.11.11.03.50.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 03:50:05 -0800 (PST)
In-Reply-To: <1384142712-2936-7-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237612>

Richard Hansen wrote:
> It's hard to tell which author conversion test failed when the email
> addresses look similar.
> 
> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---
>  contrib/remote-helpers/test-hg.sh | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
> index 84c67ff..5eda265 100755
> --- a/contrib/remote-helpers/test-hg.sh
> +++ b/contrib/remote-helpers/test-hg.sh
> @@ -209,16 +209,16 @@ test_expect_success 'authors' '
>  
>  	>../expected &&
>  	author_test alpha "" "H G Wells <wells@example.com>" &&
> -	author_test beta "test" "test <unknown>" &&
> -	author_test beta "test <test@example.com> (comment)" "test <test@example.com>" &&
> -	author_test gamma "<test@example.com>" "Unknown <test@example.com>" &&
> -	author_test delta "name<test@example.com>" "name <test@example.com>" &&
> -	author_test epsilon "name <test@example.com" "name <test@example.com>" &&
> -	author_test zeta " test " "test <unknown>" &&
> -	author_test eta "test < test@example.com >" "test <test@example.com>" &&
> -	author_test theta "test >test@example.com>" "test <test@example.com>" &&
> -	author_test iota "test < test <at> example <dot> com>" "test <unknown>" &&
> -	author_test kappa "test@example.com" "Unknown <test@example.com>"
> +	author_test beta "beta" "beta <unknown>" &&
> +	author_test beta "beta <test@example.com> (comment)" "beta <test@example.com>" &&

Two betas?

> +	author_test gamma "<gamma@example.com>" "Unknown <gamma@example.com>" &&
> +	author_test delta "delta<test@example.com>" "delta <test@example.com>" &&
> +	author_test epsilon "epsilon <test@example.com" "epsilon <test@example.com>" &&
> +	author_test zeta " zeta " "zeta <unknown>" &&
> +	author_test eta "eta < test@example.com >" "eta <test@example.com>" &&
> +	author_test theta "theta >test@example.com>" "theta <test@example.com>" &&
> +	author_test iota "iota < test <at> example <dot> com>" "iota <unknown>" &&
> +	author_test kappa "kappa@example.com" "Unknown <kappa@example.com>"
>  	) &&
>  
>  	git clone "hg::hgrepo" gitrepo &&

-- 
Felipe Contreras
