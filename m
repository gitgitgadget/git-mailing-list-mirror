Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E89320248
	for <e@80x24.org>; Wed, 17 Apr 2019 16:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbfDQQSp (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 12:18:45 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:38999 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbfDQQSo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 12:18:44 -0400
Received: by mail-yb1-f202.google.com with SMTP id u125so18607029ybf.6
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/gguFqrafBea4tTKlaEKnNNTh3KJ5x7i5bMfBeZtbNk=;
        b=a8bH3HTt3uvwPjBgZyBDgpQnGK4TAniGzsm30KhmBThNLhSkee+ZXE6BSioUJtvQ+q
         PByGLHLdQNx2ZI4ZrLSDtPv1X3i8ugNeU8ZBPb9/QJ+h8DaRXDfOV0zOOmSsIcTVOuKp
         CHHv06GxfHZNAOyx73NDJw46rP+4BdObGHdXuNJDDHFKti2KiPlgFPJ7BeajrLFh5GLC
         ZlK7AoCeLlyBB+bV5+I/6eBGMDAwkviqTsOEzKtZXkKjRUSw+5EY9bwQQ9C4EAksX8ry
         VW+QQcmS8w+qupZxmlRd9fDGver1wqzWoZrWJpbyY5wbBHuKAPUVbmwk+1Xis+pisgL4
         QvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/gguFqrafBea4tTKlaEKnNNTh3KJ5x7i5bMfBeZtbNk=;
        b=UPcHVi4ptBn1Ql0ET/1zI7UCztCIKr2Euw1amwr/mq31R+y6akkI/zDFs1j0dp82Uk
         IgWAMSaUMs3eMcnq0THPztZ828Dc2gyMal7SfWcG2KUNZNmqGPXSY2oQsjD59mdk/ti6
         rZL7WQAiM1SJKYufHYI2Bmbt4piYWe4BbSxIC8Hwf5fe1/BDAivPtXfK7pqr4tN7svB3
         tuyA+Wz1za/+2t8evuk8SfsNSSEj4rzrjDnu3Ffs5FTvo1CTDFyAVg4Y8XVqlQKpuLz4
         Mo0kEvj32geo+ilyhouYZtyUZOdRHRB3/AkCktfaUyT+AbXZWQ3F8AXXEZEMtdvjBGKd
         f93w==
X-Gm-Message-State: APjAAAUEusOgawipp0lRURfI0VSPf1Z0jAfRooBuVsf4WWZ2zrbW7seh
        mYdsGNczIDVd72Q2nEg7RBz1j2+nbpEPAVJGC+tB
X-Google-Smtp-Source: APXvYqyU5FvpLIzfhc6mJn9tin3T2gBt52N8h/NCqqGxeOYTpf7aAELrT6LPWUntz78ZlqBaoLOS7/tKQYTH6J47CQrp
X-Received: by 2002:a25:4708:: with SMTP id u8mr65592549yba.357.1555517923599;
 Wed, 17 Apr 2019 09:18:43 -0700 (PDT)
Date:   Wed, 17 Apr 2019 09:18:40 -0700
In-Reply-To: <xmqqy349nyn6.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190417161840.261934-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqy349nyn6.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.21.0.314.g8007d49101.dirty
Subject: Re: jt/clone-server-option (was What's cooking in git.git (Apr 2019,
 #03; Tue, 16))
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >> * jt/clone-server-option (2019-04-15) 4 commits
> >>  - SQUASH???
> >>  - clone: send server options when using protocol v2
> >>  - SQUASH???
> >>  - transport: die if server options are unsupported
> >> 
> >>  "git clone" learned a new --server-option option when talking over
> >>  the protocol version 2.
> >>
> >>  Getting there.
> >
> > With the two "SQUASH???" commits, I think that all outstanding comments
> > have been addressed, and Jonathan Nieder has given his Reviewed-by [1]
> > [2].
> 
> OK, so do you want me to do the squashing or are you sending the
> final version with jrnieder's reviewd-by's?  Either is fine, but
> I need to know to avoid waiting for an update that will not come.

Please do the squashing, if you don't mind.
