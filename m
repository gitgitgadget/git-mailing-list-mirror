Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 505F51F453
	for <e@80x24.org>; Fri,  5 Oct 2018 06:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJENRY (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 09:17:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44692 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeJENRY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 09:17:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id 63-v6so12238162wra.11
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 23:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=XYaSnthe9RytMTRv/xIy4Mn7QSlDPjxNqqdMIAyDu8s=;
        b=o8pUDpdg9ryhEybW8MBSrQlssovDlhU6CGVHRovXYQSxRC93raokigKeF+zf4HH+2o
         lcF4w5PQAc6NgFZIlmAaQeJrObCoeKYdRM3D9L4xvl51soTpos3u3mZc7zejRoqNBc9O
         vvoyPRofnCFD3RHSGRGK0vc2+bO0gFmPZXb7PvS1ypT35dK/dVSSrtu9x3/PkVc7OfNU
         uiZiF3NHfptDgRGE9OenjAmUucg8RhfWoOrgSMdS6Ac3Ylk7AdHSdpcXk/grnoeCrPtl
         iW5QQyeWclW406PujLvKmwAvCvuozHRGmivr6jx02EEO/55KJRjNsus666z7KmXgrA0G
         kGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=XYaSnthe9RytMTRv/xIy4Mn7QSlDPjxNqqdMIAyDu8s=;
        b=DB+OWI15koD3jfhN+aTC5KZ8KWz1tGDoRTz1wSaRfHRqd+v6hu7x33Chb3bpjAjRQh
         FX+RUpgI4Puik41QtGbWDGj+eF93rZEHsAKv9D8hmYJ9DKHPPfnvKdH2S4S88lolrPwi
         BnT6QxWUNsdFL1RpmxQyaewsK92TluuSYb5dtCwvfx3nlNIF+6H8Dk/TNcyFaCi4sI/v
         nuB3FSJEnpYZBEf0dJLz+PWAozH2wl4+rlMGx775JYI86oG/sJQozEDa/TBCCZbUHc+v
         EesAqV96+HB3QQ/EARwcE85ta4WfMNKgONAVSUZncjVSxWOWPyExF0XZ2yzCUitNMFjy
         sCWQ==
X-Gm-Message-State: ABuFfojhkhi2TeX4d/phbRzSJzrJ+nVTBn/DPxglUSc7p8B7Nzxc03vU
        40cZtuSBcCk0r1NK9XiKEg4=
X-Google-Smtp-Source: ACcGV60MS567v3A/HXgTEttEuOj/WLctep8xxcg5n9UioR702nmgegI+TXZVn+Ma7cNNpymS1HOgNA==
X-Received: by 2002:adf:9b12:: with SMTP id b18-v6mr1007650wrc.35.1538720409689;
        Thu, 04 Oct 2018 23:20:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w72-v6sm12298096wrc.52.2018.10.04.23.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 23:20:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mihir Mehta <mihir@cs.utexas.edu>
Cc:     git@vger.kernel.org, sunshine@sunshineco.us
Subject: Re: [PATCH] doc: fix a typo and clarify a sentence
References: <20181003210824.24634-1-mihir@cs.utexas.edu>
Date:   Thu, 04 Oct 2018 23:20:07 -0700
Message-ID: <xmqqwoqw29uw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mihir Mehta <mihir@cs.utexas.edu> writes:

> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index b180f1fa5..6173f569e 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -72,8 +72,9 @@ two blob objects, or changes between two files on disk.
>  	This form is to view the changes on the branch containing
>  	and up to the second <commit>, starting at a common ancestor
>  	of both <commit>.  "git diff A\...B" is equivalent to
> -	"git diff $(git-merge-base A B) B".  You can omit any one
> -	of <commit>, which has the same effect as using HEAD instead.
> +	"git diff $(git merge-base A B) B".  You can omit any one

"git merge-base" is a more modern way to spell "git-merge-base" and
we have been trying to update the mention of the latter in the docs
to the former.  Thanks for doing this.

> +	of the two instances of <commit>, which has the same effect as

The paragraph is about <commit>...<commit> three-dot notation.  I
suspect that you wanted to say <commit>... and ...<commit> are
allowed, implying that a bare ... is not allowed and does not mean
the same thing as what HEAD...HEAD means.  But that is not the case.
Asking "git diff HEAD...HEAD" by omitting both may not give very
interesting output (it always becomes a no-op), but nevertheless it
is a valid thing to ask (iow "git diff $commit1...$commit2" is what
you can safely write without having to worry about one or both going
empty string).  So I'd rather not to see this change in this form.
It is an incomplete attempt to discourage use of <empty>...<empty>
but without giving enough justification.

	Side note.  I am not recommending to do so, but
	"discouragement with enough justification" would look like
	this.

	You can omit <commit> on any side of the three dots, which
	has the same effect as using HEAD instead.  Omitting both
	and leaving only three dots is not an error but that merely
	specifies a set of commits that are and are not reachable
	from HEAD at the same time, which by definition is an empty
	set, hence it is not very useful.

> +	using HEAD in its place.

> +++ b/Documentation/howto/update-hook-example.txt
> @@ -80,7 +80,7 @@ case "$1" in
>        info "The branch '$1' is new..."
>      else
>        # updating -- make sure it is a fast-forward
> -      mb=$(git-merge-base "$2" "$3")
> +      mb=$(git merge-base "$2" "$3")

I strongly suspect that inside update-hook, the original still
should work (iow, $GIT_EXEC_PATH should already have been prepended
to $PATH before a hoook is called).  But the updated form should
also work, and it is the form we humans need to type, so let's take
this change.

Thanks.

>        case "$mb,$2" in
>          "$2,$mb") info "Update is fast-forward" ;;
>  	*)	  noff=y; info "This is not a fast-forward update.";;
