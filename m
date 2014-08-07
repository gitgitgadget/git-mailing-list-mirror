From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] various contrib: Fix links in man pages
Date: Thu, 07 Aug 2014 09:42:24 -0700
Message-ID: <xmqqiom4l09b.fsf@gitster.dls.corp.google.com>
References: <1407421632-12490-1-git-send-email-stefanbeller@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 18:42:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQm3-0000sB-Og
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 18:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746AbaHGQmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 12:42:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61278 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932500AbaHGQmd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 12:42:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 26E842ED6E;
	Thu,  7 Aug 2014 12:42:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Q3qLiqb039E16oNMQ0Zl3xPBnE=; b=Fzd6Hb
	pGyGnVrw0ommIKWt3ohqr+Cw77Pn1CFONDGszIIIWUiT1bRpjJwDQzQk1saWKxmM
	BnmLsL0GU10tEJJ3N+xtTgLB4FdkD/bGctn0X7k+1XWhqd/gAX1bFfptfktr+YVf
	AzMpGyTllAnsKlNnp2JoSiHuOu1awgaDssVE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YOlY3uTPbRODzuBRyr5zmlcR88t6gbqK
	YwuWxLYXzzlEupFRWm7Oo9sAPHRKMW6I0PNAipKa+kNjLdr4ztE7Un+0PScAJRKc
	botAPBN3Tmm2cHiThKCslzR4KzbZwwSW7lXd9ThdvGVAwOT24fq5PIYjlnbIyzUT
	ddTq5p1iu80=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E9602ED6C;
	Thu,  7 Aug 2014 12:42:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 648802ED61;
	Thu,  7 Aug 2014 12:42:26 -0400 (EDT)
In-Reply-To: <1407421632-12490-1-git-send-email-stefanbeller@gmail.com>
	(Stefan Beller's message of "Thu, 7 Aug 2014 16:27:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D053438E-1E51-11E4-BA54-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254978>

Stefan Beller <stefanbeller@gmail.com> writes:

> Inspired by 2147fa7e (2014-07-31 git-push: fix link in man page),
> I grepped through the whole tree searching for 'gitlink:' occurrences.
>
> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
> ---

Thanks; I did the same earlier but only for Documentation/ which was
not very useful X-<.



>  contrib/convert-objects/git-convert-objects.txt | 2 +-
>  contrib/examples/git-svnimport.txt              | 2 +-
>  contrib/gitview/gitview.txt                     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/convert-objects/git-convert-objects.txt b/contrib/convert-objects/git-convert-objects.txt
> index 0565d83..f871880 100644
> --- a/contrib/convert-objects/git-convert-objects.txt
> +++ b/contrib/convert-objects/git-convert-objects.txt
> @@ -26,4 +26,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
>  
>  GIT
>  ---
> -Part of the gitlink:git[7] suite
> +Part of the linkgit:git[7] suite
> diff --git a/contrib/examples/git-svnimport.txt b/contrib/examples/git-svnimport.txt
> index 3bb871e..3f0a9c3 100644
> --- a/contrib/examples/git-svnimport.txt
> +++ b/contrib/examples/git-svnimport.txt
> @@ -176,4 +176,4 @@ Documentation by Matthias Urlichs <smurf@smurf.noris.de>.
>  
>  GIT
>  ---
> -Part of the gitlink:git[7] suite
> +Part of the linkgit:git[7] suite
> diff --git a/contrib/gitview/gitview.txt b/contrib/gitview/gitview.txt
> index 9e12f97..7b5f900 100644
> --- a/contrib/gitview/gitview.txt
> +++ b/contrib/gitview/gitview.txt
> @@ -28,7 +28,7 @@ OPTIONS
>  
>  <args>::
>  
> -	All the valid option for gitlink:git-rev-list[1].
> +	All the valid option for linkgit:git-rev-list[1].
>  
>  Key Bindings
>  ------------
