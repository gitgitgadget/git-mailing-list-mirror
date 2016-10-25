Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B4B2022A
	for <e@80x24.org>; Tue, 25 Oct 2016 08:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758501AbcJYIw4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 04:52:56 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36724 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbcJYIwb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 04:52:31 -0400
Received: by mail-oi0-f46.google.com with SMTP id m72so85689859oik.3
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 01:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r5ABwDZHlBvYgJw7cA3uZZyL/wF0/+eosl4nGGCtqjA=;
        b=Y0kfAK30sY1omGX193vJEihNLCl8gBWiM4RbAr9ZN0ept5+JLDgUg4caFqS3X/Okwo
         iuOqipQmAm7g/JgLPjQrQ5UtADvxcOv6Zozgs+CwlkY/0CjABjb2N/awfqA8FuWbAYEq
         AjgM3YcW2VTNBvaTok8mXVU7jta/1E8l0w6hvNXAYf1Zzk538HNgcz3cTYOY1vLdKbIN
         zSeF6vvRCFBH1er6yMOq6vzosEXP6zxTCOT2vb0VvwZ3JsUPw9WImVIVLliukSy4FFPs
         IPUTSxJtB08Jg7o4bKI7FwTwN/NpmpkNqOehVrXXb3UTwPQbp55TV/HURjdknfPd7SFm
         cS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r5ABwDZHlBvYgJw7cA3uZZyL/wF0/+eosl4nGGCtqjA=;
        b=mLHxgZoBJqq4F2c+yn7/3fSXUWvotZYpSppdoPJjA3eWdOwbtuG5Ufey+EUamPYzT5
         TqC2Zk55r2Ygek19yVMK1bDJsOhl4nqXk/xzWv9YCwbsYJ+Ty/WwFV+w5oj1sdttRxc5
         P7vbKuTUKO3U7lfJSMY5dfsJtexK06s5J0JUpPgfeWPUX4BUtrNOizPOXhtNBUM5f+ly
         AthA4+Ig9V5ms3B8YehdSO/NzC37yevIqnuIZZ5ulxCT+dam+WgxP2WpyTiAEWUh7C/F
         zFtPA2OXSGDB1Fay09AJYBTZLqS9cW2Dg0E25By4f9t1mVu4W9Hy9GDiyiirQwkzEbyI
         8ZOw==
X-Gm-Message-State: ABUngvej0ipPOx0vjTOQ90RqaElpqzYH0XQfks9uJyPVSX4fBzSnG4qiTkUbEWcPcu4PahxcE41yaCx1CzO4Gg==
X-Received: by 10.107.167.82 with SMTP id q79mr17212332ioe.120.1477385517777;
 Tue, 25 Oct 2016 01:51:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.38.215 with HTTP; Tue, 25 Oct 2016 01:51:57 -0700 (PDT)
In-Reply-To: <CAN8fUZe4iWJCZYqBBDbNyPq1Dz7f4xvTNRVEZgg5AYN2NrKCbg@mail.gmail.com>
References: <CAN8fUZe4iWJCZYqBBDbNyPq1Dz7f4xvTNRVEZgg5AYN2NrKCbg@mail.gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Tue, 25 Oct 2016 14:21:57 +0530
Message-ID: <CAFZEwPNB1PX_NOaYzKr+rUKvbC9s5A1G58v5aS=sGdzPVsv4ww@mail.gmail.com>
Subject: Re: Reporting Bug in Git Version Control System
To:     Yash Jain <yashjain.lnm@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Yash,

Junio has explained the problem very well. Since you seem to be a
beginner (guessing purely by your email) I will tell you how to fix
it.

Remember when you would have first installed git, you would have done
something like `git config --global user.name <what ever name>` and
`git config --global user.email <what ever email>`, it gets
permanently stored in the git configuration file (~/.gitconfig). Now
all the commits in git are made with this name and email. If you want
to change this, again run the above commands with your new name and
email. After that commits will be done with a different name and
email. Hope this helps! :)

Regards,
Pranit Bauva
