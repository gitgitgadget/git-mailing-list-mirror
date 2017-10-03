Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 573702036B
	for <e@80x24.org>; Tue,  3 Oct 2017 15:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbdJCPAE (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 11:00:04 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:47840 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdJCPAC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 11:00:02 -0400
Received: by mail-qt0-f180.google.com with SMTP id z50so8443024qtj.4
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=ZPo5q9Q7npw5dSODBnLteY9IcyBXq4uAT1X82/ve9yc=;
        b=s8UrJxk7lktbR3CEjv0JL8cLH7JtfqpIj+WbdFt6DgtK1F2/TYFyp5lhT6LM2UEsqW
         6PVQYUC645fxJfEBN8JW8e+wwCVM9OTGjoMKvdeUVffijU8gDKh6kWl96PLbf07HwOvp
         HrRxi8lNEJw8DZCRp40+MxXIrgNVwvzooSA/kx5ra94R/KqVhqM8uWSsy8kGfxIPf6Kj
         Qac54BEho21WcdpUehUd7Y5zjwVZai7VMU04jTUt/86sohiM5F7yIZYYY9yLtXxUgBUF
         aUncUtMSEDxgXQ+OP6kYFwHzBLqwRLar5FttkXY/Ek/cy0kLvdTe73QJFJs4gqP1O75j
         EJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=ZPo5q9Q7npw5dSODBnLteY9IcyBXq4uAT1X82/ve9yc=;
        b=XdQNjqc+wF9c1thoBwBX8am/enFa19mwUn4tj+IjVp3yHrmxO66J8qqYUaAppKYZK+
         bvrt7sEfKVf7ytHmwhgqUGsDtmgqKw04jYptWtU/0hh/lievV/7pKmSnh32ltzsk4Z5n
         lqWc1jGMVhDgoPAypR5q/K1vQD3aQ+L0IbfGERRwoBQGqoKlJpzqqD4ZJ7e3P+Eht8UD
         OVQRXY4VBMuGh7ByoJks7wbZngtkmndFEqqJhRnCI1Mm6TSOvRCLd3WedJ+BbIRrNNm2
         ESow+lF9DTXIsKdk9DMiPxLXxEM0bW7W2SdSi0AeIprYR/ATIV/ip2EdX2klJmESR8Ci
         oXew==
X-Gm-Message-State: AHPjjUgUKL5fCq4H7/XLpC6/k7MrVmqpPjTvWQWQYNu9qtT8xuITemDn
        G+k3BTuV7OXrwk9zsab84z8bi3JNo4s2ldvLH2SQINyr
X-Google-Smtp-Source: AOwi7QAsb2paW7lxetzgpW/EtBIjlMrU4vhWEailX6OL8QYSwaoYhsxm68ESm5Z0LqpKL5e4tMnU0Qeu8szrFTxQr4g=
X-Received: by 10.13.249.3 with SMTP id j3mr16882552ywf.446.1507042801807;
 Tue, 03 Oct 2017 08:00:01 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.129.40.214 with HTTP; Tue, 3 Oct 2017 08:00:01 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 3 Oct 2017 10:00:01 -0500
X-Google-Sender-Auth: dwq80zfZMjF_YT7a2xiJG_sVQRw
Message-ID: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
Subject: Line ending normalization doesn't work as expected
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm on Windows using Git for Windows v2.13.1. Following github's
recommended process for fixing line endings after adding a
`.gitattributes` file[1], I run the following:

$ rm .git/index && git reset

Once I run `git status`, I see that no files have changed. Note that I
know for a fact in my repository, files were committed using CRLF line
endings (the files in question are C# code files, and no
.gitattributes was present at the time).

I also tried this:

$ git rm -r --cached . && git reset --hard

However, again `git status` shows no working copy modifications. The
one thing that *did* work (and I tried this on accident actually) is:

$ git rm -r --cached . && git add .

This properly showed all files in my index with line ending
modifications (I ran `git diff --cached -R` to be sure; the output
shows `^M` at the end of each line in the diff in this case). Note
that my global git config has `core.autocrlf` set to `false`, but I
also tried the top 2 commands above with it set to `true` but it made
no difference.

So my question is: Why do the top 2 commands not work, but the third
one does? To me this all feels like magic / nondeterministic, so I'm
hoping someone here knows what is going on and can explain the logic
of it. Also if this is a git config issue, I'm not sure what it could
be. Note my `.gitattributes` just has this in it:

* text=auto

Thanks in advance.


[1]: https://help.github.com/articles/dealing-with-line-endings/
