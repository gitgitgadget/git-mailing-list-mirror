Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 762AF20248
	for <e@80x24.org>; Wed, 27 Mar 2019 22:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfC0WvY (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 18:51:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46628 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfC0WvY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 18:51:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id q1so2457421pgv.13
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 15:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8TXhT+YjRZbXREavXajQDswpLIfh8HGcVSX0sVUHGAE=;
        b=dCmQmdrAXCLJMwpPygZtyr1YBOiRP5JHaP0L+Dmo1s9nB6x2RSnJc5unxTQhCYxJBR
         aZcae0repTeuABH41QBtIoRzO6H3vOLou98/Qe4YGSVybjpo2qDzaRCibzvmOW1d2TTd
         Hrg2pqRK86MwNoAik0eH6bmwCV7XExv0R9etjGb3z0nYtIhqa/gqX2jNx2tzIoDeFFqf
         rvcKmF+T6ZzhniAgSg28yWPDDS+yrlNuNAjAhUpnOnj08pl//plh7fse0yDnyzSrP8Rj
         DVRFCIWZ3O81a36+XoCQXD3Y8BMAXZMvdotTaX5QWku4KDQjNjvdP9kS670Qfz3kcHFK
         AECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8TXhT+YjRZbXREavXajQDswpLIfh8HGcVSX0sVUHGAE=;
        b=cLt154gw4BnCeOarFfKRGzrH/qTZzMK0wu22hM4lRacHAVuW6WhzKqxJCdAg5ZZWOL
         /UYvmNN1tpg76xKQbcmlUwWNH+aIPLrKStjaR2Wp2szvjeQoyYRajuiwV54LICyfBAo5
         pAn/qERqorrPxlxSuWyvrqQ6IhkPYKQ9URCZp/kaajyC5pRzq0DX9Rs+kRdRoYrTQxma
         3mg4iJesoInk4P4aSvWGtgPE3l740FBrJwALv7zkoKQHajfih7W3pWCpO6Z1ay+HYkQo
         mG2RzbKnUaT8OYH2w6pKDksOB8UQxLg2VvxgvyUecGWrccffglzAYdR4f1/kqpVwdgXw
         VHNw==
X-Gm-Message-State: APjAAAUUY0TCSKQ218cud26L9WQWOhkxh64s6dMZpyB/EogNU+S2qbjq
        M6DV7GBMAwYSNeMj8LmylVc=
X-Google-Smtp-Source: APXvYqy1r2xEQd7Ji45HA9XLMmeJ7IMQepMvyC0Dt4cUUWbdRKyEUcswGaovDZJ/YjPJGfE9tG2SMw==
X-Received: by 2002:a63:450f:: with SMTP id s15mr36148781pga.157.1553727083169;
        Wed, 27 Mar 2019 15:51:23 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id g188sm41147308pfc.24.2019.03.27.15.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 15:51:22 -0700 (PDT)
Date:   Wed, 27 Mar 2019 15:51:20 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Julian Cheng <julian.cheng@utoronto.ca>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [GSoC] [t9803]
Message-ID: <20190327225120.GA9277@dev-l>
References: <7BFDFF1D85B3B544BB69BB9AB23D479D01F4534A@arborexcasx3.UTORARBOR.UTORAD.Utoronto.ca>
 <20190327211050.GA4062@dev-l>
 <7BFDFF1D85B3B544BB69BB9AB23D479D01F45370@arborexcasx3.UTORARBOR.UTORAD.Utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7BFDFF1D85B3B544BB69BB9AB23D479D01F45370@arborexcasx3.UTORARBOR.UTORAD.Utoronto.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 10:04:46PM +0000, Julian Cheng wrote:
> Denton, thanks for the pointers!
> 
> I get the following when I run "make" in the top level directory of git and I'm not sure how to deal with it. Any ideas?
> $ make
>     LINK git-http-fetch
> .../lib/libcurl.so: undefined reference to `SSLv2_client_method'
> collect2: error: ld returned 1 exit status
> Makefile:2434: recipe for target 'git-http-fetch' failed
> make: *** [git-http-fetch] Error 1

What OS and/or distro are you currently running? It looks like you
either have some out-of-date libraries or you're entirely missing some
libraries.

> 
> ________________________________________
> From: Denton Liu [liu.denton@gmail.com]
> Sent: March-27-19 5:10 PM
> To: Julian Cheng
> Cc: git@vger.kernel.org
> Subject: Re: [GSoC] [t9803]
> 
> Hi Julian,
> 
> On Wed, Mar 27, 2019 at 07:26:12PM +0000, Julian Cheng wrote:
> > Hello Git Community,
> >
> > I’m new here and hoping to get to be a part of GSOC 2019. I have questions about the main project and the microproject
> >
> > Main Project Quesctions
> > I was hoping to work on “git revert --drop” and “git commit --reword”. Are there any mentors available for this project? The ideas page lists mentors for other projects but not this one.
> >
> > Also, “git revert --drop” and “git commit --reword” appear not to have been discussed yet in the public inbox. Is this correct or am I just not finding the threads?
> >
> >
> > Microproject Questions (test_path_is_*)
> > I would like to improve t9803-git-p4-shell-metachars.sh
> >
> > On the microprojects page, it suggests I should run the tests to make sure they all pass. But if I’m making changes to the tests, is it really adequate testing just to make sure they all pass?
> >
> > To run all tests, I assume I would just navigate to the tests folder in terminal and call “sh *.sh”, but that doesn’t seem to work. Also, when I call “sh  t9803-git-p4-shell-metachars.sh”, I get “error: GIT-BUILD-OPTIONS missing (has Git been built?).” Git is definitely installed on my computer though. I’ve been using it for months. I cloned this repo with Git. What am I missing here?
> 
> When the tests run, they don't test your installation (the git you're
> currently using in /usr/bin/git). They test the git you've built in the
> project directory.
> 
> First of all, you should build the project. You should run "make" from
> the top-level directory of git. This will fill the directory with git-*
> executables. These are the actual binaries that will be tested.
> 
> Next, go into t/ and run "make" again to run all of the tests. You can
> also run individual tests by doing something like
> ./t9803-git-p4-shell-metachars.sh, for example.
> 
> For even more details on testing, see t/README.
> 
> Also, some other helpful documentation to read include:
> 
> * Documentation/SubmittingPatches
> * Documentation/CodingGuidelines
> 
> Hope this helps,
> 
> Denton
> 
> >
> > Best,
> > Julian
