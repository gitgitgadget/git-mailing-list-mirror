From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/6] inotify support
Date: Thu, 20 Feb 2014 06:45:17 +0700
Message-ID: <CACsJy8CaTe+disAm8xNPd2T=Z986quL14WVDCVn-q_rUd21A-Q@mail.gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com> <CAJo=hJuu8-F_=XyhPVqqK4JPQabK2iZJS=K+=mQ9dnu4Vm1uaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 20 00:45:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGGpt-0000N6-KV
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 00:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbaBSXpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 18:45:49 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:45406 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbaBSXps (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 18:45:48 -0500
Received: by mail-qc0-f175.google.com with SMTP id x13so1981903qcv.20
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 15:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lr65u0WP6ZiTF3ziwzAXlcGtgrWo4aBgZ/Fqg676SDw=;
        b=RV9hnxrQRuUCOp6cWcJ9xp6lxT+rH4p6rRdl7WyzWp7p5yd+bxN+F18PbgJQ7U/9eH
         2T4aTTZOucSduVV/UGMoPfpuVBOXGuMx5PxjWe59muxljynM7+Bh8Z8PEX/fS1g3JG/G
         z39wpC9S3wop4ZB/XcT0XInO3BguTpXx2cML3+dnDw292Zimk8mhH1Pl/jxfiLMbrZuP
         xnv/NEqYQFXfAOY6/5U9tFz9n+PVgbn6Iv8zZBKdw+dkhdDi34Kr9Ay8bUW6R2snQZBF
         Zw1dN/eYG3F/lbSkwIhuCs/F/YnJD2djkRFnLgQiJjBxUHyUntiirzB5IUxIt+oto7vh
         2TSw==
X-Received: by 10.140.47.212 with SMTP id m78mr51634278qga.21.1392853547733;
 Wed, 19 Feb 2014 15:45:47 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 19 Feb 2014 15:45:17 -0800 (PST)
In-Reply-To: <CAJo=hJuu8-F_=XyhPVqqK4JPQabK2iZJS=K+=mQ9dnu4Vm1uaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242418>

On Thu, Feb 20, 2014 at 3:35 AM, Shawn Pearce <spearce@spearce.org> wrote:
> Why a new daemon? Why don't we reuse the stable
> https://github.com/facebook/watchman project Facebook built to make
> Hg's status system fast?

I did look briefly through its readme before but there were a few
off-factors like CLA, JSON.. that made me go away. I agree that
reusing the same daemon would save us maintenance code and buy the
stability (and maybe sharing some inotify handles for users that use
both git and hg). I'll need to have a closer look at it and compare
with what I've got, now that I have a better picture of how things
should work.
-- 
Duy
