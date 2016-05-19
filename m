From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] Add userdiff built-in pattern for CSS code
Date: Thu, 19 May 2016 13:41:18 -0400
Message-ID: <CAPig+cQcK4x+u=PjxGAAPnAgqCAxLHrvbH8Pqgjgd9aAe85g7g@mail.gmail.com>
References: <20160519100625.7945-1-william.duclot@ensimag.grenoble-inp.fr>
	<840800650.10903639.1463669101272.JavaMail.zimbra@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 19 19:45:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Rwq-0006j1-Cn
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 19:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbcESRlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 13:41:20 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:33297 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342AbcESRlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 13:41:19 -0400
Received: by mail-io0-f170.google.com with SMTP id t40so24484776ioi.0
        for <git@vger.kernel.org>; Thu, 19 May 2016 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=9x1W6WJ0q9i2soyPfate65C5qqi4YHW/KEYrkjCj5co=;
        b=kYlLO234O2LxDtBO0xMvjj6JgTGnP6goYb3eANTmnwV6inDYIFx5MyLtAXuLTaJlk4
         0B7sX4wnrfgNdfLy76MW4MY6sjBC9p7D9KIx8W0S12RV259daR9117i69VlTW9wAJuwz
         8OuXjU2Q5voJ7vU4t+024Bw5+BnxAb9/qTAwGCDjxhGQoMiNRDudgBQvrSfEOI/cyOfW
         yysuFlDJcbwMHPAxPrVD4042de1afCcA7ogP21GG3mf98/JDn4WXNveUuc1y5m+ue7S+
         YUcY/w/2JE1tAoeHwKfk6NnndlMjP/ip7vtrsE9+H9dMiZXlUTwuWl4HLS3FXE65/SHQ
         EzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=9x1W6WJ0q9i2soyPfate65C5qqi4YHW/KEYrkjCj5co=;
        b=VqHxoPKqpXCCRygZ9aoQJLlfkymp7rtUzJ1HXb9SBHmbipaDBCg97rYxGDU/BnaDib
         ZEKLOtI23nagFbdTaDPTqd5vV+5+u6YcAHgw2a7kTCn8tTHW++xIJ9X2iwquEDs5vMda
         gRx6uA2n4eIV4kwf6Wog6pQhLMvG196hOeO7gYFMhr6CyOJ5dh5RW/LdzYDF9rSAqezb
         nLp582YDVikFXOIJR3Br9NsfHQ3mBGgYx6/8WsB66gee3PUCRzv28jKcQ8CACRdygbLd
         /iAFQDUxQIp5MvrnA/lPtBIS0yqA2d4bDFTZ78QbREa06kmw4c/Nl6+Xvb9bsIytCFBo
         UFwQ==
X-Gm-Message-State: AOPr4FVHZaIeMLsK03ak3iOpZDXcyt/CjxmkdQwWhpIz0Sf6UpGJIbmTHTq12A5YqzUB9jfgoU3Zni6XYsT/cQ==
X-Received: by 10.36.55.144 with SMTP id r138mr4026649itr.73.1463679678741;
 Thu, 19 May 2016 10:41:18 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Thu, 19 May 2016 10:41:18 -0700 (PDT)
In-Reply-To: <840800650.10903639.1463669101272.JavaMail.zimbra@imag.fr>
X-Google-Sender-Auth: mky48gAT1OUTl_M2zQNwg85UXgY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295080>

On Thu, May 19, 2016 at 10:45 AM, Matthieu Moy
<matthieu.moy@grenoble-inp.fr> wrote:
>> Subject: [PATCH/RFC] Add userdiff built-in pattern for CSS code
>> [...snip...]
>> Add the info in documentation that CSS is now built-in.
>
> This doesn't add much to the patch (we can already see that from the patch
> itself). I'd remove it.

I think you meant to say this "doesn't add much to the *commit
message*", and that the sentence should be removed from the commit
message, while retaining the actual documentation update in the patch.
