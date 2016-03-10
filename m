From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] t/t7502-commit.sh : remove a repeated test
Date: Fri, 11 Mar 2016 04:56:46 +0530
Message-ID: <CAFZEwPM0y6oX5=1kBZiomVhqr2Dzbhp09m7YOT9rh0hrb2Kn9Q@mail.gmail.com>
References: <0102015362ba5bb6-8212f758-f2fa-4272-8337-1cc669e7e8f4-000000@eu-west-1.amazonses.com>
	<CAPig+cQbT3R_t=OfaueYZe2YQEdDbZWtyUFf-k=2_5S6vJuyMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 00:26:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae9ym-0006Xa-2G
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 00:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbcCJX0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 18:26:49 -0500
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34698 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbcCJX0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 18:26:47 -0500
Received: by mail-yw0-f172.google.com with SMTP id h129so81034399ywb.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 15:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=oxcFJMZ1dqVRP9pAyfZcXWgDE2yYGhihIX2h6d5pPAU=;
        b=M9sh5I23H05Pr0kmCFncW8744bVJjZZr6icFV0uwcPZPx7rex2lTCq0YpPFgK2w/NA
         CDsB9GXaGYUX0nOX5BxDyQA6F7zkw/7SfFNYC24Jgnvb07uTk87+gTQVnNYvArVrHCyc
         jcbDn4jm2XYuCAo2tFuJjKNuUTn7C00vc8pgW4N79BZgofVIBJ5F+7voX3SXty1X3AqY
         Rp4g8cAWQQ3DZjOYgPqQIFZnwS3CgL++2aQcrdtULXSuNS4kq4xBVU8uLB944sMBqt4r
         F4OtfOCckuOakc3+aNpXNNDouLmk5MQ8b542amRBK1XtjHPI5kUKtCqviyb3tRBbTfJ0
         b+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=oxcFJMZ1dqVRP9pAyfZcXWgDE2yYGhihIX2h6d5pPAU=;
        b=msZ3LYi94Ko7G6Hd1YM+TVEchovxr98H0J+pTMO1gLhMQqDd34N0EPSv1Er8lQtzJa
         GAxH7gC++8rdeRU4BJAlyx6hHTHvmPh7q9T0lZi74+s0+81UXCW/swBNgc7jz7QmBIeO
         jsUEef8oRztLIpXI8NLY4Ljb9Okm7mm2WWzIdQ3CFoPkG9l4iERhtxSR0GxWM+tnTYbO
         HXoT5l2ErGRx7stl6bunzYZQtNawHAaHd1QOipPS9uGsq2mgheBtfB6gBzH//1/WUBAr
         fYea7ReEq+nDhc95sA1RJ+wZC3TTwOR/4LBFceeb5g+sQ8WKcRlfrOcL4uPZzzFbxn/Z
         ZYcA==
X-Gm-Message-State: AD7BkJIdsTWJ3N37hPIn3/9kO9XRPpEy3LyyPh+bFR2o6vOe/VlhcJKZy+vAlx6Ufgb1ZfVXPEEX2IFQ10h4mw==
X-Received: by 10.129.45.194 with SMTP id t185mr3357539ywt.243.1457652406695;
 Thu, 10 Mar 2016 15:26:46 -0800 (PST)
Received: by 10.13.203.137 with HTTP; Thu, 10 Mar 2016 15:26:46 -0800 (PST)
In-Reply-To: <CAPig+cQbT3R_t=OfaueYZe2YQEdDbZWtyUFf-k=2_5S6vJuyMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288664>

On Fri, Mar 11, 2016 at 4:51 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> t/t7502-commit.sh : remove a repeated test
>
> Or:
>
>     t7502: drop duplicate test
>

Sure!

>> This extra test was introducted in the commit f9c01817
>
> We normally add some parenthetical context when mentioning commits:
>
>     This extra test was introduced erroneously by
>     f9c0181 (t7502: test commit.status, --status and
>     --no-status, 2010-01-13)

Seems like I have to yet get comfortable with the language used here.
I will start reading more commits and stuff.

I will resend the patch with the specified edits.
