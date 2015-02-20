From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Fri, 20 Feb 2015 10:26:15 +0700
Message-ID: <CACsJy8B_zkAecL2Wag8a5c9-_C9eoA9dYj4ciBXqXRVmRW77zw@mail.gmail.com>
References: <20150218191417.GA7767@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 04:26:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOeEs-0006TH-OR
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 04:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbbBTD0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 22:26:47 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:42335 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbbBTD0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 22:26:46 -0500
Received: by iecrp18 with SMTP id rp18so4987349iec.9
        for <git@vger.kernel.org>; Thu, 19 Feb 2015 19:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nkPAGArN32bWZI/2HeilaOCu2AcXTmobdWMBpm1dF3E=;
        b=FioFBLIK58TA4dIYk00Q8cIiPyLADKcgc/qSkGNxMafgLJn8rNXNgJhtWogRK1sFg+
         JY/+h7jBqpPHz64jxM/uDhdkx2T1viylk0Mbb6u6Oo4GmVK5RiqusGDI2aM7Owp9gJyw
         1CDcovNR8qistS1Fm0i1fklCUHMJYM3V6dQmt6kERkLx+Ra6PEOkiGZf1OKaZd2iOOGB
         8JVfrlODifJXRE4YwQm/kevxsvMlgQnqdyA7drCp1aAuOU5H6P0g7AvJxSCRj6sWaLsW
         eXrTmS7vevmru53YZwYHZTLJO8BSKCOEbMg8yEoKNDtnI1uhE6akmtfD7YCc+BePbWgO
         TFHw==
X-Received: by 10.42.109.20 with SMTP id j20mr9615873icp.27.1424402805696;
 Thu, 19 Feb 2015 19:26:45 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Thu, 19 Feb 2015 19:26:15 -0800 (PST)
In-Reply-To: <20150218191417.GA7767@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264130>

On Thu, Feb 19, 2015 at 2:14 AM, Jeff King <peff@peff.net> wrote:
> and the list of microprojects:
>
>   http://git.github.io/SoC-2015-Microprojects.html
>

There is debian bug 777690 [1] that's basically about making tag's
version sort aware about -rc, -pre suffixes. I imagine it would touch
versioncmp.c and builtin/tag.c (to retrieve the suffixes from config
file).

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=777690
-- 
Duy
