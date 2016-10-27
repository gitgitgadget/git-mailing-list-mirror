Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996DC20193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942527AbcJ0WBQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:01:16 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34443 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942164AbcJ0WBP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:01:15 -0400
Received: by mail-qk0-f179.google.com with SMTP id x11so16753453qka.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S/Exxi8yvG+/IhfHTzOX84wrIdYPOL38TO2VzzAuyTw=;
        b=NXcr9Sufft5OK83IpNvKrAzcdOudKVC8YI4faBCDI6ipsPqP/BCyojmtlr44KVaAke
         ms1X9Fvp9d51oPbgRTHrHtFtTu/5lk+IPavW48bhpKEhgklXRAqClxJUl6A3g22Tyfm8
         3iniujU+C5qUZMM5ghSja2D6SyIj1Yb95wJ/MLuuE/1GTOdoLjk0wYR6QpWvNE0IyDLo
         Ne4SkfHJSv4vaj0SzzAH15X5PQa3JbNvG0ByRwUNlzOvqOAi+4tUB+9KcdD2w2nqVbdE
         hno+/ujp07uYJPCr+tJSU8ctgULlDqa5rPveKQrzpPMVSYuavVTy/flnbdQSnOXo+Gs0
         NxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S/Exxi8yvG+/IhfHTzOX84wrIdYPOL38TO2VzzAuyTw=;
        b=jVkXpa7OIevq6fcBCoSQD55oBs3NZsiapR7n6ASL+AjR6CPqPN7MhryiMvt481wWq6
         Cwgqd4Hzu0A8DjvtEiARYI9+BHh00zr1XLWxj44zSL0qYJYK6e0CnAawre2TbwMhwiZP
         1fQEtfpFsZBkYIIJw51SNTuCZx/bQ0w67CccaxcjBdvEESZJ7pKhEe8QqwcyKXyxe11B
         jfmROhv6VsIx14+y+n5Gj+Bn386GS2DORByhkgc4VSpAKx2dxazTLhJ6YczftnzWySbE
         QNetdpez5AMHJFT1azit1FIb/Ftu8MFfL1792DZ6D1bn2oKuX9YkLNRPyZYVDl8C8Pfh
         RizQ==
X-Gm-Message-State: ABUngvdJw9/+q9hrxoJvr2AreFgmiMEQreAvfSVH7M1wai5D2J8gqjDKBRteq3htw1qIlltXkkKceXeaoUF0iQiP
X-Received: by 10.55.20.164 with SMTP id 36mr7243144qku.86.1477605674119; Thu,
 27 Oct 2016 15:01:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 27 Oct 2016 15:01:13 -0700 (PDT)
In-Reply-To: <CALj-rGeoT_mpmuw8Put=6eRhzf-r2WUohu_Kd-wnpc=BvO5joA@mail.gmail.com>
References: <CALj-rGeoT_mpmuw8Put=6eRhzf-r2WUohu_Kd-wnpc=BvO5joA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Oct 2016 15:01:13 -0700
Message-ID: <CAGZ79kZAfqxB699MOs6A6RL==Ku-qF7ABiW=eA+TSrqK+8e_sA@mail.gmail.com>
Subject: Re: feature request
To:     John Rood <mr.john.rood@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 2:55 PM, John Rood <mr.john.rood@gmail.com> wrote:
> Users should be able to configure Git to not send them into a Vim editor.

See https://git-scm.com/docs/git-var

GIT_EDITOR

Text editor for use by Git commands. The value is meant to be interpreted
by the shell when it is used. Examples: ~/bin/vi, $SOME_ENVIRONMENT_VARIABLE,
"C:\Program Files\Vim\gvim.exe" --nofork. The order of preference is the
$GIT_EDITOR environment variable, then core.editor configuration, then
$VISUAL, then $EDITOR, and then the default chosen at compile time,
which is usually vi.


So maybe

    git config --global core.editor "nano"

helps in your case?
