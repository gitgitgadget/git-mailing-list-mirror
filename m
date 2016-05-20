From: Jon Forrest <nobozo@gmail.com>
Subject: Re: Odd Difference Between Windows Git and Standard Git
Date: Fri, 20 May 2016 07:28:41 -0700
Message-ID: <ba34485d-43cc-ef35-ebc0-67b944a420a7@gmail.com>
References: <nhlqd4$ekr$1@ger.gmane.org>
 <c07df4ac-08c9-8eaa-0233-06616945c857@web.de>
 <c20b9819-1b2d-6704-d870-1c0102dd9e35@gmail.com>
 <ede1c113-1ab8-6043-3e39-bbacec5db31c@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 16:28:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3lQ5-00087e-Ek
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 16:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755743AbcETO2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2016 10:28:46 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32777 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756AbcETO2p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 10:28:45 -0400
Received: by mail-pa0-f51.google.com with SMTP id xk12so40205999pac.0
        for <git@vger.kernel.org>; Fri, 20 May 2016 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=cp5ZNUj2KqerVpTLwTJE8ZXL0ckzCr6IEzK5NcZptwM=;
        b=LlbXW6BejGKfguhy6c+F/jGJCkNXp73hMQE8KrHUx8sfkHtHoWUTlzXYvd5SBoNM9F
         UwPr6JjfoLA8FVunYOHQSpUFNieochnUw19bDMvJkOfc3U2H1ZJ2Gt/TfWMKp24cDy4/
         6rXy3CT4Ep9tf/CoipQeZyzq/b3lVtqU7lWeRS/mNA7mbERcTgcRyH4GcW/gw5X1yFFl
         nm1qgEnnFJwvEJuVwoDPxMvAGWVYCErIf3H0FFJ73Z9aYPUYH7DC5vS0WXVfg+oKiZml
         uvb47P977UxcZVOopprET5SSK6PB7NzOAlvpzU7uuNZq9m7fp/RbBNw4+4ysnAYaPHXt
         eKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=cp5ZNUj2KqerVpTLwTJE8ZXL0ckzCr6IEzK5NcZptwM=;
        b=Ufk7bikAXt4tdr7JH4AywD36JIVpHTNGsVztkMe6etHbp0Z6OHhe3iWHkk8Yg7vmKB
         UpdnsGDo0v6VQv/XNzkBK7hXsxMKNr3TcLTEd3rho7Hyid2/6kxf3Rfp7GKFg7RttyXl
         V6QC0anqfJWZjWd89wPxeX5dT4j0ZoeZz2I9+UEcBpRtaLbuAO8T5zPzuryyFGJKDImJ
         yZt0oy8UbKLgPUAIuk69zWLS4qE99qhcFMNEuRBlQcXa8mk2SBfWtS+8z84vL3uRsM9G
         UIGGrZhwCaFHY04atwUUVRApJruJMAzow0CXBAMndi8B+X6yTIUJu7ZwSPgBcFKTRPf2
         s6sg==
X-Gm-Message-State: AOPr4FXNc8jXMoEUZF66q0fImKJi+2LMez6pw/LLy4e51J5TuQn1k5La2AxuajesP8BbWA==
X-Received: by 10.67.13.144 with SMTP id ey16mr5194757pad.147.1463754524408;
        Fri, 20 May 2016 07:28:44 -0700 (PDT)
Received: from [192.168.0.104] (c-71-202-183-39.hsd1.ca.comcast.net. [71.202.183.39])
        by smtp.googlemail.com with ESMTPSA id az6sm27813941pab.43.2016.05.20.07.28.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 May 2016 07:28:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <ede1c113-1ab8-6043-3e39-bbacec5db31c@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295170>



On 5/20/2016 7:19 AM, Torsten B=C3=B6gershausen wrote:

>> Great question. For all the unexpected files it says the
>> same thing:
>>
>> old mode 100755
>> new mode 100644
>
> So the solution is to run
> git config  core.filemode false

This worked perfectly!

I wonder if this should be the default for Git for Windows.

Thanks for the quick (and correct) response.

Jon Forrest
