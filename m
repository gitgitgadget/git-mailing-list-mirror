Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E65E20259
	for <e@80x24.org>; Wed,  7 Dec 2016 16:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932228AbcLGQC2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 11:02:28 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33342 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbcLGQC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 11:02:27 -0500
Received: by mail-pf0-f196.google.com with SMTP id 144so20828792pfv.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 08:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D0esGtJrVLJNTHokmznC0oUCBilHyP26hShY7MiGMVY=;
        b=alGSbN13rlbw01p2FJrF2P2jIA/SkK4EEvhj7Ktdu9psYU//JY9ZUhLLWMQaFumpgV
         qTJhz+OdlSsIy2Qe7EPcAdy86mFoTPab5pIPzLgsF9K3MLOl3F0uGe0MqQHn5VDEiBhF
         xJ3oJnDuVgICRI5mNkHzWZ9N03H7oHpxODkx2ntpAh0y6i7kQvRZbfU0DtxDwOIGtw03
         G90hdCy9rotWjm56eSFi6iCGj4Cbe+RKWFO1B4VdEqZecZxbrDOgrelWiegcgAI+yjhW
         EJiUdCyDibRAguKGseEQB+HJYmZFuGfSrpxWdQ9zltgYIML2xJSn2ldZ33dOvZoBfNIh
         dnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D0esGtJrVLJNTHokmznC0oUCBilHyP26hShY7MiGMVY=;
        b=TmxpPZLaoMdJ8jpPYd6qzMYxXq9ZUBvchqg82kygUf1dc8sryzKCF4eUy+nww7v/px
         YyOaPYMBc+Ow5O+/iG/h4eIPasr+Laj+o/tM8ArPqg7O7WWQZDvXeKRlJYxaS9+jt8Lr
         iCn+ybvYbbK3EqdqjHNVy3x5bX8Lj1A+Hq7Qp7wVxrfX7bFBgt/yneoc/Nz6pVbsGwXO
         LmTyUV1nWbzAN/0CuV/sI/6F3b2vkYzIMCaC8a4AuSw09HsOLIImvNrD0xsS+vUujcO0
         1xPcWWwpmc+KNbtZK/nh5vj9Ilr5h1Wb+v0o+avw8bDIjiiXkwl+96ToStY47uoi0/82
         mEyA==
X-Gm-Message-State: AKaTC00YXAA1s+MteudhMTAL0a86IHpANDhmitlw5KD0BdL2R0+cdDeRDuCfDyKKKHrF1A==
X-Received: by 10.84.173.195 with SMTP id p61mr148828400plb.158.1481125730309;
        Wed, 07 Dec 2016 07:48:50 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.187.108])
        by smtp.gmail.com with ESMTPSA id y6sm43840354pge.16.2016.12.07.07.48.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:48:49 -0800 (PST)
Date:   Wed, 7 Dec 2016 21:18:43 +0530
From:   Sitaram Chamarty <sitaramc@gmail.com>
To:     ken edward <kedward777@gmail.com>
Cc:     Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
Subject: Re: git repo vs project level authorization
Message-ID: <20161207154843.GB24934@sita-lt.atc.tcs.com>
References: <CAAqgmoO+7cLZHpX61=Mh7PjqrCUc0qyFD=C+sjVat_+KPhisbw@mail.gmail.com>
 <20161205220444.GB12249@paksenarrion.iveqy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161205220444.GB12249@paksenarrion.iveqy.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ken,

On Mon, Dec 05, 2016 at 11:04:44PM +0100, Fredrik Gustafsson wrote:
> On Mon, Dec 05, 2016 at 03:33:51PM -0500, ken edward wrote:
> > I am currently using svn with apache+mod_dav_svn to have a single
> > repository with multiple projects. Each of the projects is controlled
> > by an access control file that lists the project path and the allowed
> > usernames.
> > 
> > Does git have this also? where is the doc?
> > 
> > Ken
> 
> Git does not do hosting or access control. For this you need to use a
> third party program. There are plenty of options for you and each has
> different features and limitations. For example you should take a look
> at gitolite, gitlab, bitbucket, github, gogs. Just to mention a few.
> It's also possible to setup git with ssh or http/https with your own
> access control methods. See the progit book for details here.

For some reason I did not see your email so I am responding to
Fredrik's.

If your current system is an access control file, gitolite may
be the closest "in spirit" to what you have;

The others that Fredrik mentioned are all much more GUI (and all
of them have additional features like issue tracking, code
reiew, etc.) If you need a more github-like experience, try
those out.

Gitolite does *only* access control, nothing else, but within
that limited scope it's pretty powerful.  The simplest/quickest
overview is probably this:

    http://gitolite.com/gitolite/overview.html#basic-use-case

regards
sitaram
