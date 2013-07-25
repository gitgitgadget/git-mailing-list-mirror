From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [REQUEST 0/1] Requesting your signed-off-by
Date: Thu, 25 Jul 2013 15:39:12 -0700
Message-ID: <4b44f95a1b574b5d92a15254e4e8523@f74d39fa044aa309eaea14b9f57fe79>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 26 00:39:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2UC0-0007Tx-Sf
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 00:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756766Ab3GYWjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 18:39:23 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36541 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514Ab3GYWjX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 18:39:23 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so2543151pab.29
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 15:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+arolwmqCV/5Tj/fRHszdbCNqrQkctydlbeBbpHEPyY=;
        b=X3EaFfT4z07yamK8G3ZSP2sClcm8jXKLBjrhWcgAoUnCqxIR4N0hsM01fOIsrAwYR3
         UmpWByCLXYhH50x3zlR49kluVz4A4gYoyBQtmZ76HB4nEGJw5QsU/wM+PYPUwcOqtFOQ
         Wr9RuOYZUIycvgUa4OElPia2IdxQ1PC7EodWOcNVzr9fzKjJwnaY3qHis7P8zvtvhwE1
         g5ZGZPnLonxVx+IRp/iKzfTEvDWg34JuV+c2bQU64C/U8l8lZSm9WaFefxM4WeMDwT59
         IGU1CsiKfTTWW0dM+q1uwSEVINJLXI50K3kYnibMQ/25ZrZfqWQyasxFmIVknU30C2qA
         Wh1g==
X-Received: by 10.68.17.230 with SMTP id r6mr50211182pbd.112.1374791962361;
        Thu, 25 Jul 2013 15:39:22 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id uj1sm362905pac.21.2013.07.25.15.39.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Jul 2013 15:39:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231154>

Peff,

The tentative patch included in the following [REQUEST 1/1] message includes
so much of your suggested text from:

> From: Jeff King <peff@peff.net>
> Date: July 23, 2013 23:42:59 PDT
> Subject: Re: [PATCH v8 4/4] config: allow http.<url>.* any user matching
> 
[...]
> For (1), I wonder if the explanation would be simpler if the precedences
> of each sub-part were simply laid out. That is, would it be correct to
> say something like:
> 
>  For a config key to match a URL, each element of the config key (if
>  present) is compared to that of the URL, in the following order:
> 
>    1. Protocol (e.g., `https` in `https://example.com/`). This field
>       must match exactly between the config key and the URL.
> 
>    2. Host/domain name (e.g., `example.com` in `https://example.com/`).
>       This field must match exactly between the config key and the URL.
> 
>    3. Path (e.g., `repo.git` in `https://example.com/repo.git`). This
>       field is prefix-matched by slash-delimited path elements, so that
>       config key `foo/` matches URL `foo/bar`. Longer matches take
>       precedence (so `foo/bar`, if it exists, is a better match than
>       just `foo/`).
> 
>    4. Username (e.g., `user` in `https://user@example.com/repo.git`).
> 
>  The list above is ordered by decreasing precedence; a URL that matches
>  a config key's path is preferred to one that matches its username.

that I do not feel comfortable submitting a patch containing it under my name
without your 'Signed-off-by:' as I feel it would be a copyright violation to
do otherwise.  Since the 'Signed-off-by' mechanism is how the Git project
handles this, I'm asking for a reply to the following [REQUEST 1/1] message
that includes the full patch text with a 'Signed-off-by' line added from you
before I include it in any patch series (after which I will add my own
'Signed-off-by' for the other changes I made).

If you would prefer to simply submit your own patch with the changes,
I have no objection and will simply refer to that as a required patch instead.

Thanks,

Kyle


Kyle J. McKay (1):
  docs: update http.<url>.* options documentation

 Documentation/config.txt | 60 +++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

-- 
1.8.3
