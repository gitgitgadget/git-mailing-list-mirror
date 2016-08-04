Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D431520193
	for <e@80x24.org>; Thu,  4 Aug 2016 14:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009AbcHDOAZ (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 10:00:25 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37919 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933865AbcHDOAW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 10:00:22 -0400
Received: by mail-wm0-f46.google.com with SMTP id o80so379667281wme.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 07:00:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=w8dgvIkoaJXew1mKqYgx87LjuvZBFw1jBa1MwySRZus=;
        b=SUARqpjrWUFfvCPv7f+apELu4C6mvWOKmqlU6GBBmwC0VYd/BiTvSle10KHeSDqc35
         RZSTG93OmiO0HSyN2ASN45EVu+vkxwtagYppPJjpTqvel/lQgdJ9R8b/tGQAuXjBwDOu
         Rt9HdAnZxWjDHk8HeXnVunVWOqktELonlSzu98jOeknnK4LtyYC13XS3LglIfNPuIF08
         O3qbtjDbnCcDH+XTx6GQz0fRtWd37Tcsd52cjO0AYWc6Ppa5OMjChf6f2hCfSGnBBM0p
         0jiaS20AAeFRhLVPsSZBOTcgRmsQjV7mOnPWaJrxoj3elfk8LxXqI/lViuZ99WKAcxkC
         l+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=w8dgvIkoaJXew1mKqYgx87LjuvZBFw1jBa1MwySRZus=;
        b=A7kqnMSgie0nxBp0lR93tpLFIAuam985fz+MllqUYyuDSj+2eXcHlpfI4ja5awz1HF
         jvAufT2VB0TM1U8Kej/o6nNg9heMmaCwroIKzGNYH/4DnhyTL4iuMi9YyieYUrKwrT3x
         5DQRRidSKrWQEkwj/G9jN/IXhblvTsKJZl/LNojTz6iEXFYst9d1JdEYq86X3W/wTkeP
         AEmuteY0ajWzAOVsekHcJDybwSPz0ggDezUmbZ/qRuLGhGSI54EjuGZAV/kfjflPBLju
         tobLAp2IBbzafrtyHMkGKw9byf61L66Z94J9A3DfI61+LY4/dhmLvxW7uTAM8vy7qtjt
         ZNpg==
X-Gm-Message-State: AEkoous1VwNtoi8o0glplnJuYj9L5J4K48L10G1dl+VfK++991cdA8GvGkhji+bz+nh+Ag==
X-Received: by 10.28.98.135 with SMTP id w129mr70791582wmb.38.1470319221284;
        Thu, 04 Aug 2016 07:00:21 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r13sm3817125wmf.12.2016.08.04.07.00.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Aug 2016 07:00:20 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Aug 2016, #01; Tue, 2)
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160804113256.6idrdzfgolm4ne4o@john.keeping.me.uk>
Date:	Thu, 4 Aug 2016 16:00:19 +0200
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4A2D83B3-916C-4FC8-BBEF-4D55C3204DFA@gmail.com>
References: <xmqqlh0ebyhn.fsf@gitster.mtv.corp.google.com> <4877318E-3CBF-4C87-B24D-AAE35C427D66@gmail.com> <20160804113256.6idrdzfgolm4ne4o@john.keeping.me.uk>
To:	John Keeping <john@keeping.me.uk>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 04 Aug 2016, at 13:32, John Keeping <john@keeping.me.uk> wrote:
> 
> On Thu, Aug 04, 2016 at 10:03:39AM +0200, Lars Schneider wrote:
>> 
>>> 
>>> * jk/push-force-with-lease-creation (2016-07-26) 3 commits
>>> - push: allow pushing new branches with --force-with-lease
>>> - push: add shorthand for --force-with-lease branch creation
>>> - Documentation/git-push: fix placeholder formatting
>>> 
>>> "git push --force-with-lease" already had enough logic to allow
>>> ensuring that such a push results in creation of a ref (i.e. the
>>> receiving end did not have another push from sideways that would be
>>> discarded by our force-pushing), but didn't expose this possibility
>>> to the users.  It does so now.
>>> 
>>> Will merge to 'next'.
>> 
>> t5533-push-cas.sh "16 - new branch already exists" seems to be broken 
>> for OSX on next. Git bisect indicates that "push: add shorthand for 
>> --force-with-lease branch creation" might be the culprit.
>> 
>> https://travis-ci.org/git/git/jobs/149614431
>> https://api.travis-ci.org/jobs/149614431/log.txt?deansi=true (non-JS)
> 
> It seems that the test script has already done "test_commit C", so the
> newly added "test_commit c" does nothing on a case-insensitive
> filesystem.
> 
> Something like this will make the test more consistent with the rest of
> the file:
> 
> diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> index 5f29664..e5bbbd8 100755
> --- a/t/t5533-push-cas.sh
> +++ b/t/t5533-push-cas.sh
> @@ -220,7 +220,7 @@ test_expect_success 'new branch already exists' '
> 	(
> 		cd src &&
> 		git checkout -b branch master &&
> -		test_commit c
> +		test_commit F
> 	) &&
> 	(
> 		cd dst &&

Confirmed. This patch fixes the issue!

Thanks,
Lars
