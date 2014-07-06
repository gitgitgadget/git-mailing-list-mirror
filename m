From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 5/5] Add a little script to compare two make perf runs
Date: Sun, 6 Jul 2014 18:46:34 +0200
Message-ID: <CAKPyHN37FtG9=1zoMM3FxDzn1eSjbH7WGX8FOfkPLk8HJ5Scxg@mail.gmail.com>
References: <1404517432-25185-1-git-send-email-andi@firstfloor.org>
	<1404517432-25185-6-git-send-email-andi@firstfloor.org>
	<CAKPyHN3rz+TUkcpAS3151XZo+zK2Un=LOrQ_A=TVo4QQ_EUsDg@mail.gmail.com>
	<20140706161527.GU19781@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andi Kleen <andi@firstfloor.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andi Kleen <ak@linux.intel.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 18:46:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3paJ-0006dh-9f
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 18:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbaGFQqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 12:46:35 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:40532 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbaGFQqe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 12:46:34 -0400
Received: by mail-vc0-f178.google.com with SMTP id ij19so3128666vcb.9
        for <git@vger.kernel.org>; Sun, 06 Jul 2014 09:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UYtjAgMLA0B6BEX4lZppHVwBXbz+HUqD7AJUFWPl0P0=;
        b=u7KBCxXw7dLxL5EDCmNgHB/aH0x0cw+XvFBCPr0Y27CBIIxuo7iEdii2WI318D6DiE
         vSsA2SSOU/+Y2O54cMuUXPzJM6nfrgR68Ui94JJY6j6TFi9OXzKyHSEAUYc+z+RjPkac
         929fxYUY0Ebnn7zisxIrVbArRQoewX+1jezaz/BHXe9D4V3zrbAKLxqF3Pl/Vyurvd+N
         qJgMOFABvNKS5Tb6ludyTfzeAipEVtAbYiBoeK3xW7zSaOTp4fIHMoYrinop0YfhbWNb
         WGE4cf6DcNV/1FU7UJRRhLJ3/e6bG2TtUZbYnxFaSsyhuvAehha0JlEZSOLzxiL0VtDv
         OSvA==
X-Received: by 10.58.188.199 with SMTP id gc7mr22335143vec.4.1404665194087;
 Sun, 06 Jul 2014 09:46:34 -0700 (PDT)
Received: by 10.221.7.70 with HTTP; Sun, 6 Jul 2014 09:46:34 -0700 (PDT)
In-Reply-To: <20140706161527.GU19781@tassilo.jf.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252939>

On Sun, Jul 6, 2014 at 6:15 PM, Andi Kleen <ak@linux.intel.com> wrote:
>> a justification why the geometric mean is used here would increase my
>> confident significantly.
>
> It's just a standard way to summarize sets of benchmarks. For example SPEC
> uses the same approach.

No, SPEC would have calculated the geometric mean of the ratios
cmp[1][j] / cmp[0][j]. And this should also only be used under the
assumption that there is a multiplicative correlation.

Bert
