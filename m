From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: What's cooking in git.git (May 2016, #03; Mon, 9)
Date: Tue, 10 May 2016 11:07:34 +0530
Message-ID: <CAFZEwPPQRMLg2no5vyT5scL2CjR0DAco4R+bj84giSZcJ3+WAw@mail.gmail.com>
References: <xmqqposusuoq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 07:37:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b00MW-0004ka-HL
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 07:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbcEJFhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 01:37:36 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36362 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbcEJFhf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 01:37:35 -0400
Received: by mail-yw0-f179.google.com with SMTP id o66so2353707ywc.3
        for <git@vger.kernel.org>; Mon, 09 May 2016 22:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8DWGc+cTRWB/yC+63JNRWpKPqSUDZxM6tBR4kaJm2YY=;
        b=aICpbhrzD5Aq03/DrjhwHS9G+W6cYKi6PT0PJIXqipnYLApkm45F23rJBSWEgpfBUt
         zlRvPByTA+btDFuGeLzSQCpaMYAkNdwng/zRJR94yk+xKiYFEVZ7qF56L8kYiRYhbgvv
         NMjxc7RIh84/OdUcJKMkw8uMyoQxUPEiCcGwLMzjaWCEo5h9veQ4uA3q+kOqWtHn9mPO
         dAOzvJWpSwomKuTpRr8P30zN4+P6ghuZYdj/co+EWyVVDG73sy25xwGrVXRK+m4eelWW
         BjdO0mc6cc/zNC8oSyyhMAQ0xk0jBRugJPoaWSOLBPk7DPNho200GHLfbUzUgyWbo5Ub
         htgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8DWGc+cTRWB/yC+63JNRWpKPqSUDZxM6tBR4kaJm2YY=;
        b=mRYhyW64r6om4syoVuRfGGJbf9hP8+fqKl25Jr/q/b+NZSSkByuEWKW3BKgPB2r4kY
         20PGwMYroYgSGFg3TZDLaJ0/hJDFnJmk1//psCu2fyYzsVeYThJZEM+gPfaGunNxdsoM
         Lp0S1V2lgfZr+JpVn8Q0WveVrfpi+gE7dugsYQm1dMEXbUufDMWWRCNzhHSmGGIteHBB
         ntD/djWeIm17yBO8+njSaB5INIdMam/GdQQp8kPJIemCBTbiDhcwC2dC9RMQU4DqgxFW
         X7Z5gEYYyXHwxVrP0H0QakhavQcopEFZ/ykptKinX1UJ0y4fVqCbVcZ6skIMVNmixTFT
         OBgw==
X-Gm-Message-State: AOPr4FVNRdzXl+44onbmvu+X+Uzl8lHXVBGTc+lz3Zze4P+4/tYx89bu2Iot0CgJLt2WSLrNHiwUp5hIYtfhLQ==
X-Received: by 10.13.221.212 with SMTP id g203mr22075417ywe.68.1462858654994;
 Mon, 09 May 2016 22:37:34 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Mon, 9 May 2016 22:37:34 -0700 (PDT)
In-Reply-To: <xmqqposusuoq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294094>

On Tue, May 10, 2016 at 4:30 AM, Junio C Hamano <gitster@pobox.com> wrote:

> * pb/commit-verbose-config (2016-05-05) 8 commits
>  - SQUASH???
>  - commit: add a commit.verbose config variable
>  - t7507-commit-verbose: improve test coverage by testing number of diffs
>  - parse-options.c: make OPTION_COUNTUP respect "unspecified" values
>  - t/t7507: improve test coverage
>  - t0040-parse-options: improve test coverage
>  - test-parse-options: print quiet as integer
>  - t0040-test-parse-options.sh: fix style issues
>  (this branch is used by jc/test-parse-options-expect.)
>
>  "git commit" learned to pay attention to "commit.verbose"
>  configuration variable and act as if "--verbose" option was
>  given from the command line.
>
>  Almost there.
>  ($gmane/293663).

I like the change you have made so you could squash it in. Thanks.

Regards,
Pranit Bauva
