Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B142A20401
	for <e@80x24.org>; Thu, 15 Jun 2017 23:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbdFOXoI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 19:44:08 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33386 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbdFOXoH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 19:44:07 -0400
Received: by mail-io0-f169.google.com with SMTP id t87so20979050ioe.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 16:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neosmart.net; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Z91UrAdVEC2igbJiUKX8Wq6jUTEoRaR+cBxt8ULo+Fc=;
        b=zx1G2bRenSoUy58DfBz+6YVay80BpzHVNW0jqwTMBYVfIJ912LSxLi9ibtNvVW0VnL
         uQIOxCg0EiJ28aJqz9aVTWdLUZsHeseM7eHiESaGQgM5EDpvjtUFnWHZYWLt1vBwx9JH
         kKPpHF4XrIHFx/nF980Qeepu7eIWix42L0ZR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Z91UrAdVEC2igbJiUKX8Wq6jUTEoRaR+cBxt8ULo+Fc=;
        b=YuD5i9ghmE25MQ39+6ndQjAE5+35g/eEDJP8doGCV+mDES7GpLDS1pegdMRCmJeG0u
         QsD/QhYnFcqbN07RY35wLZ6LRg//QOu6ArhXLGXU+WxKhT00rj1rujxmPvbSH2sfG5/M
         oRQ/xUtHFlZiSEiy0wJO4a3P+lof8APVO12KohFKzDytTws32NmT1wcUesUxQq1fA8t1
         prClasTLU58LbjAZBgb0+IkZcXuJRolTE8Ww/BpR9p94VKktQhJWNnuNERFwVVw2X0wl
         0hF7I+Q8xuka5hq5OHPENz9ttj+MItsjerzPyie/ST7MuYXWMFGDRKx2VXCperOy+ea0
         NJBg==
X-Gm-Message-State: AKS2vOz6BtBykHSfyo+AJEjL7vYOeegRrH7x9hR009USP4KB+iD43ZG7
        nW1/PouRkBhAif3bORwyVk7MelBBxKWy+KQ=
X-Received: by 10.107.11.160 with SMTP id 32mr8237436iol.222.1497570246402;
 Thu, 15 Jun 2017 16:44:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.101.131 with HTTP; Thu, 15 Jun 2017 16:43:46 -0700 (PDT)
From:   Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Date:   Thu, 15 Jun 2017 18:43:46 -0500
Message-ID: <CACcTrKfPKdPCVONMcGRbisK_WOt70yLdjavZnLTMMVocrwzk1w@mail.gmail.com>
Subject: [suggestion] Include commit-ish in git status output
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I hope it is not considered too forward of me for my first post to this lis=
t
to be a suggestion on a change to git=E2=80=99s behavior (though not in any
functional manner); but a persistent frustration for me and everyone I=E2=
=80=99ve
worked with (so, yes, 100% based off of anecdata) has been that the output
of `git status` does not include the commit or commit-ish, and one must
resort to a `git rev-parse HEAD` call.

I apologize unreservedly if this matter has already been discussed and put =
to
rest; I attempted to search the archives for a reference to this suggestion=
 but
was not met with any matches.

Additionally, if this list is not the right place to make such a suggestion=
,
then I would appreciate if someone could kindly point me in the correct
direction and apologize for littering.

Thank you kindly,

Mahmoud Al-Qudsi
NeoSmart Technologies
