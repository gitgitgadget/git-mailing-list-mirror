From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: What's in git.git (Aug 2009, #01; Wed, 05)
Date: Fri, 7 Aug 2009 01:28:18 +0200
Message-ID: <20090806232818.GD12924@vidovic>
References: <7vd479x6hx.fsf@alter.siamese.dyndns.org> <MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil> <20090806231759.GC12924@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Aug 07 01:28:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZCNr-0006ao-3b
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 01:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756890AbZHFX2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 19:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756877AbZHFX2W
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 19:28:22 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:46846 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017AbZHFX2V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 19:28:21 -0400
Received: by ey-out-2122.google.com with SMTP id 9so436379eyd.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 16:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=qE0PKUs1ojsF94l0gw2JJDg1S/o/mWq91TU5ARfUSOg=;
        b=ksOcIVtQzAFAjxX66cXT9ZU1O1J52/mQPDEBH3bfh1OdL8xDqp3znwK/HCjIZ6bWOM
         znfs4WFXpnknBpJQDsWvGw7uB8SChpY+bsreZlBW++bw/s6tGyhF2aBTWmJD/MwTFDjR
         PzGpIr5l/xd4/p6boHrPdVxA0XZNs9qaSpL2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=e0awDRkdqiqKv3n0gyx1IfhPhSYihoL8/Jg3IIuyn9ZOvr16KKHmdTaFJrwPNVYj/V
         Ofj9C4kisFlbDoI2rfmeWRogy+Utfr0LrkgG2zctiSg/caVpdgSZLxSqZlZM3ftuCade
         A7cFFeX59I2kTdRk0drO6vacHlvHrXcuxNPBY=
Received: by 10.210.129.6 with SMTP id b6mr103903ebd.70.1249601301477;
        Thu, 06 Aug 2009 16:28:21 -0700 (PDT)
Received: from @ (91-164-149-117.rev.libertysurf.net [91.164.149.117])
        by mx.google.com with ESMTPS id 10sm1228140eyd.7.2009.08.06.16.28.20
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 16:28:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090806231759.GC12924@vidovic>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125140>

The 07/08/09, Nicolas Sebrecht wrote:
> 
> This is even better that all my crap. But I think we should squash
> this:
> 
> ---
>  git-am.sh |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/git-am.sh b/git-am.sh
> index 94fa9c9..e8ec8d7 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -254,9 +254,6 @@ split_patches () {
>                 this=
>                 msgnum=
>                 ;;
> -       *)
> -               clean_abort "Patch format $patch_format is not supported."
> -               ;;
>         esac
>  }

Which is wrong as it could be given at the command line. Sorry for the
noise.

-- 
Nicolas Sebrecht
