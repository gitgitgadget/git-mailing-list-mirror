Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 370122089D
	for <e@80x24.org>; Sat, 29 Jul 2017 02:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbdG2CoC (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 22:44:02 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36656 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753112AbdG2CoB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 22:44:01 -0400
Received: by mail-pf0-f196.google.com with SMTP id r63so875815pfb.3
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 19:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=yqRvnrHj2RvGjY/PLsOXxqUgwsBWRNfvIY8RWIyS1Hw=;
        b=svxH+rVwicJXm8TsREr0128HpZYwmOpIcOFZ67Ed6Gk/6gvAoGi0cyj3tNz2BAWaGu
         KxWOZm2EJkZt7zMH3edrHeMvoTiLgVymyrA+tWP2D1u5prZVwQ1LmlBH6tPItJMXfi0R
         6uAv4AvC1euUoGy7ptcBsoKHejr6vqSYyH2vsx/gkimyVoDafdgwflYuoTu7WS6NItj6
         PFcDDqvru/oam4KMHoxg9xDOk8Cl3SHt32mD/EZpa8WfKIoZrIrALJk0/BwQLdH18aCA
         vqqbuoub3cAv4Frx9Grqfepa5ux1sFa4nDgTZwcwIG37C4DMCIC9WdIaeChzzq5kRkXV
         AGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=yqRvnrHj2RvGjY/PLsOXxqUgwsBWRNfvIY8RWIyS1Hw=;
        b=tGyCoRbfM5ZH0dMhPnJALqyojJNSrjnZr+Z+R85hPOx4li0JNKZgJ3izs8jisfbrQh
         f4sEsv5mZ6y4cdC5xaf8YTookc32lM56tNSp2xv67EJAsqKXgU/HZNtKbhPPnZ5phe0q
         nW2ocMeYbrsnZ3dHkv3E3+XssHnpb9142fvCvT5e+tX8LQoQDkW/I7IIqqqDGRh80AQv
         ZXxbsgfww7RzXTHGLwPGXHuyqVkbmPncYu/HHnJ6ct6lND1A26DaHZ6EmWQcNHS5sVRj
         3ez4oRq3z+veM81/Y0oyhtWTXIeUfHOn9JD00lkmtQiAU/s2uEyoW4sKmoUcOpgXzwvh
         mcXg==
X-Gm-Message-State: AIVw113ROfWlUp/jQj6RyEMwexVEp7burkitTDOFjtZ0EJVLxusvp3ig
        5eVtoSife54GzQ==
X-Received: by 10.84.216.2 with SMTP id m2mr9734761pli.219.1501296241296;
        Fri, 28 Jul 2017 19:44:01 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id p22sm47064189pfd.71.2017.07.28.19.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Jul 2017 19:44:00 -0700 (PDT)
Message-ID: <1501296270.2112.2.camel@gmail.com>
Subject: Re: [PATCH/RFC] setup: update error message to be more meaningful
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqqlgnbq7sc.fsf@gitster.mtv.corp.google.com>
References: <0102015d7ae53b0a-a6505296-9257-4b0d-84d6-2152e17eb070-000000@eu-west-1.amazonses.com>
         <20170725212110.GG13924@aiede.mtv.corp.google.com>
         <xmqqlgnbq7sc.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 29 Jul 2017 08:14:30 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-07-26 at 13:09 -0700, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > For an initial guess: in the example
> > 
> > 	git grep test -n
> > 
> > ...
> >  2. Focus on "argument" instead of "filename" so that the message
> >     could still apply: something like
> > 
> > 	fatal: option '-n' must come before non-option arguments
> 
> I think this one is the most sensible.  There may or may not be a
> file called "test" in the working tree, and the user may or may not
> meant to look for a pattern "test".  What is wrong in the sample
> command line is that "test" is not a dashed option and yet it has a
> dashed option "-n" after it, and your version clearly explains it.
Though the message seems to be most fitting one, I'm a little reluctant
to use it as it "might" create a wrong picture on the minds of the user
making them think this would be the case in other cases too, which we
know is not true. For example,


    git log -p --full-diff master --stat

    git commit -v Makefile --amend


The above are valid commands and produce expected result even though
the 'option argument' comes after the 'non-option' argument. Thus, I
thought a "general statement" like the one above might create a wrong
picture on the minds of user. Any thoughts about how to overcome this?

-- 
Kaartic
