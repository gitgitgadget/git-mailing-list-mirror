Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D9F21FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 01:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755551AbdDRBQF (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 21:16:05 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35258 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753721AbdDRBQE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 21:16:04 -0400
Received: by mail-lf0-f47.google.com with SMTP id 75so73030347lfs.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 18:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rVbYxi/3Ene1FE1cpCPLXttXuYs5nQ9MEt8Ay2zrWa0=;
        b=SYdS6l6b9q7c06J+sQ8Yf7xyZ/4F9A3Mf2EgE/+BzP0vyvRZTVTe39P26fYAYpT944
         bvCDlE8eCoL3rx8h4sB/KLICq5ACVkE0XAxen/B0Sg3f9/DtwwhC5uLGo5xgmCigAlqg
         eWy/EQsVw8qEAtnpk5YK8CQiN8D3SzqCgrCICJG7HKdpa/RJ4JqWE6CvSHvIN95vxzh4
         MX7gnkdzCmNBOkN21wLAFe0RBsCNfhht/IeRvVlM7YfQKdNQxaw5795l/u141WCxzvDh
         qvlvBy3YJIhsATJqaDs63cDBmsxJHwjGLhLAQISO8aNYN1rMkzrFKS3ijWizyVkdbtFJ
         Q1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rVbYxi/3Ene1FE1cpCPLXttXuYs5nQ9MEt8Ay2zrWa0=;
        b=FwIjDiXOqm5DnLLC001JBG7NkGpmbVv/hKwodYmHknNJoiDt9yARl6dpU+zJ4MCJDt
         KazDxYEQiA3gQDhvZq6z0dsTr1yzkBOviWIdRICNFOGN1bN8TpgTYll9rPg5iivIodDY
         ASQ+X0K72ZTzizLdRUho7RXCqK0LbZ+jQU34nF3PUr2EyWnq5dy8ogFln64FkLVOKM5v
         9+pkGmAoOmCXForqWHReuFNVGn49r6LId1FQeiULU/ZsI9CzyQ4sECLR5eW+mMNjVCZ1
         QcIwRpYqAikO/YikgLKMbpOaIFbt2jFSOCcvrqwgBjFloDtvrj4D0jYPG16/SrhKDeGe
         Tmow==
X-Gm-Message-State: AN3rC/6MQam7OKYYkRgJbfrFsqDaZfC9lm/lU/tVgJOi/4uWJIWLLgfm
        0sbCLh0d18Xt9YrqSrxc/nX2PF7KUQ==
X-Received: by 10.25.162.211 with SMTP id l202mr2710224lfe.147.1492478162701;
 Mon, 17 Apr 2017 18:16:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Mon, 17 Apr 2017 18:15:42 -0700 (PDT)
In-Reply-To: <ygfefwqzph7.fsf@tehran.isnogud.escape.de>
References: <ygfpogbb711.fsf@tehran.isnogud.escape.de> <f456df1f-cda2-4681-8f01-b693655e79a7@gmail.com>
 <ygfefwqzph7.fsf@tehran.isnogud.escape.de>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 17 Apr 2017 18:15:42 -0700
Message-ID: <CA+P7+xpWMdoQj5FxkN=7QKc3UvW77HsTDs5RRZiCg4WVnB4wqA@mail.gmail.com>
Subject: Re: How to keep log history when renaming and changing simultaneously
To:     Urs Thuermann <urs@isnogud.escape.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2017 at 2:36 PM, Urs Thuermann <urs@isnogud.escape.de> wrote:
> Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
>
>> For both cases (renaming and splitting), would using `--find-copies`
>> work for you? Perhaps with some low threshold value to start with, if
>> the default one yields no results.
>>
>> If interested, adding `--name-status` to the mix will show similarity
>> percentage between old and new file(s).
>
> I didn't know --find-copies and --name-status and I've now looked them
> up in the doc.  Looks interesting but instead of looking for
> similarity it would be better IMHO if there was a command "git cp" and
> that "git mv" and "git cp" were recorded in the history somehow.
>
> I'm still using CVS (and SVN in some few cases) but considering
> changing to git.  There are some things, however, that I can do more
> easily in CVS (like editing CVS ,v files instead of git commit
> --amend) and I need to learn more git before I want to change (and
> migrate existing repos).
>
> urs

Unfortunately I don't have a ready link to the message, but there is a
very good post from early on in Git's development where Linus explains
why Git does not store rename and copy information in the history.

Essentially, it's because that information can be regenerated from the
blobs later, and you can get better information with better algorithms
and you don't bake the original implementation into the history
forever.

Thanks,
Jake
