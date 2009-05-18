From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 2/3] parse-options: add PARSE_OPT_CUSTOM_ARGH for complicated
 argh's
Date: Mon, 18 May 2009 01:06:23 -0700
Message-ID: <4A1116FF.8030008@gmail.com>
References: <1242557224-8411-1-git-send-email-bebarino@gmail.com>	<1242557224-8411-2-git-send-email-bebarino@gmail.com>	<7vd4a7ey4h.fsf@alter.siamese.dyndns.org> <4A11096B.8020208@gmail.com> <7vmy9aetc8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 18 10:06:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5xrn-0004SS-Rq
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 10:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbZERIG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 04:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753569AbZERIG0
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 04:06:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:50239 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbZERIGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 04:06:25 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1566157rvb.1
        for <git@vger.kernel.org>; Mon, 18 May 2009 01:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=TbyvqxtJ/rugcdnulvEGwCvbft5CHMj1SdUcP+SqpoM=;
        b=dU81tDkhatDQ5X6jEe6WwYkBs5FYXm87dt1ypzm7qiV4qJpsISMFT3pQXCOLzfGKYw
         WV3IGlMaqPkpzg+C5z9x1YnHxtpmIs4ruQa/L9lm9Mey2IEANSxMbqCedf7Zwyccatdf
         CfxjuIgLeoujYpSn74DgKfURUW99i+PCBebVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=csdMcwbzVLPGLOsZApolQQx/Vip2pVoE1vC8/mmPzerMX2wLL9LjzbWKv4bxbDC7IZ
         RNLlMDpFzIGJXsQ/t5t+BDqhG6dISiqPwEdi5ynifoe8jpPKvMEALNbRjwm1wJQn8uta
         qCK4V2ExBKesxT0u4s9rXKZ21QD/eEnNM1cww=
Received: by 10.141.26.19 with SMTP id d19mr2245424rvj.84.1242633986001;
        Mon, 18 May 2009 01:06:26 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id f21sm12497564rvb.35.2009.05.18.01.06.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 May 2009 01:06:25 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <7vmy9aetc8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119425>

Junio C Hamano wrote:
> You are asking a wrong person.  I am terrible at naming things; think
> "rerere" ;-).
>
> But I think custom-arghelp is much better than multargs.  You are asking
> "use this help for argument value _literally_", so another possibility
> perhaps is PARSE_OPT_ARGHELP_LITERAL.
>
> After all, there probably are many other valid reasons why you may not
> want "s/.*/<&>/" blindly applied to your string.  One reason may be
> because the string describes multiple arguments, but I suspect that it is
> not the only one.  It is better to name the option after what it does,
> than naming it after one sample reason why you might want to use that
> option.

Ok. I think PARSE_OPT_LITERAL_ARGH might be good; until someone comes up
with a better one of course.
