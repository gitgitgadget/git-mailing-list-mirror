Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476E31F453
	for <e@80x24.org>; Mon, 22 Oct 2018 08:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeJVQfz (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 12:35:55 -0400
Received: from r-passerv.ralfj.de ([109.230.236.95]:43547 "EHLO
        r-passerv.ralfj.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeJVQfy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 12:35:54 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Oct 2018 12:35:52 EDT
Received: from [192.168.43.92] (x52716256.dyn.telefonica.de [82.113.98.86])
        by r-passerv.ralfj.de (Postfix) with ESMTPSA id 0B0A420541D4
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 10:11:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
        t=1540195915; bh=s6tILUeCwo+qGjJW3MeOd1V5kGOsklSzuE7I6KjoJJQ=;
        h=To:From:Subject:Date:From;
        b=eRnE5reVU9e8SNeGdnVIiMqsbC+aMyogJ+ZF8KKUhRKO0kmqZjzsCtZjyu2qpZyvx
         5z5Uv6IcPN1cW/dzKGyosHgNfvo7xT1nuGT30qoMNrGIATLnAH5GZEnYxgxBydan9m
         uZrMrj5e/4hrTwlw0rtCf2orPoOod36HNhhJdXVY=
To:     git@vger.kernel.org
From:   Ralf Jung <post@ralfj.de>
Openpgp: preference=signencrypt
Autocrypt: addr=post@ralfj.de; prefer-encrypt=mutual; keydata=
 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
Subject: Add config option to make "--keep-index" the default for "git stash
 push"
Message-ID: <385edc3f-3749-0620-2275-40785b6fbe49@ralfj.de>
Date:   Mon, 22 Oct 2018 10:11:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I have been repeatedly bitten by the default behavior of `git stash` to stash
not just the unstaged but also the staged changes, and then `git stash pop`
making all changes unstaged. This means `git stash && git stash pop`, per
default, loses information, and when I just spent 10min carefully selecting
hunks to be staged that's quite frustrating.

I found that for myself, I usually expect `git stash` to only stash the changes
that are not yet staged.  So I'd like to configure git such that `--keep-index`
is the default.  That would also fix the information loss I mentioned above.
(By now I am also aware of `git stash pop --index`, but (a) that's not the
default either and (b) its documentation indicates it might not always work very
well.)  However, going over the `git-config` man page, I have not found any way
to change the default behavior.  Is that possible somehow?  And if not, could
you consider this a feature request to add such an option?

Kind regards,
Ralf
