From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: fix unmatched code fences
Date: Tue, 12 May 2015 11:45:56 -0700
Message-ID: <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jean-Noel Avila <jn.avila@free.fr>
X-From: git-owner@vger.kernel.org Tue May 12 20:46:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsFBv-0003kc-Vg
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 20:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933842AbbELSqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 14:46:04 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36335 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933352AbbELSqC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 14:46:02 -0400
Received: by igbpi8 with SMTP id pi8so117336293igb.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 11:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9FCVGmoLdnUqLorwW9LEUG4CS/wyHfBfpzvSw57Yrx8=;
        b=RYyGxrPf74oBP3/WgfFkji+dD+OT3zLzkDPglzJ7/hyJZmC3Z5D2Ek5pGSMG47IIO3
         K/mcW8l4bz7io0sQ2KWPlpnDSZHrZKFkV5nsEXT0xK1/F5ediOh14UVXF71AeQ8bTHcE
         /CLgKKXw1ehKTYe+LseKegF62MykUSGaUHulvYjo2LArf93xsfhZ3EHSyY5JS8ZX/7kw
         QX5DkxuztfiX/71eSFry8jYxEws1Zq6Vt2h9tF+HXiNlL/IEbmCEzMCqZyF/lTbcihsh
         fkbWKH1Mxq2ysqA82RcCr3jCXeh7koCwRTdCyL8ZJoj6ljwC+fR5x5Qb5eBziuogH8t6
         GUUQ==
X-Received: by 10.42.206.9 with SMTP id fs9mr4521165icb.19.1431456358353;
        Tue, 12 May 2015 11:45:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id 71sm12452458ioe.16.2015.05.12.11.45.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 11:45:57 -0700 (PDT)
In-Reply-To: <1431451400-1447-1-git-send-email-jn.avila@free.fr> (Jean-Noel
	Avila's message of "Tue, 12 May 2015 19:23:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268870>

Jean-Noel Avila <jn.avila@free.fr> writes:

> This mismatch upsets the renderer on git-scm.com.

Thanks.

I do not think this is the first time AsciiDoc(or) rendering glitch
was reported.  GitHub folks, can you guys think of an automated way
to spot these?  Relying on site visitors to eyeball and hoping them
to report is not an ideal approach.

>
> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> ---
>  Documentation/gitcore-tutorial.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
> index 8475c07..36e9ab3 100644
> --- a/Documentation/gitcore-tutorial.txt
> +++ b/Documentation/gitcore-tutorial.txt
> @@ -259,7 +259,7 @@ index 557db03..263414f 100644
>  @@ -1 +1,2 @@
>   Hello World
>  +It's a new day for git
> -----
> +------------
>  
>  i.e. the diff of the change we caused by adding another line to `hello`.
