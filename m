From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH] config.c: change the function signature of `git_config_string()`
Date: Tue, 22 Jul 2014 17:18:38 +0530
Message-ID: <53CE4F96.3000409@gmail.com>
References: <1406026196-17877-1-git-send-email-tanayabh@gmail.com>	<20140722110720.GA386@peff.net> <vpqsiltsjm7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 13:48:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9YYs-0004ke-2d
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 13:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbaGVLsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 07:48:46 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:53375 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbaGVLsp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 07:48:45 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so11111083pdb.31
        for <git@vger.kernel.org>; Tue, 22 Jul 2014 04:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=qj8mMC6BK/NKvZT3pyy1MIJNoC48j9cpfjHxA1gXgLI=;
        b=EO6rgE+k8mYs7s4Bf6JEDzQNtUCvmTUfOaKPR+2Z7i9qkQsbhtjimO7Jf0VdlWr4on
         neWR5ALP+kwAkmRfuzCHB0Umgh0+1z4N6Ca1OQLlIldAsN7bkdB1ZbMEdJeasErH5Ulb
         y+m+AzZkBOtCaXzBpJJmYgL/MYONilbU4o9Q8S9pjJzlXGJG61fSnYCjobqRAU/VhM+y
         ND6itajoXr0JejvNx7AdT1hqYOy9hq9wqm3sxHIw66+sv2NRdoQcvWtU0ka4Jmt9+SWD
         /Z7Gb5xgUfG6RS3Gux0Ay0yVmQXLRJePmcq/qk50FDOHmNyw1SfnMdo6NFTFrhad9++C
         X8cg==
X-Received: by 10.70.34.103 with SMTP id y7mr515950pdi.37.1406029725194;
        Tue, 22 Jul 2014 04:48:45 -0700 (PDT)
Received: from [127.0.0.1] ([182.67.207.4])
        by mx.google.com with ESMTPSA id by7sm601046pab.35.2014.07.22.04.48.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Jul 2014 04:48:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqsiltsjm7.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254016>



On 7/22/2014 5:14 PM, Matthieu Moy wrote:
> Jeff King <peff@peff.net> writes:
> 
>> will complain that we are passing a pointer to "const char *", not a
>> pointer to "char *". And indeed, compiling with your patch introduces a
>> ton of compiler warnings.
> 
> Tanay: are you not compiling with gcc -Wall -Werror?
> 
> (see my earlier message, just create a file config.mak containing
> 
>   CFLAGS += -Wdeclaration-after-statement -Wall -Werror
> 
> )
>

Yes, I was. Dunno why it didn't work then.
