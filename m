From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH/RFC 5/7] refs: add function to repack without multiple
 refs
Date: Thu, 29 Aug 2013 14:09:22 -0400
Message-ID: <521F8E52.3030904@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <85ef4bbb02b7648560d016a5b7ec62df9d394bdb.1377784597.git.brad.king@kitware.com> <xmqqli3k5rjx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:11:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6gX-0006rH-Dx
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276Ab3H2SLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:11:05 -0400
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:43709 "HELO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755073Ab3H2SLC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 14:11:02 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]) (using TLSv1) by na3sys009aob118.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUh+OtkK9LD5gAA+5zuMtinBx9toKJjrW@postini.com; Thu, 29 Aug 2013 11:11:02 PDT
Received: by mail-oa0-f51.google.com with SMTP id h1so1033366oag.38
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=YU2P5KM0ngPSs4bSAeOkjBzfbX8m6Rwt9L6xvkSgIZs=;
        b=M7bbb00/f9VzPxwKx4VFJkjhx+vrLnXcRZEiQ0fsxtEmDWdA3loMrL8KVihPCrXcTJ
         9XURM64zADjF3VCDXxE42YNYg2tgViY1gNYwsS9gKKyhZpcerMRW67t8Hm4ZOYvtTXDX
         IFsuC440DTYKfNfw+9G5Gh+k6rK3oYGF7fXIcJW36Eb+wUVQSqf0qSLlxAjAf3wOcXQZ
         sXjqLDCKxdwyZvpqR7wV5EqBN2umFJXy14rdGggfwqlYg1KgT22LIs7CM3JLU3z2xv3t
         TbCJONiPxzHdOuMHcSmIYrDO1IT2w6/jMLKUIBl5dCAtspe5SwgERbfQXlbvVDGY9EbH
         mLhA==
X-Gm-Message-State: ALoCoQlRW5YbDdQ4E+7wnMrrNgd6yxiOuxNSZuQScjw8OcCZIOPeULL1q9HdcQF6HFAZcwwy0u0S0gboL3btcvt1Y89rMw97YVJ0oW1Mq5NGoHugHGGqRqRx5bn9LqrXMs4GyQNoSKZIzRuAacF3tJhqVAad4YWRsg==
X-Received: by 10.182.81.41 with SMTP id w9mr3521972obx.18.1377799861673;
        Thu, 29 Aug 2013 11:11:01 -0700 (PDT)
X-Received: by 10.182.81.41 with SMTP id w9mr3521968obx.18.1377799861609;
        Thu, 29 Aug 2013 11:11:01 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id pt4sm32713478obb.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:11:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <xmqqli3k5rjx.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233300>

On 08/29/2013 01:34 PM, Junio C Hamano wrote:
> Brad King <brad.king@kitware.com> writes:
>> +	if(i == n)
> 
> Style:
> 	if (i == n)

Fixed in next revision.

-Brad
