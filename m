Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0E0C77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 12:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjFBMny (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 08:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbjFBMnx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 08:43:53 -0400
X-Greylist: delayed 2147 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Jun 2023 05:43:52 PDT
Received: from rush.cubic.ch (rush.cubic.ch [176.9.78.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2765618C
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=decentral.ch; s=rsa2;
        h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version:Date:Message-ID; bh=LEzJAva6L6dwmzzHOdaLs7+jimqa7lgpO7rO5JWqHdw=;
        b=eqVh3Lbp+wL9CSlnigyQpyTHppe9k5aNDZ1qWAMcgjV0DobLpjyWs86DC7O46VYTMMgIppVZeqL+J5In9h7R20z5Dg3nSqVu9GNpY0fJKtT3G+lIlUahwEftzC1lMtBOHdJdKPqM7+A/dJiVkwDfr6u+0tN59cdq8Coidi0ghxRp98cR6hxKyoC8bN8+OUcccqoWNIzv0dUtdZjRZxWHik/YUfee6+qM0Mp/Bxj5NVUUwFCNqicwOEnwb6rrXpvz9nUpV+5Qz/bJyMR9SJMoUEQMBWEsiqGZd0lEh+sMTN2+f1SH5gKBnBD3pmTx/5oDmOqjOtkjACVgwxhzSwcGuA==;
Received: from 85-195-242-225.fiber7.init7.net ([85.195.242.225] helo=[192.168.219.164])
        by rush.cubic.ch with esmtpa (Exim 4.76)
        (envelope-from <stuff@decentral.ch>)
        id 1q53Zb-00027O-AO
        for git@vger.kernel.org; Fri, 02 Jun 2023 14:08:03 +0200
Message-ID: <1201c202-e046-01a3-df87-d959f0611725@decentral.ch>
Date:   Fri, 2 Jun 2023 14:08:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
To:     git@vger.kernel.org
Content-Language: en-US
From:   Tim Tassonis <stuff@decentral.ch>
Subject: Release Notes wrongly identify git as a self-learning program
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all

When checking the release notes of Git v2.4, I stumbled upon various 
hilariously stupid entries like:

* "git format-patch" learned to write...
* "git clone" from an empty repository learned to propagate ...
* "git send-email" learned to giv

and even:

* "git mergetool" and "git difftool" learns a new...
* The credential subsystem learns


I can maybe live with:

* "git push" has been taught
* A few subcommands have been taught

Is this some sort of joke, or AI/chat-gpt bandwagonin?

To my knowledge, git 2.41 still is a piece of software written and 
enhanced by human beings and neither is taught something, let alone even 
"learned" or is "learning" something.

Why on earth is git now being described as some sort of sentient, 
self-optimizing being?

Are technical git Release Notes now being written some kind of marketing 
people?

Bye
Tim


