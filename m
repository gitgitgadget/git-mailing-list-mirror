From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Fri, 12 Feb 2016 09:29:28 +0100
Message-ID: <ED514A90-08AB-4EBC-BA17-ABAA06FE64FE@gmail.com>
References: <vpqoabox66p.fsf@anie.imag.fr> <CAP8UFD0UxB6Z1UU=4Bkz0Yt2KE+AkrttQeTx2oY9v9O78f9qow@mail.gmail.com> <vpqd1s2e74l.fsf@anie.imag.fr>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 12 09:29:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU96f-0005yN-VW
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 09:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbcBLI3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 03:29:33 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35203 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbcBLI3c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2016 03:29:32 -0500
Received: by mail-wm0-f49.google.com with SMTP id c200so9629347wme.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 00:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ebe8AeNbudcJLu/KEUJH5fTMfuYA62XMxkuvRVbSdd0=;
        b=btfW/tYKsHdGLV6fALI0mgB1pDzua186cuF/zKr53jjhlU4JKywQsn5FgGPwzqZ5be
         GUgxI2vXNCv+nRWo82kNb1h2eZGC2rM5SugUEwAr8WdQRUnDHgBa4a1cmwre2tZxEYFr
         F5EAgTCzmoBJt3RuJhmo81M4e536W/sQGwOZh2wq97nd3zwRPy8KWbjlL8HZCEUPFR/J
         9EmWuyCURYuKCS2c5PLzWfGsqhTSsMl9gD/ffBduEFoWnuhGRFq0aYMiP09PnaeqeTMe
         dRoBO+RCcPLTNs2JgnCw2f+w5wyPuRabtJvVfY6TXoAEUrQ29NT65qnZH4zxfjNQybzZ
         o15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=Ebe8AeNbudcJLu/KEUJH5fTMfuYA62XMxkuvRVbSdd0=;
        b=ctRE3lY2TFMCLZZFVbl8z9PFzwS3mne1eOMalzofRRt2tb2okSxFL6yk+Ia1ZtH8Uu
         gRdiVkvR3Fjw8gPx142llrueaPoRv7STud825KdyTrZNa67X+87/AHCGIt9gnrxKsdb3
         s77sb1ZtPYpHcrGYxvTjj34M0IW59ZEXJ2gcSOA5M3ohnZyrWp1+szBJgLhecChEpx/c
         FEM1AemIj3wMiVKmQXMlo5bahiHMiuQ0SUmj1htoJSMbPKbwM+njJS4m5NKiXSVZiM6a
         GsdcZJS0Cr+IAf3LWMC4vwztFL3SaqWznxJQhZMOt1u61qfNKNS7muZNYrcFsRh+MMEn
         bhUA==
X-Gm-Message-State: AG10YORRug81zhLGgE/7EMbWa6iWfT/2ScvESiQvHQElxQxsS4ugXBY4NEWkCdIsaq6wjA==
X-Received: by 10.194.90.172 with SMTP id bx12mr338333wjb.128.1455265771571;
        Fri, 12 Feb 2016 00:29:31 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB453E.dip0.t-ipconnect.de. [93.219.69.62])
        by smtp.gmail.com with ESMTPSA id pu8sm10965519wjc.17.2016.02.12.00.29.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Feb 2016 00:29:30 -0800 (PST)
In-Reply-To: <vpqd1s2e74l.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286040>


On 12 Feb 2016, at 08:10, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:

> Christian Couder <christian.couder@gmail.com> writes:
> 
>> Hi,
>> 
>> On Wed, Feb 10, 2016 at 10:31 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> 
>>> So, the first question is: are there volunteers to be GSoC mentors this
>>> year?
>> 
>> I can co-mentor this year too, with you or someone else.
>> With you I think it will work out even if you have less time than last year.
> 
> So, that makes it 4 possible co-mentors, i.e. 2 potential slots. Not
> much, but it starts looking like last year ... ;-).
> 
> Peff, would you be willing to co-admin with me (that would be cool, you
> are the one with most experience here and you know the SFC stuff for
> payment)? Are there any other co-admin volunteer?

I don't know what level of Git development knowledge and what amount of time
is necessary but I would be available as junior co-mentor :-)

Cheers,
Lars