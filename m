From: Colby Ranger <cranger@google.com>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Wed, 26 Jun 2013 11:41:12 -0700
Message-ID: <CAFFbUKJZ1w2puKFLjPNZmMhSLo3_1kpfA1upv7K6qZV256vTyQ@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-10-git-send-email-tanoku@gmail.com>
	<CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
	<CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
	<20130626051117.GB26755@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shawn Pearce <spearce@spearce.org>,
	=?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 26 20:41:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uruec-0000CD-OF
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 20:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233Ab3FZSlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 14:41:14 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:40138 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab3FZSlO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 14:41:14 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so15190296oag.20
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 11:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WmAMLG7p9eMV+yM3ruPmYCcuSujifTzxEmkdiDwbwkc=;
        b=nX7EM5j4v5Zwrtt284sCtIP1Xl7rVfZfPIwgafPtLBhhTuSvLZx+dYUPRtOuG6fbbt
         hZ6BPmb5atajPB0oUuQc/F4c/ycXxS/DG25ukBxvtGF+nUteuIGfps4MQHKE57TWM3au
         7cLkKhPWJzPFZP3W7186EeM0C5DsoQBbyNrzP+e7Q8SBOYTHDts4AlwqBCnphsEcT27j
         Z6HMlLXCE+DqkWKRn7/5CiyWkfjeNojkOwTOh7vIGsfKtOm2tWKp3rimxAYspgAQj8v0
         3eJpLQhDfaRNw1J4UMHnQsrdrlp0XYCADIDe8N2k4RFyi50PkRn70tA/r2pRZoOlBenO
         Bjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=WmAMLG7p9eMV+yM3ruPmYCcuSujifTzxEmkdiDwbwkc=;
        b=ejPL4zk2V320e6XUHm2nmIoN/7oi0gFnJKocAvTEKJLxxEsnAEwA6TWW7uB3P5RM5p
         gDFPXPUmT7ABqghx6Qo1TS9N07kBg3AqG58Rq6BwnZTrfRDeE17N1SBZlR5pHZu5YJ/N
         8RhLa/bJB1vOQ+aIeI66SjpDoIUB6GpC4p2XSoYCdZZqsNgpOHX98NRYZPV/OsEjeLca
         HIn3YAW8ZCAX+EIvQ4O2BywPtpEeglCVdE8+8DqiaB4/Qe8SdgVyuFCAJsXUkTDTIAy4
         HQgFYvgIbtEZkZGkJ0TNhqmwljVbnN2nQRkpLteIlc6rHUXuR6MkTKU/n7+o0BjEGfip
         L0dQ==
X-Received: by 10.182.105.99 with SMTP id gl3mr2350688obb.94.1372272073512;
 Wed, 26 Jun 2013 11:41:13 -0700 (PDT)
Received: by 10.60.125.198 with HTTP; Wed, 26 Jun 2013 11:41:12 -0700 (PDT)
In-Reply-To: <20130626051117.GB26755@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQloiSR3HEQUgV3jz7cBpJO7oaWptN6pyv2TJZHmJLB5TbC+0GMa2YbL1nsk1EQt82cyFz1pw7SfUGsvNWFgzxpU8uWBSEuuZvAAw4KW2DbS2j1zzYk8QqhSIKpWVBu8dPhrNvJ5bnuN6zh11a2BFdLdMHNGuvG9cl4yNhg2WUSaLUwn6OmMUuxdzdZ+7wPUBbrd3iGO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229052>

> Pinning the bitmap index on the reverse index adds complexity (lookups
> are two-step: first find the entry in the reverse index, and then find
> the SHA1 in the index) and is measurably slower, in both loading and
> lookup times. Since Git doesn't have a memory problem, it's very hard
> to make an argument for design that is more complex and runs slower to
> save memory.

Sorting by SHA1 will generate a random distribution. This will require
you to inflate the entire bitmap on every fetch request, in order to
do the "contains" operation.  Sorting by pack offset allows us to
inflate only the bits we need as we are walking the graph, since they
are usually at the start of the bitmap.

What is the general size in bytes of the SHA1 sorted bitmaps?  If they
are much larger, the size of the bitmap has an impact on how fast you
can perform bitwise operations on them, which is important for fetch
when doing wants AND NOT haves.
