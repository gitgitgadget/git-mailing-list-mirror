From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: What's cooking in git.git (May 2013, #08; Tue, 28)
Date: Tue, 28 May 2013 21:55:41 -0500
Message-ID: <51a56e2db218d_807b33e18100177@nysa.mail>
References: <7vli6yydmv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 05:02:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhWeG-0007UK-7Y
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759413Ab3E2DB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:01:56 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51032 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075Ab3E2DBz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:01:55 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so10920590oag.5
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=t1wzCPsusMvLXI+86ZIufCwh1GoCjpWQHDCM8QSqMtc=;
        b=O3muIFwm0CvApwlo20Rq5bqrTVjdwtSz4/6hqoB0yN4HvT5XRJAKpRJdOc0qWOJFCQ
         MHo5XZhJGMzWTaP6v/M2rWNpjgcC9Yh/m0fq1xbBFFLlUK7hQgYojqGzNscwZqdMF9/b
         k3MDmfQ+/FLSk1drzei6ZZq2nar/iwAcA7PidyvgVqmej1SMif5ED7XnP01tfXJJpJSs
         r4G34IqEb0Imuazdxl5XzZqaZPZja+FPJ0HnLFugW9RtkasAzuYncX6Va0ntNG9Dawt0
         hFKKBRlTtjmCXqVSe99nrZHleEWmDz/C3aoJqwQGrSSYCtDgzDTxifcf67XcrMcyApMG
         m0Jg==
X-Received: by 10.182.129.129 with SMTP id nw1mr368939obb.100.1369796515351;
        Tue, 28 May 2013 20:01:55 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm38040703obb.14.2013.05.28.20.01.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 20:01:54 -0700 (PDT)
In-Reply-To: <7vli6yydmv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225706>

Junio C Hamano wrote:
> * fc/makefile (2013-05-26) 5 commits
>  - build: do not install git-remote-testpy
>  - build: add NO_INSTALL variable
>  - build: cleanup using $<
>  - build: cleanup using $^
>  - build: trivial simplification
>  (this branch is used by fc/remote-helpers-use-specified-python.)

No, these are independent.

> * fc/remote-helpers-use-specified-python (2013-05-28) 4 commits
>  - remote-helpers: add exec-path links
>  - remote-helpers: allow direct test execution
>  - remote-helpers: rename tests
>  - remote-helpers: generate scripts
>  (this branch uses fc/makefile.)
> 
>  I do not particularly think the second from the bottom is a good
>  change, but it takes the remainder of the series hostage.
>  Will hopefully be rerolled without it.


> * fc/remote-bzr (2013-05-28) 8 commits
>  - remote-bzr: add fallback check for a partial clone
>  - remote-bzr: reorganize the way 'wanted' works
>  - remote-bzr: trivial cleanups
>  - remote-bzr: change global repo
>  - remote-bzr: delay cloning/pulling
>  - remote-bzr: simplify get_remote_branch()
>  - remote-bzr: fix for files with spaces
>  - remote-bzr: recover from failed clones
> 
>  The ones near the tip conflicted with the hotfix for 1.8.3 so I
>  discarded them for now.
> 
>  Will merge to 'next'?

Didn't I resend these with the conflict fixed?

-- 
Felipe Contreras
