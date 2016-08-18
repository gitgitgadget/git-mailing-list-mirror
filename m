Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238981F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 14:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767816AbcHROnx (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 10:43:53 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35330 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767417AbcHROLx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 10:11:53 -0400
Received: by mail-pa0-f52.google.com with SMTP id i5so6607759pat.2
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 07:11:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tobiah-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=BvA1NSLnxl7Q85mbBM9jm/qyOHj7kE7/ZrRyoxG6ynQ=;
        b=K36NREa0EIeqrMYy7BQeRwTfhhZ8i3zjbGVwpvh2HF9azKeFYoLpY7F4EQENYY2K5B
         jzfAUZwA6r2nCwwDBrBrEVZJ7IU8Z4x9x0USKJ2lkl7hb5bHpjcslxgRMZMAUKLUTi0z
         Zero4i2opGVLSB9ZAp8HP83oMkO0YbUMj/WmSl0fk52xbMHD0EYFJMjL2y2fXtuJlviq
         ak7JrpSCuQ48f1VQaGRM89PHlJpeDxo/vf1W+S2wgmG/sS7dXfTaJfIY+JbVSaLoVGYP
         smM62vVnnN+juQBIkUPUdioQuDn7OCV/BbLYAR7pULg7EL8fhXRA1lkT3Ct2rAMI62wq
         NzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BvA1NSLnxl7Q85mbBM9jm/qyOHj7kE7/ZrRyoxG6ynQ=;
        b=eWykMx5fTVggL20kgbjP5eep5hLMjNWdD9woA5RBXXleIDLYi8h6C1hOglpIiNe3fh
         1LdYg0HW7FS5tMwu7MV0Ga3nIoBhXceX8oX1/teomqIAwQzXC7QDDgFaAIdAxxhFKplM
         Ie5V2Ql15hydxJlI2EskRcCMHiDr8HpulnZnXWUFzrMbto4+QXLsBEXfBVBfXFOT3c2C
         PJ3iYkz/Pai9h5N6xil97n0h812GYMbrMjXfyB4oOTVzffnhYaf1jXwXFyD8zEKEQoik
         R6xPs2jDePP5hZZQVXNRHdpZDoobzN/wpq/M5xUkvMZyIEdTirTM1H8FoUX897qHKaaG
         Hhvg==
X-Gm-Message-State: AEkooutFEZqjzFBd+3pV3zo7LmR7AV8gveycD/lk/UqH7LpqIhV4SrC2QRRtOqCXWMEMwg==
X-Received: by 10.66.216.69 with SMTP id oo5mr4359930pac.155.1471529512929;
        Thu, 18 Aug 2016 07:11:52 -0700 (PDT)
Received: from [10.10.10.25] (72-165-89-133.dia.static.qwest.net. [72.165.89.133])
        by smtp.googlemail.com with ESMTPSA id xv9sm4254209pab.36.2016.08.18.07.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2016 07:11:52 -0700 (PDT)
Subject: Re: Working from different machines.
To:	Junio C Hamano <gitster@pobox.com>
References: <71d05705-792f-8bb9-026b-5b9251b104b9@tobiah.org>
 <xmqq4m6j81ci.fsf@gitster.mtv.corp.google.com>
From:	Tobiah <toby@tobiah.org>
Cc:	git@vger.kernel.org
Message-ID: <c374f742-bc42-fdb5-37e8-f795a14259a2@tobiah.org>
Date:	Thu, 18 Aug 2016 07:11:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqq4m6j81ci.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/17/2016 03:41 PM, Junio C Hamano wrote:
> Tobiah <toby@tobiah.org> writes:
>
>> In other words, I want to work from different machines, and always
>> sit down to the environment exactly as I last left it.
>
> You have several options, but it depends on untold expectations you
> have beyond "exactly as I last left it."  So the following is only
> to show directions and possibilities without going into details.
>
> For example, do you save all changes you made in your editor buffers
> before you leave the 'desktop'?  If the answer is "no", then that is
> not a problem Git-the-tool is interested in solving, and the only
> solution I could think of is to use mechanism to share the session
> between 'desktop' and 'home', using things like remote-desktop or
> screen session.
>
> If the answer is "yes", the next question is if you commit all the
> changes you made before you leave the 'desktop'.  If the answer is
> "no", again, that is not a problem Git-the-tool is interested in
> solving, and the only solution I could think of (in addition to the
> "share the session" above) is to use networked filesystem shared
> between 'desktop' and 'home'.
>
> If the answer is "yes", then you are in the problem space that
> Git-the-tool is interested in solving.  Assuming that you have
> network connection into 'desktop' from 'home', the solution would
> involve making it the first thing to do when get home to run "git
> fetch" on 'home' to get the latest state from the 'desktop', and run
> "git push" on 'home' to push out the latest state to the 'desktop'
> before you leave 'home'.  If your 'server' is for your sole use, and
> if 'home' has network connection into 'server', then you could
> instead rendezvous at 'server' by running "git push server" on
> 'desktop' (or 'home') to 'server' as the last thing before you leave
> 'desktop' (or 'home'), and running "git fetch server" on 'home' (or
> 'desktop') as the first thing before you start working on 'home' (or
> 'desktop').
>

I've done a poor job of expressing my need.  I'm only
speaking about the state of each git project directory.
Shared sessions or filesystems are not what I'm loolking
for.

As far as the master branch goes, I have no problem syncing
everything to the server, then pulling to a different
machine.  When I said I want everything to be the same
between the home and work machines, I meant with regard to
all of the other branches.  I want to easily create an
entire movable git environment that is indistinguishable
from machine to machine.

It looks like --mirror is close to what I am looking for.

Thanks
