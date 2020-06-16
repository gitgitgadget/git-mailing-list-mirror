Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AAFC433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 17:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D7C207C4
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 17:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=troubleshooters.com header.i=@troubleshooters.com header.b="YLcWya4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbgFPRvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:51:32 -0400
Received: from troubleshooters.com ([69.5.27.237]:55275 "EHLO
        troubleshooters.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731311AbgFPRvb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 13:51:31 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2020 13:51:31 EDT
Received: (qmail 15595 invoked from network); 16 Jun 2020 17:44:50 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        h=X-Originating-IP:Date:From:To:Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;
        s=default; d=troubleshooters.com;
        b=Zovu9fYXt+5uJKhHrGo29x71VDfWvFKFzpOs19LBxx7S00p/HblwIJchTDfcFws9WflnZToCHSIsn37seifDmGvU9onkA8OWr6+fAW17uqaFKzZQTgdi4iR1HS8MQSnAkmjvAfhgdkX0T2aDhZtRFAv5bn0B/weA5gbpZYOTyEk=;
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/simple; d=troubleshooters.com;
        s=default; t=1592329490; bh=XCAfMyJIu7iAoZlxbeIhshZclu0=; l=1109;
        h=X-Originating-IP:Date:From:To:Subject:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=YLcWya4Au40WI563Fvh6pd2mCx6+d4YXmdyc1i7v5k8R5WBgHH4jXzlcIGBrhKM3F
         FQtuasnUndJ7jyfGirmzanyjg++ltghQ0JK5SuWvHid9d8Ls0csGsrf2uxcIBnNssm
         KF4cYCU4MTtev1pu4E/vEKMpC7NNUofLvhHX53CM=
X-Originating-IP: [184.90.190.71]
Date:   Tue, 16 Jun 2020 13:44:49 -0400
From:   Steve Litt <slitt@troubleshooters.com>
To:     git@vger.kernel.org
Subject: Re: Consensus on a new default branch name
Message-ID: <20200616134449.1c27cf7c@mydesk.domain.cxm>
In-Reply-To: <20200616161001.fa5wa2br5ois2csr@chatter.i7.local>
References: <20200615205722.GG71506@syl.local>
        <20200615212154.GA79696@syl.local>
        <20200616143107.GL666057@coredump.intra.peff.net>
        <20200616161001.fa5wa2br5ois2csr@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 16 Jun 2020 12:10:01 -0400
Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:

> What if we work on making this configurable for now, but stick with
> the legacy name until we introduce breaking sha1 changes? Almost
> everything will need to retool for those anyway (and all
> documentation rewritten), so it is reasonable to bundle these changes
> to happen at the same time.

Makes perfect sense to me. No reasonable person can argue against
giving individual repository owners the ability to *easily* call their
"primary" branch anything they want.

This flame war plus the publicity it generated lets everybody know that
someday, whether in 1 month or 5 years, the default will be something
other than "master", so they'll start changing their software and
scripts to accommodate a variable instead of a hardcode, so when the
change happens, there will be minimal software disruption and minimal
hurt feelings.

SteveT

Steve Litt 
May 2020 featured book: Troubleshooting Techniques
     of the Successful Technologist
http://www.troubleshooters.com/techniques
