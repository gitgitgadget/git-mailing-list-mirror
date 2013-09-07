From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: Do not require tags to be annotated
Date: Sat, 7 Sep 2013 14:28:09 +0200
Message-ID: <CAHGBnuP6w8rvoz+h2Xase1ApY_kpZh4X=VF6LY4O0r7RS0UayA@mail.gmail.com>
References: <522A36AA.3050701@gmail.com>
	<xmqqeh91wrvq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 14:28:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIHcd-0002j9-8Y
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 14:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059Ab3IGM2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 08:28:11 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:46651 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab3IGM2K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 08:28:10 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so3688933lbj.13
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 05:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zIW2g2pUek4FnjEu3pqP3KuXY25aTBgRIvGoPaolJ8E=;
        b=V3XNRqJpvcAmF0WYwN91f+exHC3fCWoBa0Zqc+ASCai+dBS71t3FxFHZT28JmK8XOi
         Yc5ghGIuhY9edeQjS9G6zqcvYTVN4E13gFglzkC0QmPhQZ17d18AqQWo1h8YDgjDV3v1
         x54La4Y9tV5NsPrHGzdySei2rKw9lZL8cP/STcv+StaU0ghP4FCQQBV22WWFmXFeh962
         3a5ys/2HEhfNeiBTZLCbzSzmjADsGShFGE3nnaIp5f36Yp3yeIB6/MUWH0uvdmurNSDS
         stBGco/dtzFU6jWc7icfIfLdKQsTvykfpsck4Rsiy06VU6XwZRiMs/9ZAdPntAB5oi5D
         4IKA==
X-Received: by 10.152.170.166 with SMTP id an6mr6857840lac.20.1378556889210;
 Sat, 07 Sep 2013 05:28:09 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Sat, 7 Sep 2013 05:28:09 -0700 (PDT)
In-Reply-To: <xmqqeh91wrvq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234133>

On Fri, Sep 6, 2013 at 11:40 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> For custom builds of Git it sometimes is inconvenient to annotate tags
>> because there simply is nothing to say, so do not require an annotation.
>>
>> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
>> ---
>
> Hmmmm, personally I'd actually want this to stay the way it is, or
> even require a valid signed tag, in order to make sure I won't
> mistakenly creating a lightweight tag.
>
> If you want to give build a custom name,
>
>     echo buildname >version
>
> should be sufficient, no?

That's not sufficient if you care about a proper (automated) release
workflow with your releases tagged.

> I dunno.

That's fine, I do not care too deeply about this. I just wanted to
give this patch a try and see what others think. Feel free to drop it.

-- 
Sebastian Schuberth
