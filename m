From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: 0 bot for Git
Date: Wed, 13 Apr 2016 08:11:54 +0200
Message-ID: <88CF8CB5-4105-4D0C-8064-D66092169111@gmail.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com> <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com> <vpq60vnl28b.fsf@anie.imag.fr> <CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com> <vpqoa9ea7vx.fsf@anie.imag.fr> <xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 08:12:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqE21-0000uF-0Y
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 08:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965557AbcDMGMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 02:12:00 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35981 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965424AbcDMGL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 02:11:59 -0400
Received: by mail-wm0-f49.google.com with SMTP id v188so154993340wme.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 23:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=908ujJkLUUeknqquyGOgkCBQkMMnRPJRGN+VZSEgebE=;
        b=lD6tz4lZr8B4GBsYYSvBUPCGCPOLDO4SsA6opgqAt81SiFqZ/2SueBthz+OpSbba+B
         jN/imrBq7/pMoIpyK3Wsoy8U+pFMsiyoODUJeO9O6WGw0e5TqSdem2d93TuUT0wtYxyx
         ulyLRS/BWTfFUhnMI/VKnwMZxfXyySHOmocddiKbXRJV30cQTq/ZwKu3GAaYGmSSJNIh
         8XH5M4IZGA4d5uzHXa9N6QBcp0A+IR0pjKHNbeKWRgQOk9dP1INjqkr5zqGnWzlnVTzj
         axibkWzHvRs4ZBe8jzOdSIqJtYNqDg5+KjFcToxKPkawDEmR0hsbIEJcYdwEZrtHOTJ0
         f7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=908ujJkLUUeknqquyGOgkCBQkMMnRPJRGN+VZSEgebE=;
        b=HOFXo7rLxQgeVURdMhK40qYRts0yFZpzH/OrKbdtWI6zwtCO/PQVrW+sHht1pcX73A
         osszmnz/z6xaq7PIofGu10gyFnSpl2F6zXUN7+SAfWQv4JE4R7LlcrneTeDCXSYOv2hY
         fpdUU8Zs1ETXix1Np0B/b9wZENF5klmDoOb0sYw2/GNZChahyysji/kqj8snsJsJENYz
         HbR1FFO16u0L+AQH/qy6Jm/ZuHjrXmKM9hj+V3/G/iaJ0ZF9XbW6jOSe7Em27VstjrWh
         RhcEVfXy4nVr9Sf1INB+O4tavskmbXazdG+pBAGpTTf73EEJlZGLdqW27KF/kjTw2NzO
         HBOg==
X-Gm-Message-State: AOPr4FW96EfRfDOtZU7BTVvtRwWTdwjvJkqUx5J1Puk48dAiwIW7gY/5vEplgLkDDOltGg==
X-Received: by 10.28.170.137 with SMTP id t131mr8755542wme.32.1460527917492;
        Tue, 12 Apr 2016 23:11:57 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BA361.dip0.t-ipconnect.de. [80.139.163.97])
        by smtp.gmail.com with ESMTPSA id o128sm26142965wmb.19.2016.04.12.23.11.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Apr 2016 23:11:56 -0700 (PDT)
In-Reply-To: <xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291374>


On 12 Apr 2016, at 22:49, Junio C Hamano <gitster@pobox.com> wrote:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> But my point wasn't to say "we already have everything we need", but
>> rather "we already have part of the solution, so an ideal complete
>> solution could integrate with it".
> 
> Yes.  That is a good direction to go.
> 
> They may already have part of the solution, and their half may be
> better than what we have, in which case we may want to switch, but
> if what we have already works well there is no need to.
> 
>> I don't know how 0 bot solves this, but the obvious issue with this
>> approach is to allow dealing with someone sending a patch like
>> 
>> +++ Makefile
>> --- Makefile
>> +all:
>> +	rm -fr $(HOME); sudo rm -fr /
>> 
>> to the list. One thing that Travis gives us for free is isolation:
>> malicious code in the build cannot break the bot, only the build
>> itself.
> 
> True, presumably the Travis integration already solves that part, so
> I suspect it is just the matter of setting up:
> 
> - a fork of git.git and have Travis monitor any and all new
>   branches;
> 
> - a bot that scans the list traffic, applies each series it sees to
>   a branch dedicated for that series and pushes to the above fork.
> 
> isn't it?

Mailing list users can already use Travis CI to check their patches
prior to sending them. I just posted a patch with setup instructions
(see $gmane/291371).

@Junio:
If you setup Travis CI for your https://github.com/gitster/git fork
then Travis CI would build all your topic branches and you (and 
everyone who is interested) could check 
https://travis-ci.org/gitster/git/branches to see which branches 
will break pu if you integrate them.

I talked to Josh Kalderimis from Travis CI and he told me the load
wouldn't be a problem for Travis CI at all.

- Lars
