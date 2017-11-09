Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 998E61F442
	for <e@80x24.org>; Thu,  9 Nov 2017 16:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbdKIQSg (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 11:18:36 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:55641 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752570AbdKIQSC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 11:18:02 -0500
Received: by mail-qk0-f169.google.com with SMTP id x195so8324993qkb.12
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 08:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XX2BEfWPXZUYuWSvKzJ1q9yc3gGBIHLdmZFKdjQu1PY=;
        b=P4Mhap7f4Yy/TQl/obaOq87KDsE/hj0NGs4tZiWOOv5TpZlnglM3h4WAsosJfbfSyR
         dz1M+atJWphRMD/UdeW+4+FjiFYqzLdHLQS1KAEcl7+XVbDS3KVByV0cQ7Sx7fp02RnE
         /1c1DkosOXRqYZ1PY6+XzkOHRWgYnbpdGe+8+0Of/00/1wfFH+kaB2HYh+NQmteAxHrJ
         xRQ6RL0HV5CXo27sp0HUlioiiRoI5g4eVb9dnzn0MXKkkD6qgT9A+eFk7+yoAfWUe0lM
         6/dA5elourVPTrnqiWW7Bem6RgLt3erbrSfBhi18sg/qyWxI2SmRZA1Epa9UxVDCLkPK
         Y0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XX2BEfWPXZUYuWSvKzJ1q9yc3gGBIHLdmZFKdjQu1PY=;
        b=KcZP1gGOzfckbyHg1fXJk9jVlYTWzOnYaBHB9EmHRea9sB02Pn8Lko9lt+K4yOQE7f
         FqKIolhcrLY1Uh8FZSGr4qZ+zXdICXR+6SSusDQZsAedp2gqwPRGnmYt3fHmGQ5WjPG2
         X9dasJKoqcQTxkEv3GohpjP/cw3y5vCUJTlX6u1UPbZZt9pB3BqlkdzzZY++35erlUln
         m5wKjfl23xiZ8blYYMeFGDGmcpoF9tO+NQNTaD5CIiRhIQZKfRcsZbmkf3WSwJyBpBJo
         1UcWeSVxBYi5SYx/3ylkAvG6zhTRKPQi+wq7T7zwHg2y4moZkCrc6iGni+G8V3rPrMn0
         UTWg==
X-Gm-Message-State: AJaThX6JasKMgEuVBmg3HZURUlC61f3/ofSsS2JGNznXUabOO7auKe95
        XLO2wcHbQeMGibsGuXHG20YhAAMbD+aa5aMQyzA=
X-Google-Smtp-Source: AGs4zMaJnX34WZBVf4PNyKFhTZqCe1eFuZNHNTffP4e4Ic6VNwIAwPyR+Rlb1tairxdyssly6kOpsBTwjVlvvxXa4fs=
X-Received: by 10.55.77.214 with SMTP id a205mr1557867qkb.196.1510244282206;
 Thu, 09 Nov 2017 08:18:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Thu, 9 Nov 2017 08:18:01 -0800 (PST)
In-Reply-To: <20171109134617.65244-1-adam@dinwoodie.org>
References: <20171109134617.65244-1-adam@dinwoodie.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 9 Nov 2017 11:18:01 -0500
X-Google-Sender-Auth: 8wB09oJyGM50Dc2BflZjcZ31JNQ
Message-ID: <CAPig+cRq7thrPtzS0V6o-wMhHyYWKeWg-xOQhnWCO5sLE=kDcw@mail.gmail.com>
Subject: Re: [PATCH] notes: add `rm` and `delete` commands
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git List <git@vger.kernel.org>, Johan Herland <johan@herland.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 9, 2017 at 8:46 AM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> Add `git notes rm` and `git notes delete` as alternative ways of saying
> `git notes remove`.

The justification for this change seems to be missing from the commit message.

One can formulate arguments for the change:

    - "rm" & "delete" more intuitive for Unix and DOS users
    - for consistency with git-<fill-in-blank> command(s)
    - ...

or against the change:

    - synonym bloat; balloons documentation
    - steals command verbs from potential future features
    - ...

> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
