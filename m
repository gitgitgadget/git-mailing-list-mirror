Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90BC1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 21:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbcLEV7G (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 16:59:06 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34642 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbcLEV7F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 16:59:05 -0500
Received: by mail-lf0-f46.google.com with SMTP id o141so232146295lff.1
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 13:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1EKJB2btJvbcD5JlFUY1v4PdIyKHZ5bHcIBuKZslD28=;
        b=T8BfrvVbxMQU4E1BzAFy7hlll+mE+uHvq326Nxqf2OIZgrha37OgQSALnPJzbGTRFI
         gciU/AHme/Z5awzWmgrosLQFvxY80uYLWKzG17x+/X8C4TZ4dd7V4lx4qlSmSWikXhEg
         0X/MdjkLRK7u9o1x59ZjoPJ3Zm/DdMCGjQ7pgd44HUdxSZDmSQSPJfwWf4QMJ1pUBE6z
         TR7V5P0OTswcYTH7F6cuieNbvKAEVeqoj7r0tsrRXGJM7mvQhKFPencKI33BZor4uoNk
         z1ohErX4hYLzcgs2C8V+3WBIpRJOBdhnizPUdZm1deNvCuBmNeDdIyOIjp9f8O+nVDG+
         i7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1EKJB2btJvbcD5JlFUY1v4PdIyKHZ5bHcIBuKZslD28=;
        b=FOhFnPipVZNqO30IAYeiwufS9hFsQ8JQlDjfvwYZ8syCCJvSPwERSUHeF4q2pqccr7
         GKWarOt29R8QQH09X7XmFnuHwCZI1tJAhDu+1U1NTGRmRhvrSAee4Gx8xo5Npe3ts18x
         zfOiBelh8hC7RpZGxjt4pOqZjz0prFvuIceQBOuLqA58U1e/HyPWffKHhuBZJxQILdgw
         YKZkvYXecJxF0QKZrnlr1aPbfIW8XuM65+QT+fagG9L8e3zIo2Kwjy1tVUPwv5morMb5
         ovn0rCPaXGQEJRc7Nrd+Ho1DXkc3OvTJW6RU7tnb1dOZ0E0gYysybNZ3ghnKQdVDsWTq
         p5lg==
X-Gm-Message-State: AKaTC01qECRFlKSpo56RC1AaO/lME6fbBAdAodWUyV6V57Ls61kUTxxUOq+2hODbeYBOuA==
X-Received: by 10.25.56.22 with SMTP id f22mr19585966lfa.0.1480975143966;
        Mon, 05 Dec 2016 13:59:03 -0800 (PST)
Received: from debian (c83-253-195-111.bredband.comhem.se. [83.253.195.111])
        by smtp.gmail.com with ESMTPSA id 18sm3378868ljj.7.2016.12.05.13.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2016 13:59:03 -0800 (PST)
Received: from iveqy by debian with local (Exim 4.84)
        (envelope-from <iveqy@paksenarrion.iveqy.com>)
        id 1cE1NM-0002hw-88; Mon, 05 Dec 2016 23:04:44 +0100
Date:   Mon, 5 Dec 2016 23:04:44 +0100
From:   Fredrik Gustafsson <iveqy@iveqy.com>
To:     ken edward <kedward777@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git repo vs project level authorization
Message-ID: <20161205220444.GB12249@paksenarrion.iveqy.com>
References: <CAAqgmoO+7cLZHpX61=Mh7PjqrCUc0qyFD=C+sjVat_+KPhisbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAqgmoO+7cLZHpX61=Mh7PjqrCUc0qyFD=C+sjVat_+KPhisbw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2016 at 03:33:51PM -0500, ken edward wrote:
> I am currently using svn with apache+mod_dav_svn to have a single
> repository with multiple projects. Each of the projects is controlled
> by an access control file that lists the project path and the allowed
> usernames.
> 
> Does git have this also? where is the doc?
> 
> Ken

Git does not do hosting or access control. For this you need to use a
third party program. There are plenty of options for you and each has
different features and limitations. For example you should take a look
at gitolite, gitlab, bitbucket, github, gogs. Just to mention a few.
It's also possible to setup git with ssh or http/https with your own
access control methods. See the progit book for details here.

-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
