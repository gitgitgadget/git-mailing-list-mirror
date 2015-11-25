From: Stefan Beller <sbeller@google.com>
Subject: Re: Git super slow on Windows 7
Date: Wed, 25 Nov 2015 10:47:05 -0800
Message-ID: <CAGZ79kZQd4JrQsp6sk8x-OAWMxxbF+a8BXZb1VQSdJeiQ8jhuQ@mail.gmail.com>
References: <EEA07A84-26D8-4709-97AC-2C4F3A0CC5BD@gmail.com>
	<0B47434E-00FE-463A-95F1-1F10537C9F7A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	GIT Mailing-list <git@vger.kernel.org>,
	stephan.arens@autodesk.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 19:47:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1f62-0001Yx-5t
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 19:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbbKYSrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 13:47:12 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36056 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbbKYSrG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 13:47:06 -0500
Received: by ykdr82 with SMTP id r82so65620302ykd.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 10:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=azmxEDw0c070gHckm0w9RbHy0ONxw540SqWL1qb8zWQ=;
        b=Gth4IyNyufSc6MuaQ/Vfz0e9PLZ2O1cDY1vT51UB8oeltpY79r8GgZi8ZRt3uIxX+D
         FR3jW+SWf3tuoHYJPOlprBgLlTEhRs1zXODlXA31RetJH5wb1Kp/ySGmttq9BaprUz7h
         fL5nd7GuOHK3XLrsmHR+AwHVSGvdeforYW4TRL+qkMUIgatOEwjAmFNCCUlHkuLT9hnz
         5dJNsF2aTto8unye+CE7BY/4cBshpyTaZnbejx48/BMpYvXtPPOGMInMletcrEV8ALFF
         Dhp4hy5Tl7Kl+tzWz/eLgBLUMJPNjqGZc2vq/FTy4zKV24BQyuwKZ/xNU7VxwHcHmwWj
         soUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=azmxEDw0c070gHckm0w9RbHy0ONxw540SqWL1qb8zWQ=;
        b=FbPQSxwkhgM8gazX9oEH/I3S/OS/ybP5X7Esf21ROBGzSgHLPBzt6PlkZfbOoVGEZ9
         LZ+hbjxtvr9r6UQ+8h3Pj4seFqoRSqyzMewnKxWoH4qCGNIcdga2BZfENZh5y2O+q+mp
         V9LWrbxPhH6Vl0mPOrTIrlDrlnzUxLz1z0+6Rae3zSmqWhLlXMutmCvnZSAyjO3ShwKt
         1zquOGbr/FdUs+xDHi1OkYUcqMMQfP3z8FnT+QoLlqbLKcJ7UejD6xs4AW4l92rF6XOm
         ip8xAlUjRFn7ke6M9chh9OH4VKDBmF6WrzhysZdiB0KpNCiZ5ST1zav/4F2D/BOR/kTV
         5xIQ==
X-Gm-Message-State: ALoCoQkfiYAGc7aApqQuzcaO4vzKmwmlkv0GLZXhwy6LGb3UeYruSFNhYvO5Noy6xNrCCcX7jNNi
X-Received: by 10.129.81.147 with SMTP id f141mr33337548ywb.176.1448477225773;
 Wed, 25 Nov 2015 10:47:05 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 25 Nov 2015 10:47:05 -0800 (PST)
In-Reply-To: <0B47434E-00FE-463A-95F1-1F10537C9F7A@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281728>

On Wed, Nov 25, 2015 at 10:42 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> After some investigation I figured that ~50 Submodules are the culprit.
> Does anyone have an idea how to speed up Git on Windows while keeping 50 Submodules?
>
> Thanks,
> Lars
>
>

Use the latest version of Git ;)

Checkout the series merged at 65e1449
(2015-10-05, Merge branch 'sb/submodule-helper')

    The infrastructure to rewrite "git submodule" in C is being built
    incrementally.  Let's polish these early parts well enough and make
    them graduate to 'next' and 'master', so that the more involved
    follow-up can start cooking on a solid ground.

    * sb/submodule-helper:
      submodule: rewrite `module_clone` shell function in C
      submodule: rewrite `module_name` shell function in C
      submodule: rewrite `module_list` shell function in C

More specifically the commits in there:

submodule: rewrite `module_name` shell function in C

    This implements the helper `name` in C instead of shell,
    yielding a nice performance boost.

    Before this patch, I measured a time (best out of three):

      $ time ./t7400-submodule-basic.sh  >/dev/null
        real 0m11.066s
        user 0m3.348s
        sys 0m8.534s

    With this patch applied I measured (also best out of three)

      $ time ./t7400-submodule-basic.sh  >/dev/null
        real 0m10.063s
        user 0m3.044s
        sys 0m7.487s
