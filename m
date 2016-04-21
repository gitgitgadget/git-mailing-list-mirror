From: Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Apr 2016, #06; Thu, 21)
Date: Thu, 21 Apr 2016 15:32:41 -0700
Message-ID: <CAGZ79kaGtP0c_pX79uyzkqV+NNTW1hek8J2NOZPD6yDo6KyrVQ@mail.gmail.com>
References: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 00:32:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atN9S-0005hW-ME
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 00:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbcDUWcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 18:32:43 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:35583 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbcDUWcm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 18:32:42 -0400
Received: by mail-io0-f182.google.com with SMTP id d62so10882044iof.2
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 15:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=HjB3/V/h+ooQyec5WZmQPJNDmS+V8Q8GeShz3IUGJDg=;
        b=kjM5hB57nc95CuHqI6du7p2dXdcMkTVsamK9pUsKMl8sl8L5vESSTqZvu/JeoghGC9
         DNNKvfAhoO1kflo+mIvOHPpx5ZYjTksgh3fPJMwGLTRLa9RlR3dklNj3w6tEFGA9XEqG
         jm0KiOQgbMrC+0+ZUD39uqrsg0KYksYcCpcafSdkQna+BulVKwAhPIEkWlHIxbbhKReE
         bzMAAHcv5CSFTwEEnZEbroGdPzGOSIaesFz6QkkJlqJKDglB55pc3UdRCvBmhJm1s1tr
         vC9yUJL/rZZsm0fdQWauK6vXyZqsrPfIOv+XR4iK4N42Iw7FsLygZL8sTAfx9Fs2gGWl
         f5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=HjB3/V/h+ooQyec5WZmQPJNDmS+V8Q8GeShz3IUGJDg=;
        b=lP5MxWiBqYmvYJVzUXcqToxLsrCVmY6TcwmKMuuap3QnsL4odCe0sIPhRo3//phVy0
         BTZd0PgLHwkexEw5LvdIb4eFyXXTxonT/iCpJAmiL2QiTur6qdfpS6+87mKk+qKsc5Hd
         mQLRngMDq0Uvdq8MPDR0T7TESbJy14aUxZN2cqhhmPW3ZBSITmr47AjHPg+WKfsBi4vK
         lZCYciJSy1MxnRdtWjmKNWAFMqPvbegg1bEaTPXek8KzMlIM0/maSAbFrdl71FHFcjqm
         u8EprVw+HXp7o35hHzhA6DfeM582T+2lR9WYUF1Lv57y1HmH1eEKpBpLRXBWnNWm82cl
         a8QA==
X-Gm-Message-State: AOPr4FWRj9AdtCYKppePU/OK+tBxDny+tJlAPpgPk0PyRT3FZM7lvsk22wY6BVgWRv5AOQJrQGd45ATLN+oOQS0I
X-Received: by 10.107.161.68 with SMTP id k65mr22331968ioe.110.1461277961449;
 Thu, 21 Apr 2016 15:32:41 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 21 Apr 2016 15:32:41 -0700 (PDT)
In-Reply-To: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292158>

>
> * sb/clone-shallow-passthru (2016-04-13) 3 commits
>  - clone: add t5614 to test cloning submodules with shallowness involved
>  - clone: add `--shallow-submodules` flag
>  - submodule clone: pass along `local` option
>
>  "git clone" learned "--shallow-submodules" option.
>
>  Needs review.
>
>

Lars, as the original author of [1]:

    [PATCH v3 0/3] add test to demonstrate that shallow recursive clones fail

do you have an opinion about this series one way or another?

Thanks,
Stefan

[1] http://thread.gmane.org/gmane.comp.version-control.git/282779
