Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 17322 invoked by uid 107); 21 Feb 2010 23:04:51 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 21 Feb 2010 18:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab0BUXEb (ORCPT <rfc822;peff@peff.net>);
	Sun, 21 Feb 2010 18:04:31 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42701 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab0BUXEa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Feb 2010 18:04:30 -0500
Received: by pwj8 with SMTP id 8so2022785pwj.19
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 15:04:29 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A/dv0EzSF+Mtfy6EfwYJHvfpPq55SAScRo5H09WIbPY=;
        b=VdU6ocQ/mIHODtfxI0Rr5gpf1nDSASb0QDQ7z/DMRBK1xGTdhAFcTQy6tJAIkVfetn
         JjVxJHhsyofT7p3G2CaR+nbZSdPxRTJWJLtJ/YRg6vVqSIzmpEKIAc0A92syOIscjevg
         wLRbMab5rP33ywc6C2jMqDu4hGNRr13reQ1mI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sW3XgNScoK6tZzMqviyDWWZ8Ks9luAGy9T7huYDHaLLgzBgcASygbzRvkfXb/515ch
         PNdlW6BVcccjpvF/+uxOOJ7s99qcMGehAv+Ca6BbgZwL4J3d/k2DLiEg8++/UCSIgPUW
         gwtDe3dtoKTdn5Q6COCMDeM6Id3pTkJgh0p6g=
MIME-Version: 1.0
Received: by 10.114.5.34 with SMTP id 34mr8825354wae.108.1266793469728; Sun, 
	21 Feb 2010 15:04:29 -0800 (PST)
In-Reply-To: <32541b131002191905u59a90866he0a38dfc661d45d2@mail.gmail.com>
References: <2cfc40321002171835j107d2cdcr5f7667d769bf391e@mail.gmail.com>
	 <20100218051129.GD10970@coredump.intra.peff.net>
	 <2cfc40321002181704i73eb87demd03faaddf9bb108@mail.gmail.com>
	 <32541b131002181913t24989addr84b612787a2f8c48@mail.gmail.com>
	 <2cfc40321002182329q7b8c5b90nbd77a4e0678cd9c8@mail.gmail.com>
	 <32541b131002191220q5a0eae6dk304173418f818ff3@mail.gmail.com>
	 <2cfc40321002191825i605e5045w6f52f9f044a5d369@mail.gmail.com>
	 <32541b131002191905u59a90866he0a38dfc661d45d2@mail.gmail.com>
Date:	Mon, 22 Feb 2010 10:04:29 +1100
Message-ID: <2cfc40321002211504o28069d16h4b9d1ef2230d03fe@mail.gmail.com>
Subject: Re: RFD: best way to automatically rewrite a git DAG as a linear 
	history?
From:	Jon Seymour <jon.seymour@gmail.com>
To:	Avery Pennarun <apenwarr@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Feb 20, 2010 at 2:05 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On Fri, Feb 19, 2010 at 9:25 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
>> (A hammer is, of course, a reasonably good tool for making things flat
>> although it does tend to break things along the way).
>
> Nice analogy.  Well, thanks for the clarification and best of luck in
> your slightly crazy project :)
>

Thank you - FWIW, it is shaping up very well. In turns out that in
cases where the original merge was resolved in favour of the conflict,
the compensation can be squashed with the compensated commit -
effectively bring the eventual resolution forward in time.

This is so, so cool.

jon.
