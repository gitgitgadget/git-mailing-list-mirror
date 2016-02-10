From: Gary Mort <gary@sherodesigns.com>
Subject: Git config depth option?
Date: Wed, 10 Feb 2016 12:57:05 -0500
Message-ID: <CAG7bRqy=eMhr7G_7ODUcXGCHQ97uZYicTiav8-vL8hVKkSV_gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 18:57:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTZ1R-0002af-Jl
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 18:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbcBJR5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 12:57:46 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33010 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbcBJR5p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 12:57:45 -0500
Received: by mail-ob0-f175.google.com with SMTP id is5so38458390obc.0
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 09:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sherodesigns-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=XAUMR3u3HOJPoF8d4KR7LX2Y7vbsCsA9ytXcctkH3IU=;
        b=Kbr8FbBZZKbFKCBzPYLebrqV4DAnWOiO+rdDZ5MR913mtqCcieujiEOEp+OWkWgAo7
         /Tz1a7oAfYc8k8oGtxC7fD31mBTzI4fjmRE0UwxYKxnvKoUGe+vEPML9QZuEO82JUraX
         3YZRSj9FCFkSgdhM1mVDMHoDJXqdpCzll46urWKcpElTt6Mlg3Cya2WZd/M/5PCYsyTv
         NkLLDNf/qEsLeqBic3LndbhJEeFPpnGNvNsupUhCgf8j6has0ptAE/aP2WxCn2EHO69k
         WDDk5EA0FIhltU/NNhVe5bhZqqwSuqgPBw4ByyRmLo1KNslckI2VfCdvaTRGt7p7U0Rh
         YcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=XAUMR3u3HOJPoF8d4KR7LX2Y7vbsCsA9ytXcctkH3IU=;
        b=ABVcQ4sH+rjAZkOOtJJa3W9ob4nGeYeI2aIsXP0Cex+jur8ZMnJf+KRG828RNJiNmf
         XU15zE87NgH0PTnbfVII3Df/SlMcq4LXbz4Tg5vMHK2HW8pbvgKrfpjzb/TdGwpft5nA
         6WRW0WUvloxlClb0STu2yMF+vOztzUdOTNP2Wi8SLx3TbmRN4XRHRBvvIz539nGollRs
         4EnZKCF2muA0KQZK4MBsdfsSUdeNKlV3JGtuEtGR9LFIo23Li50r2PgEq3+GyG43m8mQ
         oFTSMhW3nLFVTxEto+P8fYy+JcI+jG49Yd7/ojaPTTLU1R33bBPquKwole4xjL+DOG6T
         UqYA==
X-Gm-Message-State: AG10YOT2x33hAujwn+SARBER1+HTdYmtAxH6RCcJgigZ56kE51Xa/ApbGRCe8U2DwxNagtpcoYPoHx1PNc9zPA==
X-Received: by 10.60.131.147 with SMTP id om19mr38433486oeb.82.1455127064670;
 Wed, 10 Feb 2016 09:57:44 -0800 (PST)
Received: by 10.60.65.104 with HTTP; Wed, 10 Feb 2016 09:57:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285920>

I checked the documentation and scanned through the source code for clone:
https://github.com/git/git/blob/master/builtin/clone.c

And nothing jumps out at me as a way to specify a default depth using
a global git configuration file.  I see the option defined at
https://github.com/git/git/blob/master/builtin/clone.c#L87

Since c is not my primary programming language, it may well be that
there is some common parsing function/file which automatically maps
command options to config file options.  So, is there a way to set a
default depth for the clone command?



-- 
Best Regards,

Gary

Gary A. Mort
Backend Developer | Shero Designs, Inc.



Office  845-547-0224 Ext 126 | Fax 845-547-0224
gary@sherodesigns.com | http://sherodesigns.com
