From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH 3/3] mergetool--lib: Add the proper executable name for
 ECMerge
Date: Sun, 27 Feb 2011 18:50:32 +1300
Message-ID: <4D69E628.5040007@gmail.com>
References: <4D68DAC4.9060100@gmail.com> <4D68DBB0.2020909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, charles@hashpling.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 06:49:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtZVY-0002s1-UT
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 06:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935Ab1B0FtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 00:49:24 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55786 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab1B0FtX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 00:49:23 -0500
Received: by pzk35 with SMTP id 35so462251pzk.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 21:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Sa7TI+EXKE7yq+577rbqIyLuCuvIpjH+NEoj29zxgok=;
        b=EvSORI0xI7BqZwTMZyxV0Ldg/S1S0+QbC3auik/z6ZGsA++TEtEvQp7LrryOrxoLOi
         434rUt6JthY13wGDvRsiQO0BzZitrd3hodEkXUkV28lIyI4Cbhgto4Mq3pGsAvn74Nll
         X3ZpCguZHpmTnan1OmQWDRLmypz6zs+xz4PgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=suNb7f9+ysPmz/6uszP0femLFmCk+1LRAJ2tDSaxOuuMp1gG9QggQpUvdOac2pZkjT
         O5taEwA6lCLPjxif+BcDWHF4Uz1cmU8gRk40LJOZGhpliXjwKsYM+dSUDXTvfNhmjOs9
         t71PFmdKI37TzJxEAEmtsJ46+zK2AAZE/bmNw=
Received: by 10.143.10.20 with SMTP id n20mr3148626wfi.350.1298785763442;
        Sat, 26 Feb 2011 21:49:23 -0800 (PST)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz [115.188.15.163])
        by mx.google.com with ESMTPS id w19sm3772759wfd.8.2011.02.26.21.49.20
        (version=SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 21:49:21 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
In-Reply-To: <4D68DBB0.2020909@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168009>

On 26/02/11 23:53, Sebastian Schuberth wrote:
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  git-mergetool--lib.sh |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 3ac6231..95da00b 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -16,6 +16,9 @@ translate_merge_tool_path () {
>  	bc3)
>  		echo BCompare
>  		;;
> +	ecmerge)
> +		echo guimerge
> +		;;
>  	emerge)
>  		echo emacs
>  		;;

I think this is another case of linux/windows versions of the
application having different executable names.

chrisp@laptop:~> tar -tf Download/ecmerge-2.3.123.linux.x86.tbz
/usr/local/bin/ecmerge
/opt/elliecomputing/ecmerge/guimerge
/opt/elliecomputing/ecmerge/guimerge.exe
