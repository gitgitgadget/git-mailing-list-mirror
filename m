From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] diff: treat -crlf files as binary
Date: Sun, 31 Aug 2008 11:16:29 +0200
Message-ID: <81b0412b0808310216h6c349e1en740a1f4c7fef75e6@mail.gmail.com>
References: <7vfxon4ikr.fsf@gitster.siamese.dyndns.org>
	 <32541b130808291456k3de953a2yd1e93bc27ad14293@mail.gmail.com>
	 <7vljyefaps.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>, git@vger.kernel.org,
	arman@twinsun.com
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 11:17:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZj3v-0000nL-Uo
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 11:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbYHaJQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 05:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754876AbYHaJQa
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 05:16:30 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:9785 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbYHaJQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 05:16:29 -0400
Received: by wa-out-1112.google.com with SMTP id j37so978637waf.23
        for <git@vger.kernel.org>; Sun, 31 Aug 2008 02:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bo2VFJJufYyVHNkGk3N+59cMXH1TjqhRkLIH2T59hNU=;
        b=Nu/VM2Y3hlPcyG8m3Cz1fScyS0EY7xY3z8FGvroucFpfEgbp0imCi+IqvXXGFWQn5Y
         kHn/xeCtmkQVsn8U/T+ocT/pDWA9FCWbdVqrjzUoP7ZBUiG9t0XsWgKO/3E70H3+MQ17
         JITaMpKrnwsfFOw9FUk8PIVSOAncco5ggnl5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sYDi7y9hBvjTApPMv9m98RFLhi6RQr0BO5DIMJtjjOWoaFq89f8WvM9+dAcpyawSdH
         hRHLIMjHTY6fT0QoswWD+tJF2m6xMuP8z7IxYzCVCi/ScJhCwYtWBgK1nwEgtjylShOK
         EpjWMTlQr952UjwFsCJxGzNleq28Bq/JWWACY=
Received: by 10.114.175.16 with SMTP id x16mr4322784wae.155.1220174189054;
        Sun, 31 Aug 2008 02:16:29 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Sun, 31 Aug 2008 02:16:29 -0700 (PDT)
In-Reply-To: <7vljyefaps.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94465>

2008/8/30 Junio C Hamano <gitster@pobox.com>:
> diff --git i/Documentation/gitattributes.txt w/Documentation/gitattributes.txt
> index db16b0c..ec8a860 100644
> --- i/Documentation/gitattributes.txt
> +++ w/Documentation/gitattributes.txt
> @@ -105,9 +105,8 @@ Set::
>
>  Unset::
>
> -       Unsetting the `crlf` attribute on a path is meant to
> -       mark the path as a "binary" file.  The path never goes
> -       through line endings conversion upon checkin/checkout.
> +       Unsetting the `crlf` attribute on a path is tells git
> +       not to attempt any end-of-line conversion  upon checkin/checkout.

"+       Unsetting the `crlf` attribute on a path tells git"

(remove "is" before "tells")
