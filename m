Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68DB1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 16:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480AbcGKQvS (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 12:51:18 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:33445 "EHLO
	mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbcGKQvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 12:51:16 -0400
Received: by mail-qt0-f174.google.com with SMTP id w38so17994276qtb.0
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 09:51:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ddSxLV++91+I3yxdiE5u40B5U0EXNIHPpi4zrQUUnFg=;
        b=ZkEItybOn9toI5/FO+5me+XUD5jRk/dijYhCuAnm0Ym2dmX3xmyKk+uD4Sp+nZZzhl
         C2mldeIkfOkDpBiIbDbgLrHAF10ZYbvR3yhNS4j9rvC1aRr5TmZSAHuc+LcO8JWaq80A
         QgrjigNMYVs4uDRd/+aMJ64Fzo9eC5b9b5EVEIvZV7j3LZm+8OzmLXrUanGuSUrZ0O7K
         QnidR2KoH3H3v1SXvShku/seQqHMY3KQ3xe6Ye8xPVc+54qyBuazvWyBhpOfZv2IWEkC
         J1XUtShbxdMbbll3NSLsVNCVliaEn/50+a1bCtaz0AWh4U2kerAUG+FFFP4O31TMccF+
         MmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ddSxLV++91+I3yxdiE5u40B5U0EXNIHPpi4zrQUUnFg=;
        b=JdHbpwhccYcS7a3FD1GuYs2UMDDoES9H9tu06/3stoWkBmNdFq8JGkFozhokVKz4vx
         6u0Z9tqJKD4PXPoOZvnxAd0S0M9CuQyU14AS6N/y9D9hpI+D0VlNhu6Ef5qIEy0gHPTW
         fkiypyqUUsQw2pFybghGSGtJQmwqUhLXdHHxtduTaTuJx6eFw/jqau3c8k2hRmceUV3C
         0cTq1NgtYCp3nJTQbdqDnbGE1TEcDhAFIQy8sDN1RoOCZm4C4FSUdangoMLVudhqpVcf
         BW1yOBkE96XrtoUYSimXqj/+x005o2/bwztpYxbi5hU379Wtand0jCXuj3XIwTM0XRBp
         EEbg==
X-Gm-Message-State: ALyK8tLROz3BlcQW9O1YvvhOCfDq8t+vnc1Z6Bu0Quibr7jJqyn3aCPrBGEudU/J3jJiqMlW
X-Received: by 10.200.52.193 with SMTP id x1mr26136038qtb.65.1468255875990;
        Mon, 11 Jul 2016 09:51:15 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-13.NATPOOL.NYU.EDU. [216.165.95.2])
        by smtp.gmail.com with ESMTPSA id 29sm3089108qtx.4.2016.07.11.09.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2016 09:51:10 -0700 (PDT)
Date:	Mon, 11 Jul 2016 12:51:09 -0400
From:	Santiago Torres <santiago@nyu.edu>
To:	Nils Fenner <nilsfenner@web.de>
Cc:	git@vger.kernel.org
Subject: Re: Commits are no longer gpg-signed in 2.9.0 when "commit.gpgsign"
 is enabled
Message-ID: <20160711165108.iv2wq2m2vfh5mate@LykOS.localdomain>
References: <57838306.5090505@web.de>
 <20160711144420.nsibnudjxvgdz7cl@LykOS.localdomain>
 <5783C90D.1010909@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5783C90D.1010909@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 11, 2016 at 06:27:57PM +0200, Nils Fenner wrote:
> Hi Santiago,
> 
> repeated your test here and actually found something interesting. When
> committing via 'git gui', commits are not being gpg-signed, while firing
> a 'git commit' shows the passphrase dialog and signs the commit correctly.

I have the feeling that this is an issue with your gpg configuration not
playing well with the gui. Do you know which pinentry program is being
used (e.g., type /usr/bin/pinentry).

 
> What you mean by wme? Is it the gpg-agent's config or something?
> 

Sorry, I meant a Minimum Working Example, although that'll be hard to
reproduce in this case. Your configuration seems to be proper.

> Hope that points in the right direction.

I think that we can take further troubleshooting off-list. This doesn't
seem to be behavior with git (although we can come back with a bug
report if something is naturally-broken/could be improved)

Cheers!
-Santiago.
