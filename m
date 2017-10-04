Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BE552036D
	for <e@80x24.org>; Wed,  4 Oct 2017 12:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbdJDMr1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 08:47:27 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37194 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdJDMr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 08:47:26 -0400
Received: by mail-io0-f196.google.com with SMTP id m201so2447373iom.4
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=NhqsA6yxNwEsoUB2oxau0kb38NatpAOgspfd1Eejsrc=;
        b=Y2oPh7iOvtklUx+GRWeGfhYSrgv8tqHE+V5ZObG2XnuFMQ586P8RlmKEeZnD+spTMw
         QRiMmaNTwREn3ldEHikFJIYM7vcE5a6gFlewhOg/aFZnzI7AaDz8C0HUInI7Y66BM/S8
         XhetYtwP20TCv1yxf3cl6TO+kytqJtvdU+lmY8hlpWKktu8IUZ1dMHQL6vVHAQc8f9qc
         XQ/a4frX+7fNMWq+6/vINdZGh9zashw+Xdr7YKNrMc0quEA69CGdpIrWJVe9Mv6I83dg
         2dtn6d4vT58khEImEFwdGw9lOoUgMewcvCdPLpBcZ1/FS4WaL3iDyx2+aNrvVfGqtyTD
         gJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=NhqsA6yxNwEsoUB2oxau0kb38NatpAOgspfd1Eejsrc=;
        b=mySBZa7zurSYYVFgsn/6gjh/PEeqKeZFafNDE/jbLEdw/uaMTYURMnBvEyLLj1ByxM
         N5Ig7ednLB8YsLGqDr/jZvPGZTZT5QD6KWiRvvzB7uxmAw0aGPBUwcpbx0L/oGiCvzR2
         eYSf0X1utwr1aOi438cTOeOMJLufB2FpGEABa+2haK1Gy8789h+B5wB6J9qDYAzl0eGx
         /nT/3x4Ojjp+vE8KSfLxT3wKDSZUO62LDjWfCAXhMJJLt68397zJqEipqWVylfo0zWPd
         oxVZDHeEFQpdXkG0wFpMFpKX519310tTv1CQnA72hlkSX+HraLdbb7A9xsT1IihBCAQv
         XYfw==
X-Gm-Message-State: AMCzsaXvLv8dXSBH06C6lhMLes2UTw3lejNZ8ZvJLfw15fGDDtfwyXNt
        udYZg3S7mYZbP8CDFdGNPi7fnezg
X-Google-Smtp-Source: AOwi7QAdLlyV0sE3r6yRaf4Rk/1ggvo0O33rKGqWzdIT22bFHTO8joDcZc2TGV4+T/VT2V5BLFfQLw==
X-Received: by 10.107.166.206 with SMTP id p197mr32410254ioe.63.1507121245265;
        Wed, 04 Oct 2017 05:47:25 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.googlemail.com with ESMTPSA id b126sm3983113iti.31.2017.10.04.05.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Oct 2017 05:47:24 -0700 (PDT)
Message-ID: <1507121174.2245.3.camel@gmail.com>
Subject: Re: [PATCH v2] branch: change the error messages to be more
 meaningful
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqqwp4beemb.fsf@gitster.mtv.corp.google.com>
References: <20170730115908.13841-1-kaarticsivaraam91196@gmail.com>
         <20170821133608.5652-1-kaarticsivaraam91196@gmail.com>
         <1506964786.3504.3.camel@gmail.com>
         <xmqqbmlpm67l.fsf@gitster.mtv.corp.google.com>
         <1507058081.7360.5.camel@gmail.com>
         <xmqqwp4beemb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Wed, 04 Oct 2017 18:16:14 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-10-04 at 13:11 +0900, Junio C Hamano wrote:
> 
> It is a bit dissapointing that we do not need to touch tests, as it
> indicates that the logic to diagnose extra arguments as an error has
> no coverage.

Even if there were tests I don't think they would have needed any
updation as most of the tests (at least those that I came across) that
check for failure seem not to be checking for what error message gets
printed. They seem to test only if the command fails (using
test_must_fail in most cases, I guess).

Moreover, as a consequence of my assumption that the tests don't check
for the error messages themselves; I haven't even thought of checking
whether the tests or the travis-ci build succeeded as a consequence of
my patches that touch "only" the error messages!

---
Kaartic
