Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 085F51FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 12:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbdDRMC4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 08:02:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36215 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbdDRMCy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 08:02:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id q125so14249741wmd.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 05:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zI3f9Q7G+uBSaMN7iNz0o38oXJWJG2ooefWexb2yO8A=;
        b=Hs6iP6qFsTqyzvcyAXpb7EJe5uAkwd1l1ZNyaYcLYK5zsbVTvNAysq/KKL2PvDAK8C
         h0v1v9O4IJ8gaSES/EEJeMXBArqaSeKLziThr/6IMkZVjCOAL+wqgjbggXXiZVJ/cgEx
         hGnPcVAvyD2X1io6CerxOmRCIGGAldwTTfnrMGRthqJYrmEOQjVWjIIiaf2evmgKROfo
         OyIRsOmHAqnOpZ1AlZNRQvTA7YghCXWPinPzm8qV2vf3zF21Hxvrw7wj/TJsjiWFrjT5
         msDpk9Kago+DLXFk93dRBYYeTJnwaAulxiUh02jBvnE8shQLxpV/trF/YqbSFLdh0hsu
         NmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zI3f9Q7G+uBSaMN7iNz0o38oXJWJG2ooefWexb2yO8A=;
        b=MDxy56ykGIHbU1yEEER16v4fRU3sGjChEYREJ/qb6DfoutJCgu0Mm/Ck/rJrCa5qdi
         RXbMsdhWR03wsyHfcmKlKtjfY/wqqxkE/rypjbdzb6g9WMfFz6caHhKxKumrbetyD5No
         ugGCqtjSim4K7PpStZGaIz/dmyfkwzoSOF5RYrK484ewdBE1djNwQLMVAGUwi8swCTAZ
         SMb3FPZNVoQNKkgGZLYLX94asMsmgioxrn0+wEHbP7y7/WztmhXfPAKxUJgIfElZNBuO
         SawYNO/xYjPJ4PRAYZ+61a1T7mToJ7GrRAJjP3ZYAhnXdWMdNRrjZocuXDdBdGdFgCdG
         h5Ow==
X-Gm-Message-State: AN3rC/4za84VhJX40gy5+CIXrTew5T+h92tZRCPKclnCnftRuHKdw3aG
        vuD4HPup6P4DSbJe
X-Received: by 10.28.229.145 with SMTP id c139mr13550866wmh.107.1492516973143;
        Tue, 18 Apr 2017 05:02:53 -0700 (PDT)
Received: from christoph-laptop-16-04-2.fritz.box (p5DD30C29.dip0.t-ipconnect.de. [93.211.12.41])
        by smtp.googlemail.com with ESMTPSA id o9sm14747026wmd.4.2017.04.18.05.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Apr 2017 05:02:52 -0700 (PDT)
Message-ID: <1492516967.5720.32.camel@gmail.com>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout
 <tree-ish> clearer
From:   Christoph Michelbach <michelbach94@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Date:   Tue, 18 Apr 2017 14:02:47 +0200
In-Reply-To: <xmqqefwqims1.fsf@gitster.mtv.corp.google.com>
References: <1492287435.14812.2.camel@gmail.com>
         <9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley>
         <1492347718.19687.14.camel@gmail.com>
         <2DCA89C3FDFF41E5B3651018BF837267@PhilipOakley>
         <1492368692.22852.9.camel@gmail.com>
         <DF5E72F5BD2F4BB99D8EC4DF1B4543F7@PhilipOakley>
         <1492380399.19991.13.camel@gmail.com>
         <5EBADDE444D141918F6873BE8456E026@PhilipOakley>
         <xmqqefwqims1.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-04-17 at 17:26 -0700, Junio C Hamano wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:
> 
> > 
> > I'd guess that the misunderstanding is that you maybe thought that
> > the
> > whole directory would be reset to it's old state and the files b and
> > c
> > deleted, rather than just the named files present in that old commit
> > being extracted. If we'd created and added a file d just before the
> > checkout, what should have happened to d, and why?
> It probably is a bit unfair to call it "misunderstanding".  I've had
> this entry in the "Leftover Bits" list for quite some time:
> 
>     git checkout $commit -- somedir may want to remove somedir/file
> that
>     is not in $commit but is in the original index. Anybody who wants
> to
>     do this needs to consider ramifications and devise transition
> plans.
>     Cf. $gmane/234935
> 
> In the thread, this message:
> 
> https://public-inbox.org/git/xmqqeh8nxltc.fsf@gitster.dls.corp.google.
> com/
> 
> may be a good summary.

For clarification: I'm not saying that that's how the command should
behave. I merely want the documentation to describe how the command
actually behaves.

Of course, being able to reset a folder to a previous state would be
great, too. I have needed that several times and what I ended up doing
is to delete the folder and then do the checkout. This doesn't cause
problems if there are no untracked files (as of the state one wants to
restore; what's currently tracked is of course irrelevant) you still
need in that folder. If that's the case, one must make sure to not
delete those files.

I don't know whether there's an easier/better way, though. That's merely
what I did.

Having the *option* to reset an entire folder rather than the files in
it would be great.


--
Christoph
