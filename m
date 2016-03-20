From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Sun, 20 Mar 2016 21:21:10 +0530
Message-ID: <56EEC6EE.10602@gmail.com>
References: <56E3BE3E.9070105@gmail.com>
 <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com> <56EAC49B.6020909@gmail.com>
 <33EDD26C-ED5A-42EE-B523-240AEF5C51B7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Kevin Daudt <me@ikke.info>, philipoakley@iee.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 16:51:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahfdS-0003i2-4e
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 16:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415AbcCTPvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 11:51:18 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35870 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbcCTPvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 11:51:16 -0400
Received: by mail-pf0-f194.google.com with SMTP id q129so26249814pfb.3
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 08:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ygTbJ9GlIql8h0XLtG+eHwh7oepdeXsFubwo0hVrOAc=;
        b=GCKV+yLCNTcthcEMdSbpLkiX/mSImJMpuzRByJK2/ACUG54hBcz4J2FEhGLxCwq4Dr
         6fPON4WaGph9GF4V7JKMfQQQpDHm3AfljnU9ocYwd/8bUvjpaJ1JuOnjftPKhyO7upa4
         geJyiz8Vkp32HjOmQm5V8rs9k2Xd0OB5MElz0alduoWQ8AWrwoJqK48BV6tLaZs9xkLU
         0QK/vBOp5Fv8c1W3Mt4NYpE4fD+Cg3tKRQlheJpShoXuLXya6zimzdS4ji+dPx9lKpQO
         g0D2BbunApsqGNUtqsjd2LOc3v24l+LAYQtcpxdYd6EV0WIs0JT+I7/mTAf/PfmvXwM7
         aaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ygTbJ9GlIql8h0XLtG+eHwh7oepdeXsFubwo0hVrOAc=;
        b=Q1AGlWYwV+5IsD4tDj6fyzDISfx0L1ksI/cGiu3O4Tvvr0uuyGADU2OW93CQzC8L7L
         CIOOT+kIbndwt8PvHV8xquhOt7Rr6X79vDNShUt6IvcVlGW4IMDvCj3hUzvAsee+pBPx
         0mYbzP7O40lJF/2krX5X+zo7b06PmL0Fz0bqCcHPHNY5RA/hYuYpul/SF2aHpZTf+CqA
         eesB8nT6tovZjo11QJ1+PmQaIzeZ5Jz1tHhKmIyWpnz8oxyLDET2KWPP9WfgL7Qrgjm0
         3wKdh4tU0qP8KsANBwIYsrIa5MUlhCzsgN+x/DdM/TWp2BCXQpsxLUJEjrPGUWxQ88AA
         nBNg==
X-Gm-Message-State: AD7BkJLzuoM8sSVugYAmfj/Z08PdvVNW0/ibvE6fdRx1WZLCf8eEZj7ZjgVxwy+RlCI4uA==
X-Received: by 10.66.120.46 with SMTP id kz14mr34287552pab.61.1458489075930;
        Sun, 20 Mar 2016 08:51:15 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.159.75])
        by smtp.gmail.com with ESMTPSA id wh9sm34353756pab.8.2016.03.20.08.51.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2016 08:51:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <33EDD26C-ED5A-42EE-B523-240AEF5C51B7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289360>

On Sunday 20 March 2016 09:09 PM, Lars Schneider wrote:
> Hi Sidhant,
>
> that sounds about right to me. In what language do you plan to implement the 
> wrapper?
I'm comfortable in programming with C, so I think I can use that. Otherwise,
I'm also comfortable with python and familiar with bash, if they are required.
Would C be the right choice though?
Also, I've made a draft proposal for the project and uploaded to the GSoC
application site. Should I send it to the list as well for RFC?

Thanks,
Sidhant Sharma
> Best,
> Lars
>
> On 17 Mar 2016, at 15:52, Sidhant Sharma <tigerkid001@gmail.com> wrote:
>
>> Hi,
>>
>> So to sum up, the list of tasks for the project would be:
>> 1. A wrapper is to be implemented around (called 'ggit') that will scan the
>> arguments for potentially destructive commands. When none are found, all the
>> arguments will simply be passed through to git.
>> 2. If such a command is found, 'ggit' will:
>>    a. Show what the command is actually going to do.
>>    b. Ask the user if they are sure they want to execute it.
>> Eg. "You are about to do X which  will permanently destroy Y. Do you want to
>> continue?"
>> 3. For all commands that are entered, 'ggit' will also show a brief summary of
>> the command what it will do when executed, explaining it's intended usage.
>>
>> Is the list correct, or did I miss something?
>>
>>
>> Thanks and regards,
>> Sidhant Sharma
