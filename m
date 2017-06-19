Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D027D1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 18:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751105AbdFSSAE (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 14:00:04 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35566 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdFSSAD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 14:00:03 -0400
Received: by mail-pg0-f42.google.com with SMTP id 132so17754177pgb.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=+UfzV3XXlo9eYWMxL6yry2PZArczUVKN0VFAYY+jgL4=;
        b=ABjfER3+hrdQkakVBfWJtn3Tg7IO1nAVj1dg3zCPmGDLWgzssk57uRffw/BF4E1c/d
         qGjBVBQnpT6BMc65Vi6ZK54O1iKYZyCl3a8vHMi2PZ7zTN9671Wyn79a4tMJZt5UerzA
         vfX3si7fe+1wFdK5X7v0YcuVhwTRviTSjZKou+CkXx+e+1CsduzheuxJOAFTc5vxsKYa
         rGA297SspNyzSVdXJg4HdQaCvlYj6lBZIke+0VpBDtvug3/X1psnJybYXPt4Azz7F1t3
         YqSixTl9myrTU/V34u5kZ50H77vhnqH4TcZquTQqD21SBhXAAqI4HcrY8+28B31SU2H6
         36jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=+UfzV3XXlo9eYWMxL6yry2PZArczUVKN0VFAYY+jgL4=;
        b=HnBqrHqKwSlD8bN9zgStU/QnDqD+8MAjdc5zN0Y48kYz86Z1iuwcBO2h6j2Ko4+WJN
         DIbJNI8W1Zj1td2PUeTl+5YqsVVm3Vwk00av1uARB7tZKsbBliNeIb3p7U+vDy1wrtjv
         9GO5iAfiatsMKYmvb0DASwBGKYCfZgJtjvtdJ1KCIZKLE5tUJnEge2qQwanh7Id5g8L0
         7zs0eymTdaNrCT03GUKi6YYjDvbqkmEy/7KVEeWAhJZVkp0vy4EQVAAvzF2WxWkZwiQV
         idlcNU3UjAzvZAcCxn5uyJGA2SpQ7Jownrb5gJHR6H7PJLKFCD6Yn44DgcnHekHXFq+i
         QqTA==
X-Gm-Message-State: AKS2vOxF782bqmO+XHtulqdxF17+iim76H5TN+PIArY/v886NIwltCIf
        dqYTMi16rvtFEg==
X-Received: by 10.84.214.22 with SMTP id h22mr2393469pli.127.1497895203187;
        Mon, 19 Jun 2017 11:00:03 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id p21sm19927401pgn.12.2017.06.19.11.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 11:00:02 -0700 (PDT)
Message-ID: <1497895189.18850.9.camel@gmail.com>
Subject: Re: [PATCH 2/2] Add test for the new status message
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     avarab@gmail.com, peff@peff.net, git@vger.kernel.org
Date:   Mon, 19 Jun 2017 23:29:49 +0530
In-Reply-To: <xmqqh8zcvbq8.fsf@gitster.mtv.corp.google.com>
References: <20170619024123.5438-1-kaarticsivaraam91196@gmail.com>
         <20170619024412.5861-1-kaarticsivaraam91196@gmail.com>
         <xmqqh8zcvbq8.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-06-18 at 21:32 -0700, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> 
> > +test_expect_success 'No commits yet should be noted in status
> > output' '
> > +       git init initial &&
> > +       cd initial &&
> > +       git status >output &&
> > +       test_i18ngrep "No commits yet" output &&
> > +       test_commit initial &&
> > +       git status >output &&
> > +       test_i18ngrep ! "No commits yet" output &&
> > +       test_i18ngrep "nothing.*to commit" output
> > +'
> > +
> 
> Do not "cd" in a test, without being in a subshell.  When other
> people in the future want to add new tests to the end of this
> script, the new test will end up running in the new subdirectory,
> which is not something they should have to worry about.
> 
> 	git checkout --orphan empty-branch &&
> 	git status >output &&
> 	test_i18ngrep "No commits yet" output &&
> 	...
> 
> perhaps?
> 
> 
>  test_done
Fixed it. I wasn't aware of the guide lines for writing tests when I
used the patch from the thread blindly. I'll be careful to avoid that
in future.

Is there a way to test for the "Initial commit" message in the commit
template?

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
