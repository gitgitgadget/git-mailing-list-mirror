From: Luke Diamand <luke@diamand.org>
Subject: Re: Looking for a solution
Date: Tue, 05 May 2015 20:58:57 +0100
Message-ID: <55492101.80807@diamand.org>
References: <CAFX4i8EyQ=0EV=XMCQ42GfYzjbAXc5ELSCFqEejS5ObYioqBEg@mail.gmail.com> <CAGZ79ka=jabDgE2LO5YLAZFyWwKneomwoA59aPiG7SF1y_gNtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>, Yuvi <myuvarani@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 05 21:59:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypj0E-0005zy-MP
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 21:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbbEET7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 15:59:34 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34150 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbbEET7d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 15:59:33 -0400
Received: by wicmx19 with SMTP id mx19so109491620wic.1
        for <git@vger.kernel.org>; Tue, 05 May 2015 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=e53wjwcSBHMHHzCe9+RFoyzKWx4vrieDzOgSkclacp0=;
        b=b15LQ+8ooQpKfJ92Q0vizcvyPEBSQdxQlQSaXaV5pknBkmYIF5ipY5vVK1XJcXe4S3
         ooPXAdqp6okwU7WjjtswP2fVJxjbXfcTaCj7rG7Td/guBexxneZW7hCwBHbTxtiww9KH
         KOtsPgoUD6Ei+vmfeLmUMya7Y/Qk0Fb4uEtoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=e53wjwcSBHMHHzCe9+RFoyzKWx4vrieDzOgSkclacp0=;
        b=gTJQH/KK3KdKMVEvcSuuuh0+pR46wco7r+IKsOtyhrJwz4jRMtQmj5KgPuMvHBlYrj
         8zmJl1aJwpvbl+IgpISKY3MoPtWzRW6KCRTrt0cz4h91rG6vLIRIzOm1GEeGhk6hdNsc
         SZDfXQl6MPyETag68I3XZAM0YuXgQxJgqItm+CwIoCzKX3VBL+P9OOa7ZgCeTmHtS8aw
         Ib2SLn26n2LHXGIQE5X5ag3W5fcI1U09yMmI5yV60McZd6YTqRaK1bWZd9+cu1i5Jc15
         1FgAszDI4bnDOddJWNQq/x3RZBZLeDF1vAJ6pM37zVoImnFOIOk217AaoUrU4IWYPmuw
         64yg==
X-Gm-Message-State: ALoCoQkfn8X6qH7qBXBSmGwB/cYTf8VmD2VCGswNLcGIea2kezB65FdpPh7+r6MDT/W20NEfSCsy
X-Received: by 10.181.13.113 with SMTP id ex17mr1408162wid.12.1430855971988;
        Tue, 05 May 2015 12:59:31 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id go4sm487944wib.1.2015.05.05.12.59.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2015 12:59:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CAGZ79ka=jabDgE2LO5YLAZFyWwKneomwoA59aPiG7SF1y_gNtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268422>

On 01/05/15 19:03, Stefan Beller wrote:
> On Fri, May 1, 2015 at 9:07 AM, Yuvi <myuvarani@gmail.com> wrote:
>> Hello There,
>>
>> Here is the problem I am running into.
>>
>> I pushed the committed changes into GIT repository sometime during end
>> of Jan. I realized that the changes are not existing. I suspect
>> someone has reverted them.
>>
>> Wondering is there anyway around to get the changes back or can I see
>> who reverted the changes on a specific file ?
>>
>
> Look at http://git-scm.com/docs/git-log

git reflog might also be helpful.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
