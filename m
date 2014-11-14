From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH v2] allow TTY tests to run under recent Mac OS
Date: Fri, 14 Nov 2014 05:43:27 -0500
Message-ID: <CAEBDL5VgxTMyxx6FTxocuJ3hJ+yK-VF+RycFi5Fitc+V==UEnw@mail.gmail.com>
References: <1415918419-20807-1-git-send-email-blume.mike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Mike Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 11:43:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpELm-0004mD-CG
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 11:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934579AbaKNKna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 05:43:30 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:59590 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934432AbaKNKn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 05:43:29 -0500
Received: by mail-la0-f52.google.com with SMTP id pv20so14531093lab.39
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 02:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vfdraXaad1jm67vV0GV3pWRhGnuPWxG69fB0OZUFTLY=;
        b=WhiCCrJmomuSkHFCZN8Rj8ARQ17qFcBMIaAM6tZBDX+BWOFVBeu/GcNKLeIvNGYoIA
         r8TUqHmeDQ9cmPSH5LkQSbJmDwlKTvU87QsMbWEQqpSPwkmozKHq7yCtFVaF1K2IsUSK
         EZPAgBwH9dUpA7oRDVnNG9z1e11Jt5bfxPZKc86hYmne33x39O71Sw0hwTWmFACmapDf
         wqtFHkr++feSEr48s9EEjABq52EQCCHGjC0/tpB2mZ8NfV3Zn0okL19Fu88eMSJ9Sym1
         Vuf7bRNUk99Lq7Gv5QdNNxzOw2uY4SqK4uFTRIM9pYPRolWDrvEAeNNo9bDFuVlCvEYb
         uD/Q==
X-Received: by 10.112.73.39 with SMTP id i7mr7573520lbv.8.1415961807524; Fri,
 14 Nov 2014 02:43:27 -0800 (PST)
Received: by 10.25.166.20 with HTTP; Fri, 14 Nov 2014 02:43:27 -0800 (PST)
In-Reply-To: <1415918419-20807-1-git-send-email-blume.mike@gmail.com>
X-Google-Sender-Auth: 9J0CQcs1OeeMalgGVV_Gu_esKwE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 5:40 PM, Mike Blume <blume.mike@gmail.com> wrote:
> listed bug doesn't reproduce on Mac OS Yosemite. For now, just enable
> TTY on Yosemite and higher

I've tried the reproduction recipe on Mavericks (`uname -r` => 13.4.0)
and it works fine--still going after 12,000 iterations.  Trying the
same thing on Snow Leopard shows that it still fails there--it died
after 182 iterations.

So I think the check can be relaxed to `-ge 13`.

-John
