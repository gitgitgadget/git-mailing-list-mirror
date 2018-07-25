Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB151F597
	for <e@80x24.org>; Wed, 25 Jul 2018 14:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbeGYQAf (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 12:00:35 -0400
Received: from fallback19.mail.ru ([185.5.136.251]:41272 "EHLO
        fallback19.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbeGYQAf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 12:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=z+t4VE5GBBAa1BTrSLdlsdDjGIerxuRK/nVN+dBMIrA=;
        b=Dvw8z4uDn7QTsNJeJ1Yvrb1aaR9EBffY94QocD/pCF9u+EebYzS/Sy+xH6eDyj9Xi5DSGTEoJpR2NTPW3HDGPAj1iOjbKNxtUpaIfDhD+rl3GnKRf9K0bTgpbUGlXYVBzZgEINRuyxSIZYokwjkRIsA9n6kkx1Qoy668rnmUUKM=;
Received: from [10.161.25.38] (port=40574 helo=smtp61.i.mail.ru)
        by fallback19.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1fiL5b-0005uA-JH
        for git@vger.kernel.org; Wed, 25 Jul 2018 17:48:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=z+t4VE5GBBAa1BTrSLdlsdDjGIerxuRK/nVN+dBMIrA=;
        b=Dvw8z4uDn7QTsNJeJ1Yvrb1aaR9EBffY94QocD/pCF9u+EebYzS/Sy+xH6eDyj9Xi5DSGTEoJpR2NTPW3HDGPAj1iOjbKNxtUpaIfDhD+rl3GnKRf9K0bTgpbUGlXYVBzZgEINRuyxSIZYokwjkRIsA9n6kkx1Qoy668rnmUUKM=;
Received: by smtp61.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1fiL5Z-0000Rh-5C; Wed, 25 Jul 2018 17:48:29 +0300
Date:   Wed, 25 Jul 2018 17:48:26 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     David Hind <David.Hind@dynexsemi.com>
Cc:     git@vger.kernel.org
Subject: Re: Using Git for applications other than code development
Message-ID: <20180725144826.wznifhnrahav6tdv@tigra>
References: <4b9575bf039e46cd9dc150111916e734@LINCEXCHANGE1.dynexsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b9575bf039e46cd9dc150111916e734@LINCEXCHANGE1.dynexsemi.com>
User-Agent: NeoMutt/20170306 (1.8.0)
X-7FA49CB5: 0D63561A33F958A53E2E83F0493DF9FA14E5590FC437C38597D94D1F5541AEAB0A6AB1C7CE11FEE3B2DECCBDF547A30576E601842F6C81A1F004C906525384306FED454B719173D6725E5C173C3A84C3AA8C68A3574AB3B41372192FAF815B11F67BA0E7924E9B8DC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA416698F79599466C4A6ED3497C66CA202E6EFB8CE34922556FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A52BACE5E84090AC67BFA1B3E2EC062249A39FA486AFD8AD3E462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: A5480F10D64C9005EA165EA48716E380D05C0DF44A7B0140C5BFABCE19D0F17CCCBAC221E57027EFFD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 25, 2018 at 01:02:16PM +0000, David Hind wrote:

> I work for a company that is looking to adopt VCS and I like sound of
> Git (although I have no experience of using VCS). My question is,
> everything seems to be directed towards code developers. Can I use Git
> to do revision control for other types of design document? For example
> electrical circuit designs, circuit PCB designs etc.?

In addition to what Randall said (I would affirm he has presented a
comprehensive and correct picture), I'd make one minor note: Git is a
distributed VCS, and this requires certain pondering.

Even though you will almost certainly have one central (also
colloquially called "rendez-vouz") repository where everyone pushes
their changes to, and fetches them from, Git allows recording any number
of so-called "commits" — atomic, from a logical standpoint, changes to
the project — before sharing them with the rest of the team.

For software development, this _is_ blessing; for other kinds of
development it may be not so good — with the need to somehow resolve
possible conflicts in series of changes made in parallel by multiple
developers to the same content being supposedly the main impediment.
With software development it's simple: it's still done by writing
textual files (even tools which generate code automatically tend to
generate something textual these days), and conflicts in textual files
are relatively easy to represent (even without resorting to specialized
tools). Now, say, let's look at gamedev where a part of the team are
artists which work on "assets" — such as 3D-models and textures.
Two conflicting changes in the same texture are harder to reconcile.

Some (most?) centralized VCSes (as opposed to distibuted) support
explicit "locking" of certain files - which works like sort of claim
"I'm working on this file, don't touch it". Git does not have locking,
and if you think it may benefit your workflow then may be other options
might suite you better.

