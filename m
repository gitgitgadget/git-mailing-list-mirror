Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B641AC636CC
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 18:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBESib (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 13:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBESia (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 13:38:30 -0500
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3801C5A6
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 10:38:27 -0800 (PST)
Received: from [IPV6:2a01:e0a:3d0:7640:b865:b196:7e8b:98f8] (unknown [IPv6:2a01:e0a:3d0:7640:b865:b196:7e8b:98f8])
        (Authenticated sender: thomas.koutcher@online.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id C1AB719F58C;
        Sun,  5 Feb 2023 19:38:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=online.fr;
        s=smtp-20201210; t=1675622305;
        bh=Kb1YGQRn+6e8M8TgnV6fnBX0I518zHOxc6mK+u20ACc=;
        h=Date:From:Subject:To:From;
        b=Gx42dduTrQxPwxvGIqmKz41qJDcMQIOPv3cwjl67X1h0PbKssS1N56oBGJ313nBUK
         GcOYfa6cgSh/nTGxNPOEpKUErA+Gv/wHJXzAdd3xdLUXZVYrlwv728XdpTEThbXMRB
         /9MHejHzvE7/1OIIv3pI21cqVDQCmcP8+KdNJWENqG6GPEF6nkGZQHVozq/ba4LP1D
         qT7MQmT2nYtUE6BM699EAIG0kvD56KwGMx9BKbkjAgjd0hCjzdV3EisjAT3wPvLkz3
         iszvIOQDcbRM4qiI5jBjffbo1Ko4VuXrVsXxwQ4gtoRYpu/ygnWL9kKPZIie0O7Psq
         VGJD6oCabxEhQ==
Message-ID: <119fc2c6-510c-84e0-3dad-52a37b2966d6@online.fr>
Date:   Sun, 5 Feb 2023 19:38:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.1
From:   Thomas Koutcher <thomas.koutcher@online.fr>
Subject: [ANNOUNCE] tig-2.5.8
To:     git@vger.kernel.org
Content-Language: en-GB, et, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am pleased to announce Tig version 2.5.8 which brings some improvements
and bugfixes. See the release notes below for a detailed list of changes.

What is Tig?
------------

Tig is an ncurses-based text-mode interface for git. It functions mainly
as a Git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various Git
commands.

  - Homepage:https://jonas.github.io/tig/
  - Manual:https://jonas.github.io/tig/doc/manual.html
  - Tarballs:https://github.com/jonas/tig/releases
  - Gitter:https://gitter.im/jonas/tig
  - Q&A:https://stackoverflow.com/questions/tagged/tig

Release notes
-------------

Improvements:

  - Update utf8proc to v2.8.0, supporting Unicode 15.
  - Support editing from the pager and the log (-p) views. (#1243)
  - Adjust build for native Apple Silicon.
  - Autoscroll the pager view while loading. (#1223)
  - Automatically show next diff in the status view. (#413, #469)
  - Replace `Unknown` author with `Not Committed Yet`.
  - Allow use of regular expressions for coloring. (#1249)
  - Add support for option word-diff-regex. (#1252)
  - Include original blob name in temporary filename. (#1254)

Bug fixes:

  - Use %(file_old) for old filename in the blame view. (#1226)
  - Correctly report which version of libncurses was linked. (#1240, #1241)
  - Fix stage view closing when holding the ] key. (#1245)
  - Make tests work from a path with symlinks.
  - Fix encoding of very long lines. (#1227)
  - Fix diffstat color for tig log -p.
  - Clean IO before closing a view or quitting.

Thanks to everyone who contributed (in alphabetical order): Alex Daily,
alice, Mahmoud Al-Qudsi, Sebastian Gniazdowski, Thomas Koutcher.

--
Thomas Koutcher

