From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/25] detecting &&-chain breakage
Date: Fri, 20 Mar 2015 19:18:47 -0400
Message-ID: <CAPig+cRCbhMR58_PSFnsWoyo_aZoTOVZM2YeYC6Tvo7iXMZwBA@mail.gmail.com>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 21 00:18:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ6Bp-0003Op-9A
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 00:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbbCTXSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 19:18:48 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33694 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbbCTXSs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 19:18:48 -0400
Received: by ykek76 with SMTP id k76so49788308yke.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 16:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bh0kSTKGrzuRO6uj60CGnncff/t0FNtHzAlWrMS+tQU=;
        b=g1kcJPZ+hxsBKBUOicpzgmvCoxJgnNEKdSDgmBla8R8jwV75IIk5EUWQK2uSZllM4H
         m/fXFPkK0VYlYckMfKUvHmYzTSlBMEkI7VuKJUn/Yoawrm5KnfRvtWW/FiC8jeqsh+gh
         pG53AMgyUgmHW+Ctz3b5mmKuCYuTWItZfjbg0wwDN53h6uq8PObDlwglwOBrEHksdEP3
         jZYdCB/QDKyvQx4py3eEUNjCFX5iw/jmqEanouRsqY8PFUTvryjiALzlj3sepOgKQ/7y
         rajTVJJ1QWFGq42Dwe9ZKPUGGQ1W/5DTDkVZBDrAA+Tqdx0bK0sWOez7LuEsTdeG1w+b
         hrzQ==
X-Received: by 10.236.10.5 with SMTP id 5mr84130466yhu.148.1426893527209; Fri,
 20 Mar 2015 16:18:47 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Fri, 20 Mar 2015 16:18:47 -0700 (PDT)
In-Reply-To: <20150320100429.GA17354@peff.net>
X-Google-Sender-Auth: H-OYYZ6C3JOOnstuVbICqw6YCtk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265978>

On Fri, Mar 20, 2015 at 6:04 AM, Jeff King <peff@peff.net> wrote:
> [...]
> There were a number of false positives, though as a percentage of the
> test suite, probably not many (it's just that we have quite a lot of
> tests).  Most of them were in rather old tests, and IMHO the fixes I did
> actually improved the readability of the result. So overall I think this
> is a very positive change; I doubt it will get in people's way very
> often, and I look forward to having one less thing to worry about
> handling manually in review. The biggest downside is that I may have
> automated Eric Sunshine out of a job. :)

Heh. I won't mind. Thanks for doing a thorough job.

Ironically, one of the broken here-doc &&-links you detected with
--chain-lint and fixed in 4/25 was from a patch from me: 5a9830cb
(t8001/t8002 (blame): add blame -L :funcname tests, 2013-07-17).
