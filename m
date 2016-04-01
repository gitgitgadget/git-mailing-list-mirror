From: Christian Couder <christian.couder@gmail.com>
Subject: Re: RPM spec file broken by README.md
Date: Fri, 1 Apr 2016 13:23:19 +0200
Message-ID: <CAP8UFD101cKKMcTOxARnWkoNWp-waUMo3B4RH+Co9D9fkpQdfg@mail.gmail.com>
References: <CADrzLrOaeQXjWeCnZSJfWWyfr3kzgm59QvR6SeTiw_E2Xg7ugQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Ron Isaacson <isaacson.ljits@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 13:23:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alxAj-0003t1-Cj
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 13:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbcDALXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 07:23:22 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36497 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbcDALXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 07:23:21 -0400
Received: by mail-wm0-f52.google.com with SMTP id 127so16472594wmu.1
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 04:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=o+nV1veRLOu7P4uanewRaWEN/uOlciNj/4Rjm9Mn89E=;
        b=Cqg8M+SODQCBwXsut7+dmQOdbYgYKfJRKyoSaXn3lx9aa0CH0w9J+9lSGzQXokPkUd
         A05rH0lXxbytf+wJTMy+w7npeGmR1FkVsuQjLH08YddT/85xZduXvlEo0VBYUI90ziZX
         f5RscJ4a6kLLwEqxJSvz9EMXWh92HuG4WH//KwymvkW24d3H7SUrgYnDvuLbtpgVlNKd
         +FLCk3bs1PI7ynN1zcJQZQiTx/IaPslA6cg60EcgvgIcgdpDBZdhYMsESM3790DSDaAU
         lE+fm7zsjRH4wU+6E7Ldy6Qhk/zYqRICurdTBefbHunZMKCyLdVvXnS3s+DIRlN2qA/9
         8e3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=o+nV1veRLOu7P4uanewRaWEN/uOlciNj/4Rjm9Mn89E=;
        b=OFvHqwXOEThrMYStOC8Y8qJAeuKEff245izMYwnKRT3+ukgNbs0oJk9nJKcw94a0f7
         EbtiQA08fo7NaxwA8scHuqKI2WXLVLmiXi8xRhv2s0YLTFe2LzxWHcFoVMSf2DFZWMc9
         7eyJhHwC2YQPc43S3oTAIFN8mWD3KW9P77olqeDcieYochuQ88bW/C/G6km51K0A9mOs
         XHL0NoKxk3mOQdDneq/Vb7kumwrCT/iF4duYssFdDXqRcFWNDmrHwltHzvm03o4zMkNY
         oKF84tzrBm+eUWdgQcwmY85LCj6aThKHaOW9IzrS4LXT9ZiYN0a1OfPgcp241xsWFdik
         hQNw==
X-Gm-Message-State: AD7BkJJWsnkzXQ0en5q3olMFZ66OnMYpBsagHqtOI7ODce2Hf/k0AsWDVT6Qqe6JAReF6BMcu3DxQRFKu+a2SA==
X-Received: by 10.28.147.72 with SMTP id v69mr3173673wmd.79.1459509799956;
 Fri, 01 Apr 2016 04:23:19 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Fri, 1 Apr 2016 04:23:19 -0700 (PDT)
In-Reply-To: <CADrzLrOaeQXjWeCnZSJfWWyfr3kzgm59QvR6SeTiw_E2Xg7ugQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290525>

Hi!

On Fri, Apr 1, 2016 at 7:35 AM, Ron Isaacson <isaacson.ljits@gmail.com> wrote:
> Hi everyone,
>
> I've noticed that "make rpm" is failing for 2.8.0 because README was
> replaced with README.md. This line in git.spec is the culprit:
>
> %doc README COPYING Documentation/*.txt
>
> Would it be possible to change this to README.md to match the source
> tree? The rpm packages build just fine with that change. Thank you
> very much!

Thanks for this bug report.

Would you care to send a patch?
