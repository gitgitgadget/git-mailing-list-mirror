From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: GSoC 2016 | Proposal | Incremental Rewrite of git bisect
Date: Fri, 25 Mar 2016 17:13:58 +0530
Message-ID: <CAFZEwPPKE1kODzSD4ZqZOehSB2SUUAC5JF-j7__kA2obpV92Tw@mail.gmail.com>
References: <CAFZEwPNXKo5YN9OPPCkO90bSPD3ittU+y8eDxh-JLxnihBznuw@mail.gmail.com>
	<CAP8UFD0muBUEp9XknmcTWqg==ChzWP3m-p-v6vXyC09OC88U7w@mail.gmail.com>
	<CAFZEwPM=+U8gC0JRL1Zi6yJboenuSw6hBKJeLNzf_=NYQTCSGA@mail.gmail.com>
	<CAP8UFD0vm1Sn07ickfPz5segbM-M7+HR43CMMGsB9WTqj5s-yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 12:44:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajQ9s-0000s5-El
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 12:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbcCYLn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 07:43:59 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33884 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbcCYLn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 07:43:59 -0400
Received: by mail-yw0-f195.google.com with SMTP id f6so8548840ywa.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 04:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=iwQbr8XoJZ/XnZbREoHAfwhSJXWglNUrgtqCXftjyBU=;
        b=KDnDUDDOBPVaLSaZ1qVAPlH/cTJLIiviGeMYKD0hVUrPpvo0JS1LgW0gkQgc2aTF6p
         pahYmeGOsTP6pKB+G8H4vFhxvDRBwm5DkUrSxsmpf64YffYSe2lggPD6NuUxlaUiUItx
         0EIPE3QQjnW+fPqDamoolnLYpt6j3gDRuMu+6v/ooIqBqpaZSbuCU8nREvybxiiBh1Q/
         8CAD3IlXUJMXQTPo+f2+5NB7z32fXOKUFJAzhicM5kMLkQj02vXGhAf+CIu8yisGt/WV
         Nh52/7xClPZjr0sgd8h63Ui4J3cbnf4MN/YO9Sxd9fk/RZb+XjGsBL5Za5K2zGeKUfyV
         FZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=iwQbr8XoJZ/XnZbREoHAfwhSJXWglNUrgtqCXftjyBU=;
        b=BFcQtohqjUaj2iDtgMQs5t1TnlHcOStDaZBP7cZZW5c74/FHK3p5zKIizfFuT4r3WE
         GZusP1iuNjzegzrFG+/GPQaqWlPAtQRuFqPFaD9oepejxQ1in/7hPuWIR1p+aNwTOSnT
         JaKniAo2ZSehvZEXgSRI0M/gTGZNJqsmWBxmdfgMHWliL+AXcV/FxzVeYuMENZRrZn/+
         g8t/gQQkX7iLY6HErybEZZiFjJgRQJO1Of5bH5Jc0gRp8XDerREbUnpoMKkywPaRyZs1
         KIALOp1Pro9O+cxmwqONysTeR1ohRPsvVMbxyO/UKeO7pjkizNE37ymIbmANYJ4xKysE
         a+9Q==
X-Gm-Message-State: AD7BkJIxDhDW9UTvKQNd6/s6vKgHDBIo6x/lhre/y02YU9t7CjX8lZvYoi4k/TWM3sOaA7GOHGDqDRTOAj50ew==
X-Received: by 10.37.230.200 with SMTP id d191mr7548790ybh.131.1458906238177;
 Fri, 25 Mar 2016 04:43:58 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Fri, 25 Mar 2016 04:43:58 -0700 (PDT)
In-Reply-To: <CAP8UFD0vm1Sn07ickfPz5segbM-M7+HR43CMMGsB9WTqj5s-yw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289880>

On Fri, Mar 25, 2016 at 5:10 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Fri, Mar 25, 2016 at 11:15 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> - you will add an option to "git bisect--helper" to perform what the
>>> git-bisect.sh function did, and
>>> - you will create a test script for "git bisect--helper" in which you
>>> will test each option?
>>
>> I had very initially planned to do this. But Matthieu pointed out that
>> it would be much better to use the existing test suite rather than
>> creating one which can lead to less coverage.
>
> Ok, then perhaps:
>
> - you will add tests to existing test scripts, so that each "git
> bisect--helper" option is (indirectly) tested.
Yes. I will mention this in the proposal also. Thanks for reminding.
