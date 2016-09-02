Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B131FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 19:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932807AbcIBTt7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 15:49:59 -0400
Received: from [195.159.176.226] ([195.159.176.226]:38697 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932340AbcIBTt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 15:49:59 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1bfuTH-0006uC-Q6
        for git@vger.kernel.org; Fri, 02 Sep 2016 21:49:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Christian Neukirchen <chneukirchen@gmail.com>
Subject: Re: git add =?utf-8?Q?-p=E2=80=94splitting?= hunks, limit is too
 large
Date:   Fri, 02 Sep 2016 21:49:43 +0200
Message-ID: <87mvjqjd48.fsf@juno.home.vuxu.org>
References: <CAEtDOuV+0CKRSu9mJa27+yQKJ-QRyNmwecrZKaaCh0St+VagZg@mail.gmail.com>
        <20160902191425.ki7nfhlqgnihoqpw@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
In-Reply-To: <20160902191425.ki7nfhlqgnihoqpw@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 2 Sep 2016 15:14:25 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Splitting to single lines means you need to remember to add the matched
> pairs, which might be arbitrarily far apart.  That's not really any
> different than dumping the hunk in your editor, but I find there that
> it's easy to rearrange and group things as appropriate.

My main use case for this would be to split a plain addition into
several small additions.  Which would be much easier with the
menu-driven approach.

(Mostly I just use magit, but sometimes I want to do this on machines
without emacs set up.)

-- 
Christian Neukirchen  <chneukirchen@gmail.com>  http://chneukirchen.org

