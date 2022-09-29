Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4D7C433F5
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 19:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiI2TRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiI2TRV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 15:17:21 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788F3125D8C
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:17:08 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p202so1680021iod.6
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date;
        bh=or0U66T5ssNmUiU+iL1sdLuaBz1mc9AeCmCDyNbtyrw=;
        b=Ri5A4EoJR52+cDqU+IQdpW612tAs8EavTP4R2Ug3yr4C3WzuX93TqCr9wydMfAEhP/
         IbOdGL9gyZLovaHyVuLzWhAc+aWn5lSMmhCFYNrFyuk1wutDShT1MKD9rZ7+OyG9ex/v
         TtfIEQwswwI7/Q+Uh1/3gDb1h74rEUdTYpAwe4m3KNhcqNCmIQrjzZjBceRoLUD4lK1F
         gAXcGOa8KjpsWXHUCPO9KIWNYgJsiPNq/voPWKCKh03czez96rYiAmt1WR1N6x/6AQRV
         ly6yaPz81qO06bhymEjZ2pvatmGZBg3wX0+U5Fi+YCykYX93ZVYie1hPTpG3KZTX8xhO
         vMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=or0U66T5ssNmUiU+iL1sdLuaBz1mc9AeCmCDyNbtyrw=;
        b=zte2lVLLuGRksHRLjr5fi8aFBRWYz+fhrSNlbnzwTKoJpB7hj3457UM7iO8+Tku/vY
         bG6CKR91hq+FLDvy0BWW31vO/MLUJQx4rBQKKocQXJEB+j9KIbl0KLmjo86iHQBOf8Om
         uLcFGESMh01D2mfGSq7eyrFPiVhAtpZfgB3TXL5qrsBp3t7i7jQzeikZOTqKZOa9quJd
         CX9cCbFPe1GcZu5nbf1ipeOIHYIjAXLTA0gi4VCRixWfKj4uqTnEDsu0AOKNsm/Cmipc
         SPPL27C1MW9thklZrkoUjCCVqQ+8oQ1b9zfuyKMyswFLJwjou/PvCprv+CbKMltjSoEa
         X0Jg==
X-Gm-Message-State: ACrzQf1kzH25clhtaXkYaKpui24KNg3Qf2NBsEJ5xdps7FNKczy2zFzr
        lrzmTzzIa6c3DxzUnp5XhVipyTVL2Iuujg==
X-Google-Smtp-Source: AMsMyM4YYZPFAR5S0dTSf1KH/DqyhABQt5scTJDbyes+AS7tExygPqFBIBeR2vzyyULbcTkU8UBwrQ==
X-Received: by 2002:a05:6638:1396:b0:357:148d:8705 with SMTP id w22-20020a056638139600b00357148d8705mr2545077jad.61.1664479026860;
        Thu, 29 Sep 2022 12:17:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a23-20020a056638005700b0034af3f3f9c0sm76865jap.118.2022.09.29.12.17.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:17:06 -0700 (PDT)
Date:   Thu, 29 Sep 2022 15:17:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: Notes from the Git Contributor's Summit, 2022
Message-ID: <YzXvMRc6X60kjVeY@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was wonderful to see everybody in person again a couple of weeks ago
at Git Merge :-).

Now that things have begun to settle after the conference, I polished up
the notes that were taken during the Contributor's Summit to share on
the list.

The notes are available in Google Docs, too, for folks who prefer to
view them there are the following link:

    https://docs.google.com/document/d/1gVGZtkCLF3CWPt3xQnIJUy8XP702zGSxvOPk1r-6_8s

At the Contributor's Summit, we discussed the following topics:

  - Bundle URIs (12 votes)
  - State of sha256 transition (8 votes)
  - Timeline: Deleting merge-recursive, remapping 'recursive' to 'ort' (8 votes)
  - git clone --filter=commit:0 (8 votes)
  - Managing ever growing pack index sizes on servers (8 votes)
  - The next year of bitmap work (5 votes)
  - Server side merges and rebases (& new rebase/cherry-pick UI?) (7 votes)
  - State of sparsity developments and future plans (7 votes)
  - Ideas for speeding up object connectivity checks in git-receive-pack (6 votes)
  - Alternative ways to write to VFS-backed worktrees (6 votes)
  - How to run git securely in shared services (6 votes)

The list of all topics proposed (and the number of votes they received)
are here:

    https://docs.google.com/spreadsheets/d/1QhkUkYvqtGJtN7ViiTmrfcP3s0cXgqyAIACRD5Q24Mg

Some topics were combined together and others didn't have a note-taker,
but the vast majority did.

I'll send the broken-out notes for each topic that did have a note-taker
in a response to this message for posterity, and so folks can continue
the discussion on the list.

(As an aside, if you have any feedback about how the Contributor's
Summit went, please feel free to share it with me off-list, as we are
already starting to put together plans for next year's Git Merge :-)).

Thanks,
Taylor
