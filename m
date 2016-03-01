From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: GSoC 2016 Microproject
Date: Tue, 1 Mar 2016 17:08:54 +0530
Message-ID: <56D57F4E.7000402@gmail.com>
References: <56D19EF9.3070702@gmail.com> <vpq8u26qo3y.fsf@anie.imag.fr>
 <56D1BEC8.9010302@gmail.com> <vpq1t7yqgi4.fsf@anie.imag.fr>
 <56D2C828.6010901@gmail.com> <vpqpovfblru.fsf@anie.imag.fr>
 <56D46493.4040909@gmail.com> <vpqfuwbbjlx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 01 12:39:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaidt-0002xk-Sv
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 12:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbcCALjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 06:39:00 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36333 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbcCALi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 06:38:59 -0500
Received: by mail-pa0-f44.google.com with SMTP id yy13so110706678pab.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 03:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=fEcIvMlpzzdO6C6g8ArZ1qzjYcS9FsTjn/dkCvjkdCE=;
        b=bIhGrYbRkamzVmXOirPgT2ZUxm+ne1NvK9cH8VSRN5XsfvdCq2Zu9o+tZEK0RuqTb8
         5YFlv4+oixVbRA684HfSfCPTB3FnQjxkWaoPh/wgfdks37icvkN4aQkMXU5GzuEhy0uz
         HkU1G1DFI/isoNp4hbcCP9x73AiE2Cr674roGfDyNCcQ/tAQGZT5xPLjYF+icbovk7xt
         +jdWFdiIO56d2Qwz+8segXM3o1byKcvcBAWtp4yRPgtlPhQlGp8/1QpvaQx1Omeg2Xft
         XYIlnWuABCLmbS8G6EI+L+SnpUm0t2NgDWhOl0yMOmIr1kq4jhkPk3zXP/IqSkCkMHal
         cL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=fEcIvMlpzzdO6C6g8ArZ1qzjYcS9FsTjn/dkCvjkdCE=;
        b=MTEw+pqMtpiR3mGt44PQfWoHnwZC+LFF0d1GA7217zDr5MxS7F+R1m4kUeCK2qh90k
         QABUh9SsE/w/27GxyII77uzqpFy8k8qGmVHzu23k+JjaTF1MX+MQTqq9nrrLj+7NIKG4
         tOYSfJZcbj8NFmI9c+SzEyDCLjrFi1rJDZ+XwQOtDdyTOPq+inW2o+tDMUM3gaBveHPt
         fT5u5oOvHaTOHw8PgSdzkqal21vIeKFHFlNI2J+OPnbFuljs4zHJffe0MUXNOkdrJK4A
         upJsHo3Awpy5d8lwDz8mWxSc1+npgEcgVyu0T3yNwP07iSjPUJ+pUKQE2qbdB0lbAwii
         4d5w==
X-Gm-Message-State: AD7BkJJUt/F/7SIfJtiFZu2bmD+ZaP0L5d/NS4ArMQXCtF8ORKZwuOG3ggpKTvM15JnmmA==
X-Received: by 10.66.174.199 with SMTP id bu7mr29369689pac.34.1456832338904;
        Tue, 01 Mar 2016 03:38:58 -0800 (PST)
Received: from [192.168.221.113] ([14.139.251.107])
        by smtp.gmail.com with ESMTPSA id k14sm45009573pfj.0.2016.03.01.03.38.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2016 03:38:58 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <vpqfuwbbjlx.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288010>


> If you use PARSE_OPT_HIDDEN, I think you don't need to specify a message. Otherwise, the documentation only has value if it contains more than just the option name, but that is the hard part if you're not familiar with the code. The best place to find documentation is in the history (git blame the file and see if the commit message introducing the option enlightens you). But that's why I said this didn't have to be part of the microproject: writting good doc requires a good understanding of the whole thing ... 
I used OPT_HIDDEN_BOOL for all except for reject-thin-pack-for-testing, where I used PARSE_OPT_HIDDEN. I ran the test locally and also on Travis, and the all tests passed. How do I proceed now?



Thanks and regards,
Sidhant Sharma [:tk]
