From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: [PATCH] pack-objects: turn off bitmaps when skipping objects
Date: Fri, 24 Jan 2014 00:56:17 +0100
Message-ID: <CAFFjANQ6JkxqSfQaOXF29ETW9ecMXVQTz3x86h_tDjsRdT80HQ@mail.gmail.com>
References: <52E080C1.4030402@fb.com> <20140123225238.GB2567@sigill.intra.peff.net>
 <52E1A99D.6010809@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Siddharth Agarwal <sid0@fb.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 00:56:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6U8Y-0000mg-Uw
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 00:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439AbaAWX4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 18:56:39 -0500
Received: from mail-ve0-f180.google.com ([209.85.128.180]:38417 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbaAWX4i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 18:56:38 -0500
Received: by mail-ve0-f180.google.com with SMTP id db12so1539923veb.39
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 15:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JAQBen8Po/hHf4RPd/O4TgpjMoou7pSFOr778M3m+kI=;
        b=UlopA/sPP0YSXkpKeizPejJQmB+zvl25nX7G9xwc5FwI7DCqVopFn8xikTwEl1mvZ/
         /KucMx9T2Q+hxTx3CjCQIWU6Vpz8ZxLXpZv06cBdylwt7gL7cdCuB3N2awGQ1iBuDeKN
         fF96VGaP8nFmmqMHOAo02YxaCpI54Kn7mstELBYngskAI4fbNYvpN38v8QVhORqbXpND
         he88JyXipbR7YJezjCgPhp9krGn8o1mgcJEghwKVCyAW9ez8ZvH999KmH3xZiXC0p6fq
         W5XucAYF3VlTJbeP2fzyCI30piNbSPlyOsyQ54hjMgmJC77KFE81KUU9z8e63wCiCn2h
         tDWw==
X-Received: by 10.221.17.134 with SMTP id qc6mr226896vcb.47.1390521397780;
 Thu, 23 Jan 2014 15:56:37 -0800 (PST)
Received: by 10.220.133.73 with HTTP; Thu, 23 Jan 2014 15:56:17 -0800 (PST)
In-Reply-To: <52E1A99D.6010809@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240979>

On Fri, Jan 24, 2014 at 12:45 AM, Siddharth Agarwal <sid0@fb.com> wrote:
> Yes, we'd prefer to do that too. How do you actually do this, though? I
> don't see a way to pass `--honor-pack-keep` (shouldn't I pass in its
> inverse?) down to `git-pack-objects`.

We run with this patch in production, it may be of use to you:
https://gist.github.com/vmg/8589317

In fact, it may be worth upstreaming too. I'll kindly ask peff to do
it when he has a moment.

Apologies for not attaching the patch inline, the GMail web UI doesn't
mix well with patch workflow.

Cheers,
vmg
