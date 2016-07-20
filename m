Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15435202F3
	for <e@80x24.org>; Wed, 20 Jul 2016 15:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261AbcGTPav (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 11:30:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33030 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227AbcGTPau (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 11:30:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so7555600wme.0
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 08:30:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=lQWO3fVDgGOHj0bfcXIvyRO5g4o4KSkprtinnYNi/f8=;
        b=jdE2nYxxQqLJl2eUMVp6ew0khAbjK3vpwmE/a6PBO7809Rx7xqbl24nZcwkpIQ2jAm
         CNmq9+Da3fWisE6OsGkR18Envik0fuMrHtlewhJJc9UfN98rpOWAT9xaIoDCy7Ablz5j
         aMRmZcPStjTzmbDK6sG31fztNS1B/5OsxOwAiJ6nbtAHeDkRDD/CvcVoO1wR+/gxVK5C
         nk1W+1Ek0DFtnZ4OWAQdSJR66H4Ms2oWJ1cSaevs/xKm7uT/hWvOsv1+v4uLeq6m58g9
         ixZhOQjH1ou5eZEmmTWCMVSnjvzMFs2iRj5e4djggt4DyDqIkXQ+0WJTWMkmIe30+sCh
         mbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=lQWO3fVDgGOHj0bfcXIvyRO5g4o4KSkprtinnYNi/f8=;
        b=LljuJYyrC/fk5ErByMW4WbcsGmKsP3W0g77HbnuChSE7Py1kxq3B5bnxU/RsG+fLDe
         Jn5fpHcJMSqr5wvAYzGClKipuECbzLg209HJ85yBArRCz0tQye8+MlYstcNnnQv+VSmr
         UaFkCsj4WpDDHA6j53SJxHFOlpA2OzT6rP7zuxHQxmCZsJiYOO12bKKUF/Zw6Ht22NcT
         HIgfc+j9tSBBJLhqQxESnBSPLBNBCSFUKB1RAXaHs2J/tVDanrUI/mGaW3x5U4+doDmL
         OGqq1LnZVXPkJku9/K1r9i7HAxKITzXARmruXc93mJkXZY0gcENC+dcPlb8EAf7mPzgF
         NYCQ==
X-Gm-Message-State: ALyK8tIUmlxOhWNkQLPoK/tCfQHyavGfijxBtbl12acfB8iR3J1DtIy9zJxWCXsvoohQXQ==
X-Received: by 10.28.229.19 with SMTP id c19mr13007634wmh.0.1469028649002;
        Wed, 20 Jul 2016 08:30:49 -0700 (PDT)
Received: from [192.168.1.26] (daf247.neoplus.adsl.tpnet.pl. [83.23.5.247])
        by smtp.googlemail.com with ESMTPSA id f3sm1813717wjt.30.2016.07.20.08.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2016 08:30:47 -0700 (PDT)
Subject: Re: [PATCH v1 6/6] Unit tests for V2 porcelain status
To:	Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-7-git-send-email-jeffhost@microsoft.com>
Cc:	peff@peff.net, gitster@pobox.com
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <578F9923.3000403@gmail.com>
Date:	Wed, 20 Jul 2016 17:30:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <1468966258-11191-7-git-send-email-jeffhost@microsoft.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-20 o 00:10, Jeff Hostetler pisze:
> +test_expect_success pre_initial_commit_0 '
> +	printf "## branch: (initial) master\n" >expected &&
> +	printf "?? actual\n" >>expected &&
> +	printf "?? dir1/\n" >>expected &&
> +	printf "?? expected\n" >>expected &&
> +	printf "?? file_x\n" >>expected &&
> +	printf "?? file_y\n" >>expected &&
> +	printf "?? file_z\n" >>expected &&

Why not use heredoc syntax (cat <<\EOF), or prepare a file
with expected output in the testsuite?

-- 
Jakub Narêbski
