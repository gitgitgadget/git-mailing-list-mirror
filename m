Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5221F404
	for <e@80x24.org>; Mon, 17 Sep 2018 23:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbeIREs0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 00:48:26 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36700 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbeIREs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 00:48:26 -0400
Received: by mail-it0-f66.google.com with SMTP id u13-v6so653780iti.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 16:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vIq1YzHGPXGcRiNP6oso+tz9mq3/7Bb9+Yn/UW3EaGQ=;
        b=tOH/9kfIdQMigTvjTfyIv+qbfw3h7fm4KX64DqObbky4pLg1LFnvSNfRdHAWebdVF7
         LTYfjptpNgRJsvdKdqSXGQZLCJtbACBv7cEdaadHS9csOiKSbOa1OazuEob9I6k3sM6C
         q7HEuvcT4jwHxX4Co8BsUsvBpfocFIXnCOXngmYxWVwldKmoCnYKJvuRxSUEwrX1w4OR
         vglctImFIeun20Q+UZ/RxmOJ0G4ldBpw2Waw20pPBPlcSoTLiScUuQiyYxkcCabIQnyF
         wKE05Ph58cAn8K1UNKBuagJsJ4jMkj0sz+jTD5U+FV1CsDfU8Rlh5mFCVrhEReLh0ZgY
         zslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vIq1YzHGPXGcRiNP6oso+tz9mq3/7Bb9+Yn/UW3EaGQ=;
        b=jUdUx2tmJM2j0kRArpPjaRmt5s0ldJvz6pG9/ukok5GE4+ZzUI4dmiv8lrfxf+9rDY
         FdAhFHqCZ1cgMvK6sJfrQRHXyw4bV9mKl+M6bPQewQR8d7CoTplmP/pUu3SirrXTU9GL
         VUR2bYl8FpYi9BIu7ZYQvQgmkI0+4er10DuU7PJ8UjZhP1/7wcCFmNmyeDMJGAEEs/YF
         ZogYpn6jRHOG9PUQzRI8eUsoytSU9sf3aWpXKdNQHSZgp6GiELdRK6xdTDV/EPVemOK+
         mrBAIWe2AGBtT3A6o/h1/3KQ1kbYbkqUk2XUNvYQh8T1GJp+hLqbimtiBwLQjoUrgZz0
         Nnsw==
X-Gm-Message-State: APzg51AxD1Y+J6AsZhyrChZvb1Plo3JalnQpFNTkIE7p2uE3jgUzdTqR
        KObTUpGU3wzxZm68vhmgrxoPjA==
X-Google-Smtp-Source: ANB0VdaNY8LGJPex+3C1mfixUHYcbbc2OjOsPJR6P+YwA+ZLCJvJCTPTTpGtex0KDJUtKcW4J4P7KA==
X-Received: by 2002:a02:2505:: with SMTP id g5-v6mr24579983jag.112.1537226332764;
        Mon, 17 Sep 2018 16:18:52 -0700 (PDT)
Received: from localhost ([173.225.52.218])
        by smtp.gmail.com with ESMTPSA id z2-v6sm5078076iom.25.2018.09.17.16.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 16:18:51 -0700 (PDT)
Date:   Mon, 17 Sep 2018 19:18:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Add an EditorConfig file
Message-ID: <20180917231850.GB81083@syl>
References: <20180917230307.588334-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917230307.588334-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

Thanks for CC-ing me on this.

I use editorconfig every day via the configuration in my home directory
[1], and the Vim plugin editorconfig-vim [2]. It's a great piece of
software, and I've been using it without any issue since around the
beginning of 2015.

On Mon, Sep 17, 2018 at 11:03:07PM +0000, brian m. carlson wrote:
> Regardless, providing such a file allows users to automatically
> configure their editor of choice with the correct settings by default.

I think that this is the central argument to be made here for keeping
this out of contrib/, and in the root tree. Most editor (all?) plugins
will pick this location up automatically, which ought to cut down on
patches that aren't formatted correctly.

> Provide global settings to set the character set to UTF-8 and insert a
> final newline into files.  Provide language-specific settings for C,
> Shell, Perl, and Python files according to what CodingGuidelines already
> specifies.  Since the indentation of other files varies, especially
> certain AsciiDoc files, don't provide any settings for them until a
> clear consensus forward emerges.
>
> Don't specify an end of line type.  While the Git community uses
> Unix-style line endings in the repository, some Windows users may use
> Git's auto-conversion support and forcing Unix-style line endings might
> cause problems for those users.

Good. Even the official editorconfig documentation specifies that this
ought to be the responsibility "of the VCS" [3], a point on which I
agree.

> +[*.{c,h,sh,perl}]
> +indent_style = tab
> +tab_width = 8

In all *.[ch] files in git.git, I found a total of 817 lines over 79
characters wide:

  $ for file in $(git ls-files '**/*.[ch]'); do
      awk 'length > 79' $f;
    done | wc -l

So I think that specifying indent_style, and tab_width to be 'tab' and
'8' respectively is enough. We shouldn't be enforcing a rule about line
lengths that we are not ourselves consistently following.

Have you thought about including guidelines on COMMIT_EDITMSG? We prefer
72 characters per line [3], and this is enforceable via the following:

  [COMMIT_EDITMSG]
  max_line_length = 72

Thanks,
Taylor

[1]: https://github.com/ttaylorr/dotfiles/blob/work-gh/editorconfig/.editorconfig
[2]: https://github.com/editorconfig/editorconfig-vim
[3]: http://public-inbox.org/git/20170930070127.xvtn7dfyuoh26mhp@sigill.intra.peff.net
