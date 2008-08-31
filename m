From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] diff: treat -crlf files as binary
Date: Sat, 30 Aug 2008 22:34:01 -0400
Message-ID: <32541b130808301934t6034d52bva0f8c3608a88e585@mail.gmail.com>
References: <7vfxon4ikr.fsf@gitster.siamese.dyndns.org>
	 <32541b130808291456k3de953a2yd1e93bc27ad14293@mail.gmail.com>
	 <7vljyefaps.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, arman@twinsun.com
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 04:35:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZcmz-0001mg-3J
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 04:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953AbYHaCeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 22:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754863AbYHaCeF
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 22:34:05 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:33553 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbYHaCeD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 22:34:03 -0400
Received: by yx-out-2324.google.com with SMTP id 8so803196yxm.1
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 19:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=t2LTUgAiz/TsXdbV5eeSPsdXNP8RwkzzcYKLrQ1xxhM=;
        b=Pine+qygnIK32SiEeYnf+OiZPflsL16DBy7XA6zoFyFUk4v6gdhpcnJBhCUdE+SvAG
         yUYjALrUaMfDpVGfXNcTVuu2fJaMiUrueDgJOTDP6aDqv2FHSHQyxzz19Q+Ht+5Aaey9
         UWbDPHMKaUnwZpn6XQQPkkgZbJdhIYwl+QFZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fqu6b4XygrIccPRRCaDwquHuMptKVNOSNEWycmhI1M88ice6jiuwbtV29b4owdrn5r
         yYnJS2aIVLA1kgQpilmpvy7fFdDZNG76tCMUjJ1K1VRH8AGqZXaI5Uv7TwvK4zigYen9
         vOgmtsPpLhuGd6C2mLTqQ1tOw9xudr0KgQjU4=
Received: by 10.151.46.17 with SMTP id y17mr6611590ybj.120.1220150041750;
        Sat, 30 Aug 2008 19:34:01 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Sat, 30 Aug 2008 19:34:01 -0700 (PDT)
In-Reply-To: <7vljyefaps.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94448>

On Sat, Aug 30, 2008 at 5:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  Unset::
>
> -       Unsetting the `crlf` attribute on a path is meant to
> -       mark the path as a "binary" file.  The path never goes
> -       through line endings conversion upon checkin/checkout.
> +       Unsetting the `crlf` attribute on a path is tells git
> +       not to attempt any end-of-line conversion  upon checkin/checkout.
[...]

Well, _I_ understand it :)

Avery
