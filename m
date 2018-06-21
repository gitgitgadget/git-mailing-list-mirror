Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2EAE1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 22:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933734AbeFUWjr (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 18:39:47 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:44109 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933653AbeFUWjr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 18:39:47 -0400
Received: by mail-io0-f201.google.com with SMTP id f12-v6so3650933iob.11
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 15:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=x7IKHec/LrZd/5CAI63490R2J1kcksoSSTDTcoYld2o=;
        b=aePBRh8bUZEFnX8QDW9jPIjEexGRpqTVMsCgP67vi2zCEYT5iU8n0mafQOlUf7ShHi
         yo6ZXnJrLOdVNOAhXBFN9t8R0SsFwnsNKL617+F1lTJx72oi4Pzz9mEaMLU2hUQIQag3
         CMR6C8jlX4PbI65sDdMTfRtCHXQN7I5NIxi/Pd0zOPG0IKxPb6+yvrBt/90MHpvy+/xG
         PV4Iz96fbXZHOxqpLn6L1BK/elP0M9IebBa+Tkglk78/5JE7XZMXdOhyrGIt9rwx4+aP
         eV+cNcSVRCsfczhShtbC7cbYv9jyh4l/Nyt5E4miVWSPpiJ+mTXVd2eAMv2xwMEGYQ3b
         k+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=x7IKHec/LrZd/5CAI63490R2J1kcksoSSTDTcoYld2o=;
        b=hqTNhha98Q+UDVfR4sHd9zDIVSIdrkr038SLt4/G8g/fFpK7z4OGE+AY5VWHC9Iqcr
         NbqrM+jlT8KdGOpQqZzEFKhJINFDZEB2K92Jhbvvi+qQZsVQbxABNIHuASwqJObwHsd1
         bhxNpQgRprPT1nzTQg/jupSps/Gad/r5JRUNTL7Y/mrcllqd6Dck/98hRs8+Gp3p0NCw
         iEYxVmQpOKoEArxqahYwVTfjFeR5rdlKkC90qMROc49guu1/k+IxNEk/BMzT5Ern6M4Q
         4VOKkTADc3+EzQ8fLGRR2Q4NK5+mk2s8Oro9Fn+ZDS7rIvSHfOXHjAI0r4mTtER2MSg3
         wn4w==
X-Gm-Message-State: APt69E1HC8MnHalWVHICF3wZLoIlspPTAXXzYKaKLHze7g25m6y+E8FM
        s0Sefbn57BrC2sQjv/pwfTBX2Eq2qGFo3orSYVPs
X-Google-Smtp-Source: ADUXVKL0VNezhIKd8r0judpYuQA7tNdcQqLS4vEHqJVPflFvyNFrmvLK0YfYwH3sAxBU5U5zQuIENuTGCwyzxM5FDfxo
MIME-Version: 1.0
X-Received: by 2002:a24:fd41:: with SMTP id m62-v6mr3469093ith.3.1529620786359;
 Thu, 21 Jun 2018 15:39:46 -0700 (PDT)
Date:   Thu, 21 Jun 2018 15:39:42 -0700
In-Reply-To: <CAGZ79kbC0e1ujAebTUexDXH4+cFOpek3a0VTrdRUfx6Z=cpBVw@mail.gmail.com>
Message-Id: <20180621223942.81451-1-jonathantanmy@google.com>
References: <CAGZ79kbC0e1ujAebTUexDXH4+cFOpek3a0VTrdRUfx6Z=cpBVw@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH 2/5] commit-graph: add missing forward declaration
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Both this and the previous patch look good to me;
> you seem to have better (stricter) checking for
> missing includes/forward declarations, am I missing
> a compile option? (I have DEVELOPER=1 in config.mak)

Thanks. No I don't - I discovered that these were missing as I was
including these header files in other files.
