Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 9169 invoked by uid 107); 4 Oct 2009 07:34:34 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 03:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbZJDHXR (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 03:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbZJDHXR
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 03:23:17 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:51757 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbZJDHXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 03:23:16 -0400
Received: by ewy7 with SMTP id 7so2583376ewy.17
        for <git@vger.kernel.org>; Sun, 04 Oct 2009 00:22:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=P4/qk+1JwjdLcGjGdBtNwk6FLfx4WBvNJTdwKG0Jrp8=;
        b=clg6jIAYDHswHr5uWWIgDVDwikg/XabQKLfS2W50RGZ1iDnH5UblhbkqS9oy48VG+t
         92lxEpZw8Fb8EeJShyXWQ6/AwitorxU/FJJ9GLKpRliwOY9MqNObw/o5nMVA24wG7K+8
         ujoDn74BpQtuC108Rqy69IUKADLAOrIJNo474=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=h/Brfyi3DMDRooLK8Fx7YW98ByHY29dfaYV2/5xzM+9glIPs168bce2XIPK64TRrh0
         DQWEqcPJ8ERFA2vVOFxQlqnCD7w2PnGq1uLmG4nJHeNMrz2NcahAHogkIGC6GXMdmbLc
         EvLgx4zPWmSgAYmwWKMGOSwbbt/3r/KPMUcOs=
Received: by 10.211.159.19 with SMTP id l19mr1727028ebo.43.1254640958119;
        Sun, 04 Oct 2009 00:22:38 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 4sm16143629ewy.78.2009.10.04.00.22.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Oct 2009 00:22:36 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MuLQL-00045E-H9; Sun, 04 Oct 2009 09:22:29 +0200
Date:	Sun, 4 Oct 2009 09:22:29 +0200
From:	Clemens Buchacher <drizzd@aon.at>
To:	Tim <timothyjwashington@yahoo.ca>
Cc:	git@vger.kernel.org
Subject: Re: "Not currently on any branch"
Message-ID: <20091004072229.GA14142@localhost>
References: <loom.20091002T215942-663@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20091002T215942-663@post.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Oct 02, 2009 at 08:08:52PM +0000, Tim wrote:
> I have some code in a git repo that is "Not currently on any branch". Now,
> there's the master branch and another branch 'ui-integration' that I'm
> using in this project. I don't know how the project got into this headless
> state, but I need to be using the 'ui-integration' branch. 

It can happen either by explicitly detaching HEAD using "git checkout
<commit>", or if you used rebase and it is still in progress.

Clemens
