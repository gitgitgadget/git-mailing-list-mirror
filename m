Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 10194 invoked by uid 107); 4 Oct 2009 10:36:17 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 06:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbZJDK03 (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 06:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753257AbZJDK03
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 06:26:29 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:55518 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbZJDK03 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 06:26:29 -0400
Received: by ewy7 with SMTP id 7so2663372ewy.17
        for <git@vger.kernel.org>; Sun, 04 Oct 2009 03:25:51 -0700 (PDT)
Received: by 10.216.87.136 with SMTP id y8mr785534wee.43.1254651951668;
        Sun, 04 Oct 2009 03:25:51 -0700 (PDT)
Received: from ?192.168.97.11? ([80.10.46.40])
        by mx.google.com with ESMTPS id f13sm9130058gvd.21.2009.10.04.03.25.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Oct 2009 03:25:51 -0700 (PDT)
Message-ID: <4AC87837.2010004@obry.net>
Date:	Sun, 04 Oct 2009 12:25:59 +0200
From:	Pascal Obry <pascal@obry.net>
Reply-To: pascal@obry.net
Organization: Home - http://www.obry.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
MIME-Version: 1.0
To:	git list <git@vger.kernel.org>
Subject: A bug or a feature (git diff --author + --grep)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


I would have expected the --author and --grep option to work as pipeline 
filters. The first on the command line being applied first.

In other word I would have expected:

    --author AND --grep

But it turn out that the result are maching either --author or --grep:

    --author OR --grep

For example on the Git project:

    $ git log --author=obry --grep=Cygwin

Returns commit from obry and commit having Cygwin in their log.

Is this a bug or a feature?

Thanks,
Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B

