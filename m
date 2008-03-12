From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v5 2/5] git-submodule summary: show commit summary
Date: Wed, 12 Mar 2008 10:08:10 +0800
Message-ID: <46dff0320803111908m3f370ebbj89ee0511bb086cb0@mail.gmail.com>
References: <1205243539-797-1-git-send-email-pkufranky@gmail.com>
	 <1205243539-797-2-git-send-email-pkufranky@gmail.com>
	 <1205243539-797-3-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Ping Yin" <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 12 03:09:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZGPY-0000AL-K3
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 03:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbYCLCIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 22:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbYCLCIg
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 22:08:36 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:58163 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbYCLCIX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 22:08:23 -0400
Received: by an-out-0708.google.com with SMTP id d31so646712and.103
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 19:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OmDhD7SIadjLZG6qTBjzCwO3K+v8NXM/VfXgeyt503A=;
        b=k0KUrrbVHoOCDPmY6fJ8Xdbcxzn7/UKHe6MjSNCf3GnteacfYSstECqff3GivEYRMya5BKYl1xcEfJyM4DBXxYU9R/5uiB65VeZzW35svTYBQC7sI2QaW1ApfQrxLjqSK4eyWuTJMJxQ3RvUia2sGAkKwb9pe1FveS+RN8FsDTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LYagf4pOFvOu5jbfX4hSFcRfbju8i5e4iKdnU/ZEDRTN/rjMW/HauCdj5yJdV8ngvFGmDfCRmwIfrof+UA1VNkAHjUugcZ3Mh/I3Mt1uCF6rNjPQGiB+/lyRE1P6DUfQNtcCsFQ+Y2M9S/SZoMFMZXnvqe3NC760Tmlu6dUAQls=
Received: by 10.100.152.19 with SMTP id z19mr14916546and.0.1205287690508;
        Tue, 11 Mar 2008 19:08:10 -0700 (PDT)
Received: by 10.100.5.18 with HTTP; Tue, 11 Mar 2008 19:08:10 -0700 (PDT)
In-Reply-To: <1205243539-797-3-git-send-email-pkufranky@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76905>

On Tue, Mar 11, 2008 at 9:52 PM, Ping Yin <pkufranky@gmail.com> wrote:
> This patch does the hard work to show submodule commit summary.
>

> +                       case "$mod_dst" in
>  +                               160000)
>  +                               sha1_dst=$(GIT_DIR="$name/.git" git rev-parse HEAD)
>  +                               ;;
>  +                               100644)
>  +                               sha1_dst=$(git hash-object $name)
>  +                               ;;
>  +                       esac

please s/100644/100*/



-- 
Ping Yin
