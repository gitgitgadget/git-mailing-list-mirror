From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] commit: add a commit.verbose config variable
Date: Mon, 14 Mar 2016 17:31:35 -0400
Message-ID: <CAPig+cSEPBKR+Hd-8hqppNMrBOFa1GKs70cK7hzkbaNApgg8Lw@mail.gmail.com>
References: <01020153698edabd-73daa5db-3c3e-417b-8d83-6cbc04439d95-000000@eu-west-1.amazonses.com>
	<CAPig+cQ+8+saxsGzV=-C2w-eSaaOf0MYC=zTQbH3CW2G5UE5uw@mail.gmail.com>
	<CAFZEwPP_SZsk+B+1L93snQji=wg728P3Oq94oVJ+ZJkhmdC9Yw@mail.gmail.com>
	<CAPig+cTt+Mi=gOREG2zU7vbtB6qk7dVS3mWeMBY37ZwFp_oZng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 22:31:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afa5U-0007KB-VO
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 22:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbcCNVbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 17:31:37 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33216 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbcCNVbg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 17:31:36 -0400
Received: by mail-vk0-f66.google.com with SMTP id c3so15856238vkb.0
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 14:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=OQrwePaulIvItJIRpUoLeRGsUTpclkMY6+b7xeoMGEk=;
        b=h3+Uez8tohMM+uSlSBvqG0q64XxJmkVBF80cVM8vkat5yQVVL4TiMCY9PaAHiNwPza
         knamghL3AFqJ/NKhUSa4Idq4lG5rv4hXpDG2sNF6mCINWEqeCMqSoI2VFa2LCAw+jK1J
         xJwuRbEj4mMUzFKlxj5Ny7az5De5OKpvS7kMOSScI2CVtdQMgaMY0xd1MyVJcdzE4Z4J
         Ek4TuGbztavnqJKz+xzmAYhJl/nZ+PjW39RFNFnJSbCtP9qabMmEF6YYEyDSRllk+b3B
         KR+Hcjv0y14RYXsmxRO8GBtx209jibflQrtGtupH+7u1nCNkFEb9Ze/jPQJGscAD3lMl
         9ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=OQrwePaulIvItJIRpUoLeRGsUTpclkMY6+b7xeoMGEk=;
        b=OCQs+qR+ixjRhD7xOZT9kPcs7saZ2DwOCBumGepSH7pTTzYFolte+EBJGOYXtpLuvQ
         1xtqWMMJlklaqxwGhI+v5dz1puSZZHPoygg3fooy3svbm4Mta/9FPXFk6HDjayT1gn8z
         GcXDOinBglSn8ulrdXVKW+OeBnL7sjO0VAuBRbCiaZyRYvokRa+DfI0qqYqmVj9NouFF
         TqTTXicg0v1lRlsAByJhAF9T3t5eDg8umipPR+GTqHhDR2ANNs1EmHyM5O0C/ikh5E29
         MnRWs86Oon89908tHewf3ob7JDixIbrI+sGHUoVlwDMnsef4EzYknc6SDHCdwAWD3C8e
         ocew==
X-Gm-Message-State: AD7BkJKt4Fp4w1LgZ93K8OzMvfeKxKCohTWmFMBAuqTGDHHe2jZfEL1KbeUHbC1rL8g5ExbjOdwqlst5Pm7pFg==
X-Received: by 10.31.21.4 with SMTP id 4mr27275735vkv.151.1457991095374; Mon,
 14 Mar 2016 14:31:35 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Mon, 14 Mar 2016 14:31:35 -0700 (PDT)
In-Reply-To: <CAPig+cTt+Mi=gOREG2zU7vbtB6qk7dVS3mWeMBY37ZwFp_oZng@mail.gmail.com>
X-Google-Sender-Auth: T53JFQmCNBN0MRieCz5E55sUiu4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288817>

On Mon, Mar 14, 2016 at 5:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> By the way, the just-submitted v6 seems to be lacking these new tests
> (though, as I said, they are not by any means mandatory).

Ignore me. They are present in v6, yet I somehow overlooked them.
