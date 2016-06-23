Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 163F21FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 15:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbcFWPeV (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 11:34:21 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33372 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbcFWPeU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 11:34:20 -0400
Received: by mail-io0-f176.google.com with SMTP id t74so74870532ioi.0
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 08:34:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8Hhg7I+Usami8Cs2b19pkEesV7GTaSw65N2AtTGE6uU=;
        b=wnsPVbzXFenL1o4ANnNJaI9e+nK50bqsGByp2N9kcSxsX9SMVZtxt8V0cZeIj6qPFK
         m5PbUMwQonBd7+uFGaeSU01J2OcpMvUCbvjIJ2TMGBrWkRH5ZSxZkoxK1iEL85Nh1Cjy
         1WU0LTcHLw1+lR+oA79o2L7u1UFg2FYd8cV4ixkO33QtT9brRizz1f7T8WlaWCjVLjx7
         qtjMA5TnKzfOtR/hy9c2dXzVwoFAIxyySESdBSeK/bBxjenk8mo4POOq/OAJukpa0SvG
         pIbLWAtxeBmHiK2sJe33PncfM2gwLt01gdbA/8VWEM2JgF7CKVNcaS6tY0tqnuNtBT1p
         yoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8Hhg7I+Usami8Cs2b19pkEesV7GTaSw65N2AtTGE6uU=;
        b=brRhZxO77kIECJ6TprP5Oinm+W1udyArED+HfRnIcVuTw1qQmY1EkCBpkfV2vRg88A
         tm58eHFTGo8/E9Dqb99u8X7DOK63iai1mIN5Vv/i2PN+rkQtSx2hr218d+mWZJj1wGIv
         Z9ukuq2EeH2gwsSj5R4fzELsl6Sq13bJUwkxIZxogxN4D7lk4/vjZ3FWWZtmLzOz4eZw
         h5ZnoGMKLimjpleJ6BUmrBHQuJKP1qtnSrNRR3fjrXyOrrPj8y5OjYXst+4OviPtyKpd
         SPYY7uGWBQaKV3LVGLHCuTVseb7l3OuaRLm1UMqkGTGlDGlybvSB++2Rs9OdmMFo1raE
         WrIw==
X-Gm-Message-State: ALyK8tKCvZbLMgHWlTD/2E5KBgECogEjnKddUA89dViieLeTW1y0VdUltwVJVIaOqyRWpnQABT0W9UacJ0gNCw==
X-Received: by 10.107.22.131 with SMTP id 125mr1455691iow.128.1466696059222;
 Thu, 23 Jun 2016 08:34:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Thu, 23 Jun 2016 08:33:49 -0700 (PDT)
In-Reply-To: <576B80AA.4040508@novalis.org>
References: <57662876.3070209@novalis.org> <576B80AA.4040508@novalis.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 23 Jun 2016 17:33:49 +0200
Message-ID: <CACsJy8Ao0AhJjQdcUmWTQLKb94S-z8bHJ6eMnHDOW9O9ztHAeg@mail.gmail.com>
Subject: Re: [PATCH v12 11/20] index-helper: use watchman to avoid refreshing,
 index with lstat()
To:	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 23, 2016 at 8:24 AM, David Turner <novalis@novalis.org> wrote:
> So I'll remove it and re-roll (with some other changes)

Please hold it for a few days. I wanted to have another look at this
series, but I've been busy. I should be able to really look at it this
weekend.
-- 
Duy
