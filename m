From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 1/7] config.c: fix accuracy of line number in errors
Date: Thu, 24 Jul 2014 19:03:43 +0530
Message-ID: <53D10B37.3000403@gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>	<1406140978-9472-2-git-send-email-tanayabh@gmail.com> <xmqqegxbd9u0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 15:33:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAJ9d-0004Dt-TE
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 15:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758807AbaGXNdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 09:33:50 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:50266 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758778AbaGXNdt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 09:33:49 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so3691782pdj.12
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Rr0B8idYWTzFzvqbe7FlDCP+6L9rwZcw6YuRLcK/Kao=;
        b=UJ4iyrTTJT/5hs0MAhX4RuWch7E9Yv/4hBMuGQ6axiOgduOlNUjnjgigW+Sf1gkhvt
         UP0ZG/I8GWFpfLHhKBnz+VyaAGuxp1XN/+eI/WygExuagDnKZOmnrxN7Uc7BlSgfGADJ
         Y7dwJRHcEm9dfdXAsbZayW40PVw9UAbY9GuSkSG4b5p7PRpB74aNuAd4Q/wjKZJcRVTJ
         Q/YFms4pXCv1lRGRCt6xuUB3O7t6l5VSi/nZ69GXaB6lkCkFg7C2rrS3ZOilCK3FJy9D
         bN9xruDMjSyC2IHJhdHsXb7z1l9zPCyBseurOOseBzlGFYqCyOt4HFb3IgjlzABGozJ0
         J1qA==
X-Received: by 10.66.190.167 with SMTP id gr7mr10245056pac.75.1406208829075;
        Thu, 24 Jul 2014 06:33:49 -0700 (PDT)
Received: from [127.0.0.1] ([117.96.50.136])
        by mx.google.com with ESMTPSA id gd2sm5637728pbb.95.2014.07.24.06.33.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 06:33:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqegxbd9u0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254155>



On 7/24/2014 3:19 AM, Junio C Hamano wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> If a callback returns a negative value to `git_config*()` family,
>> they call `die()` while printing the line number and the file name.
>> Currently the printed line number is off by one, thus printing the
>> wrong line number.
>>
>> Make `linenr` point to the line we just parsed during the call
>> to callback to get accurate line number in error messages.
>>
>> Discovered-by: Tanay Abhra <tanayabh@gmail.com>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> 
> Thanks.
> 
> I am not sure what to read in these two lines.  Was the fix done by
> you or Matthieu?
>

I misunderstood the meaning of the message trailers. I will correct
it in the next re roll.
