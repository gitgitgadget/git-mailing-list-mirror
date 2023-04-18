Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9627DC6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 18:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjDRSae (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 14:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjDRSac (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 14:30:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3813E901A
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 11:30:31 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-506714f2c33so3607a12.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681842629; x=1684434629;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vKC3UvcXJsR3KktDnN+X4lz1GqJ6THLqLxTL1l6CVDk=;
        b=Ea9HlkwF9TYst+egP5BNWwBQ/9nBBvzIxUS5b8nDNOsm3FbF2DdIq3dWsOFGm722Hx
         Su9WmF6IOJp7l/ex2fCfHI2rmKVHcehgZuYB/hfFnfNTKjmAcOWCCcfWbCQJ3B100U5a
         9JbDRTJZTdUqB4yM6V3SOqvRUm3hIGzPY3eB1mFD340xVVHoRvGiNs79imHQJq1kj4ci
         jNwGtxJg72UcvhZCM2uBEF6/clw+jUyASuB+gNkMkreHVXv72E4HTEGJaICtId9RutyW
         t2t6CIIG+SoXQ6MA7A/I6PPrG/H4FM2gGq8tpHiPng9pUMJJ1Hsbdh4Dp/D80uISbwma
         0HnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681842629; x=1684434629;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKC3UvcXJsR3KktDnN+X4lz1GqJ6THLqLxTL1l6CVDk=;
        b=kLP0Gi6t4WETovPrIvFOcMdjBc1+KmEcUfkNoGRUH73NZu7LdlqXV1ZaXdBR9JgjXs
         DPM8jj6T3hEh+zaWkykdDz0sNeFo9i6QrArCCZv2EGwyqR/OsXRiwlysw+JePZwJKOAk
         3ObJE01Pl3G9Mai9ntvh6ecvjIQCGuymEviYkrlrWMI6dVB8qRWcEEDSeM2NGmTCTPQu
         vh7UC56cKSfd5MH/sIF7HSa8/gs9Mly7Ou+rEDsTLGtObQxNAHt6AvQrLGDH9qdI5H4S
         136WjtdXqE5geZ/Su4RCpxeLk4r31U9UfOAYehcx/LGRH85gpA0mM68Ec/SdsdzHMGyL
         aA3g==
X-Gm-Message-State: AAQBX9eDEGziJQ+txzmHhI4Gj3WBb42lZsqpM1Tkl/KviWGYntO54Nug
        rnfymSXCCMrNQxwjllUvd0NGthER9ZmXVi/3xPrrRXw3RAvtpxKB1eeA9A==
X-Google-Smtp-Source: AKy350bfIoLCZHoyQXO/PkLGabmCbKM8iQIMB95kecx2YVTqiFSf8TIyhsDqOCCn6OM/p3UiHOXgeBA5BbN9yUSw86Q=
X-Received: by 2002:a05:6402:362:b0:507:6632:bbbd with SMTP id
 s2-20020a056402036200b005076632bbbdmr9473edw.6.1681842628819; Tue, 18 Apr
 2023 11:30:28 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 18 Apr 2023 11:30:17 -0700
Message-ID: <CAJoAoZ=o6RGCm_q1JD7gfTb2seJ1RGfD0E81VnF2A5MqZqrzQA@mail.gmail.com>
Subject: git.issues.gerritcodereview.com now live (was: Planned maintenance
 for crbug.com/git)
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 1:07=E2=80=AFPM Emily Shaffer <nasamuffin@google.co=
m> wrote:
> Heads up that tomorrow the crbug.com/git (Monorail) bug tracker will
> be placed into read-only mode so that we can move it to a new stack
> with equivalent functionality and ongoing maintenance and support.

Hi folks,

The maintenance on crbug.com/git has been completed. The tracker at
that URL will remain read-only, and all data has been migrated to
git.issues.gerritcodereview.com. Feel free to take a look around the
new tool and confirm that the migration was successful.

As with Monorail, this tool is open to the public, and any members of
the Git community are welcome to file or manage issues there. If you
have any questions about how to use it, let me know and I'm happy to
get them answered.

 - Emily
