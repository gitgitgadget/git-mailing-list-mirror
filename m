Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75FD41F858
	for <e@80x24.org>; Thu, 28 Jul 2016 16:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbcG1Q5Z (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:57:25 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37132 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932581AbcG1Q5X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2016 12:57:23 -0400
Received: by mail-wm0-f44.google.com with SMTP id i5so117168746wmg.0
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 09:57:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1MDNi2lPHhviFouWe+8obgAS5/vgs3zVcgIFpXIOFM4=;
        b=jVdUqqCcxkNLhmB0DGBeyCyuCRU7qNaiySU2UVWL4xy9dsubN67vksgYgMbK0VrQcZ
         wHVRAhGzXqTZYLfjH/JXrOkNSX26AmbEmYCd+FjA0iehRmP/K5T0uxLoaEUoAjh2JkoQ
         NVQWdnd2+JZflMGfrPi9xGErNUESWs+UHbn9nkizllMocga9nBLqOtQhrQXZKj/E5yzq
         qWlxxfQfxClI3AcS1wQeEYFdRpJXEYUsurYBxolZd8/EUAGl1hZBXlWu0tIWcCyNJlTk
         eMLsSeeQK3XEyrAxZRmqSTmyB+pmLtm+rOZkCEb20C7Byx8M8J/kldfWGpdMrdcNJlDL
         WP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1MDNi2lPHhviFouWe+8obgAS5/vgs3zVcgIFpXIOFM4=;
        b=FevebTUVDZrovnkbgVjv3qLww40wplKMlLUfj+uIjl6V5KvVc95NefFE8A19/jNrpv
         ZgUmnJU8D7DalGZrwbKG2BaQpNIXBFHJBGDdPwofUce1lYl8cBDXr0sTDl5mkDU0vIGb
         eNRvIICZF2fayovEFHQ7zqqZ29UiPHwDVvINvawjzyBCf2OSGNkQIZOyJVU0ripHKKQv
         DwZjWMD/sbSK+0ItAGO1be3kLEPxxdWCTeSPuqEcpQbBGpz5x0UIpk0wb0FTwpoNZWbA
         63QTp/+68QFPJLAllC3Q5RVJbBvpIe2X1BCaxow0KjmxAWMrDsGUknKV2IToCOgsIelx
         qmpw==
X-Gm-Message-State: AEkoouvfuVrFQRh/o0w0NT4SA5d5mgTuB3iFIyVNtoboFGHddSxNXLTMXEGLnaeXv1f7P88QrH5lYIVFsqYH4A==
X-Received: by 10.194.143.17 with SMTP id sa17mr32163875wjb.97.1469725042347;
 Thu, 28 Jul 2016 09:57:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.130.74 with HTTP; Thu, 28 Jul 2016 09:56:52 -0700 (PDT)
In-Reply-To: <xmqqlh0lsoq6.fsf@gitster.mtv.corp.google.com>
References: <CAA787r=FH7Sa4qy2A-dy+wug81ZkqOW2KmSuWBE8_3whmNj1pw@mail.gmail.com>
 <xmqqlh0lsoq6.fsf@gitster.mtv.corp.google.com>
From:	=?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Date:	Thu, 28 Jul 2016 18:56:52 +0200
X-Google-Sender-Auth: qJG1QwCIewh0BgXUx1o0Y1uEGwc
Message-ID: <CAA787rmDb+1=4RCscvo1rZWSt=tUQSm5wrFet-=PhRKZcf9x5A@mail.gmail.com>
Subject: Re: git-testadd: Execute a command with only the staged changes in
 Git applied
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 28 July 2016 at 18:37, Junio C Hamano <gitster@pobox.com> wrote:
> Øyvind A. Holm <sunny@sunbase.org> writes:
> > This is a script I created some weeks ago, and I've found it to be
> > immensely useful. Here is a snippet from git-testadd --help:
> >
> >   If you have lots of unrelated uncommitted changes in the current
> >   repository and want to split up the commit, how can you easily
> >   check if the changes passes the test suite? With all the other
> >   unrelated changes it can be hard to make sure that only relevant
> >   changes becomes part of the commit, and that they don't result in
> >   regressions. This script clones the repository to the directory
> >   ".testadd.tmp" in the current directory and applies the staged
> >   chenges there (unless -u/--unmodified or -p/--pristine is
> >   specified), chdirs to the same relative directory in the clone and
> >   executes the command specified on the command line there.
>
> So in short, this solves the same problem as "git stash --keep" but in
> a more scalable way, in the sense that "git stash --keep" allows you
> to instantiate what you have in the index so that your working tree
> can be used for such a test, but you cannot do anything else while you
> are waiting for the test to finish, and "testadd" allows you to keep
> hacking in the working tree while a test runs in its own temporary
> checkout (and presumably you can have more than one running, which
> would allow you to scale more)?

That's correct, the test clone is entirely separated from the working
copy, and you can keep working while the tests are running in the clone.
Combined with git-gui and/or "git add -p/git reset -p", it's easy to
tweak the staged changes until things are ok.

Also, there is a -l/--label option that creates a clone directory with
the name ".testadd-[LABEL].tmp", so you can have several test clones at
the same time, all with different staged changes. There is also a
-r/--ref option that tries to apply the staged changes onto another
commit, and the command will only run if the apply succeeds. Also, this
won't create dangling heads like "git stash --keep" does.

        Øyvind
