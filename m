Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBDD21F731
	for <e@80x24.org>; Tue,  6 Aug 2019 00:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbfHFA2O (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 20:28:14 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:46317 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbfHFA2O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 20:28:14 -0400
Received: by mail-ot1-f45.google.com with SMTP id z23so59911701ote.13
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 17:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=UJwJqEKsYJ+SWgxjOs0BsZT0w4kvS8ZiHWyROru7u1U=;
        b=uvTIRbp6MPz0+A0pm2PzaYQ+4j5LKhhUP0B8RWl4t71kaxfQB63iap8/bU3918kRlm
         JnLFa9vIOtoAnP5wlKwyR6Mgjx3I0zaY5mpzc06ULH6ZHxGsFgEwoA5wrRO6co52e36A
         aRW9e722n5J7Nxsxl5aprIyKJmAYqzKyAQeR4wtwniioYLbd8/o7KSot+oBIo+dpjz5Z
         E0+gizgphwBm8ZgYzROBz7f8HVXxDKAOTsrUCJyiwSoa5zfpWvlxLO0VeyddGm5f6s48
         SRpikkCWDA/hTeJhEx4vS0E3EVAV+oWSi89ntwgEDbHxeWt0KJ6fv9h9zUp8rdfA2NmM
         uLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=UJwJqEKsYJ+SWgxjOs0BsZT0w4kvS8ZiHWyROru7u1U=;
        b=MdrdrFUsT2XbYWl8G97AEPjwpN/iv2c22tcBOln2Wqe2NtxBQZPv5cNxHMReW77SQp
         e+30OIcAzc3h4qxcikGtJaYMGkyT5r+OL/BTmDtHNdotJLxU3uQUac7emnx6QWUTKYs0
         9EosFtlO3fAu4eFbb2FdTRp4078c4hFc23KVUTAiuxuGltgKpEjQK14/mA+oBjhCuYMV
         /u+06dNgG9EOFJOpL89G9A+LABF1zZc9vtFy+AKnwQjBwgDza0pw/31RsWi/aR71OWOh
         tK3HCCJvwS4xMzvLcWp6Vn28hH9iPufR++PbqTB8r/OcNJcdxvOHyYM3XGeBtzVttHYY
         vffA==
X-Gm-Message-State: APjAAAVa33o45mrIJO7yOmtCpRSnBihp2FPp4+rMZjbVgAjTy3MN2qUZ
        JrpvVFyuJZJpF/h110/K55y+XQ5+eKYn07O87hBfjgKnWUA=
X-Google-Smtp-Source: APXvYqzXr9lBseuxV5g5/G+A1PPQlzJgMvhatAxsSYqccsjNhHL+PcPmIjKZIm7/qCR2f0uo19eaUuO93DmTZWogKLo=
X-Received: by 2002:a9d:6a19:: with SMTP id g25mr599647otn.77.1565051293068;
 Mon, 05 Aug 2019 17:28:13 -0700 (PDT)
MIME-Version: 1.0
Reply-To: lukasgross@u.northwestern.edu
Received: by 2002:a4a:c543:0:0:0:0:0 with HTTP; Mon, 5 Aug 2019 17:28:12 -0700 (PDT)
From:   Lukas Gross <lukasgross@u.northwestern.edu>
Date:   Mon, 5 Aug 2019 17:28:12 -0700
Message-ID: <CAOY1tUUmkRBEDkF3GiP45WSi50uUGBaamx9-PGej0Z-yt0ioPg@mail.gmail.com>
Subject: amend warnings with no changes staged
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have occasionally used git commit --amend without staging any
changes or modifying the commit message (--no-edit). Since this is
often done unintentionally, could amend warn when it is being used in
this way?

Thanks!
