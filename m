Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93F9D20133
	for <e@80x24.org>; Mon,  6 Mar 2017 16:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754568AbdCFQlh (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 11:41:37 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36009 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754516AbdCFQlg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 11:41:36 -0500
Received: by mail-pf0-f176.google.com with SMTP id o126so15309417pfb.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 08:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iMhTav4pguiU9EYlPVzkZfhe73xsOy79bWZAzCPX61A=;
        b=OqIEvxXNzt7rJxH2/fWdxubceEAxlsGFKavkuccgVPcxljZoNLgyxBuhoY75RHIakL
         qDpULF7JG4wh+MK5rdUXHn6eQ2VUBTN2FtO/B1DwIgK6xXqnf6zlyc6H8wQBMO5aEDUB
         SSbQPzAmN87bVl0352OIc1xA+WZsJkcWE5eLTJxAO2FIKNnK2WYtB7q+ct88ysKj/JKA
         gmNMXmxifKnsH0QQKxK4i4W7pziqSoSuXtZTH7x8YmvKSiaeR9KrAAAZKVSuVWnZa8hs
         2orz3UdJQzT5aX2UPanUtiM6NRyrsDsSihlnLgn0WBLyPYCPaEpJc8SPuRTMU6NRAag6
         yirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iMhTav4pguiU9EYlPVzkZfhe73xsOy79bWZAzCPX61A=;
        b=h9mPETIC2tqG6CQlRDe0Wyft9W2R0oypkSxd9dAoTcsc53vEkf8upSVloiYuzRuz2o
         R87ISzgSZhje0W1syvtCU+H8tXpXDbwi5FF2DnFOBgs3FYadzjpsFYU3ft3ZkqKe45ww
         cmwE5IPnus8j3lk5m7tBVzl0Qi/RaDvBd3+K9Wu4mQKiNHJsAKPJGQ3VuYpJBj8bEIOS
         HkYhyJYjQ3JO+qmty68cBAjy3L9gJ0rfQUk9z6ApLKNK+yY8zwfWYSGK8RlAcCD7gzs4
         x4oYoUifMt1ViBvQ4zwsVp9aUM0/G0qTLG/JEUTSU/BheLBT8leOYmy1FrNgJSSeVfUe
         JvHw==
X-Gm-Message-State: AMke39mh3yN+36JDESzsrCuz2PEjO51RbJRLBrCjIMIhMyIjcfUbz1neXPMsW+5h5kCKdS1pTigT3MuNd/PBChfI
X-Received: by 10.84.128.74 with SMTP id 68mr28135239pla.111.1488818446733;
 Mon, 06 Mar 2017 08:40:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 6 Mar 2017 08:40:46 -0800 (PST)
In-Reply-To: <1488636950.25023.2@smtp.yandex.ru>
References: <1488636950.25023.2@smtp.yandex.ru>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 6 Mar 2017 08:40:46 -0800
Message-ID: <CAGZ79kZbc394rmxYDUxCbysKNbEQCB7aLJkf6MGcCeXKAxiKhA@mail.gmail.com>
Subject: Re: git init --separate-git-dir does not update symbolic .git links
 for submodules
To:     Valery Tolstov <me@vtolstov.org>
Cc:     sven@cs-ware.de, "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 4, 2017 at 6:15 AM, Valery Tolstov <me@vtolstov.org> wrote:
> Looking for microproject ideas for GSoC.
> Would this issue be suitable as the microproject?

It would be a good project, but not as 'micro' I would assume. ;)
Why it is not a micro project:

To fix this issue we'd want to fix the .git link files recursively, i.e.
nested submodules would also need fixing. And to recurse into
submodules we normally spawn a child process.

So maybe the plan is as follow:
1) Add the functionality to builtin/submodule--helper.c
    it fixes just one submodule, given by name.
2) add an externally visible command in the same file
  See e.g. module_name (the function and the table
  at the very end of the file)
  (1) needs to call this command (see clone_submodule() in
    that file how to call further commands)

2) "git init --separate-git-dir ../test" would call the function
  in (1), which then recursively uses (2) to call (1) in nested
  submodules.

After thinking about it, it may be good for a micro project,
as it is smaller than originally assumed.
Specifically if you plan to look into submodules later on.

Thanks,
Stefan
