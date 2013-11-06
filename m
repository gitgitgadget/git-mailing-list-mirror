From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Catch more exceptions in compat_log_entry()
Date: Wed, 6 Nov 2013 10:27:49 +0000
Message-ID: <CAHkRjk5g-UKDN5by0+0xHZBAH8=bhP8yoiGbm1Zdd6L1rQ3Ogg@mail.gmail.com>
References: <20131022143126.11775.85272.stgit@IRBT4585>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Wed Nov 06 11:28:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve0LP-0004Ql-Lr
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 11:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085Ab3KFK2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 05:28:11 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:51119 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755753Ab3KFK2K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 05:28:10 -0500
Received: by mail-pb0-f52.google.com with SMTP id rr4so2334125pbb.25
        for <git@vger.kernel.org>; Wed, 06 Nov 2013 02:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2Wq9KKcq3PKUzs+ysID1USPFQ28e7flqRsXJcdQRqPw=;
        b=r3u1UaBqV3Bb46ob3YuvzHotME1yZOhI4iIPu5UIIGX7kkz06oxhrQryl8nvdvBt2+
         LxartJlIyA9qpu1pR3sJdKOhxa19DZC975c5mr310badRtTX2vHIKpbcKufje1ejC1+5
         H+GtFJIbYvDhuC6WMe/J3dnrsL52H6PncqVeK7E1L+aVGMLnbDBBAxfuxB9yVxOI7NbR
         O/YnECk/ho5Kc/GcRMhWUYUngOWkdU6LKmeo0oVe2J3afh26KpYaGmRqFszIXeHHTsgm
         Mojjgvbds6BAtvSdXb4PezSNjKduzKKy8vaiudG2VjU+KdffozM79asgvbXL4jrQ8vID
         rlnw==
X-Received: by 10.66.140.40 with SMTP id rd8mr3126059pab.119.1383733689177;
 Wed, 06 Nov 2013 02:28:09 -0800 (PST)
Received: by 10.70.31.196 with HTTP; Wed, 6 Nov 2013 02:27:49 -0800 (PST)
In-Reply-To: <20131022143126.11775.85272.stgit@IRBT4585>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237350>

On 22 October 2013 15:31, Pavel Roskin <proski@gnu.org> wrote:
> Catch exceptions in default_repo().  Catch git.RepositoryException.
> This suppresses stack trace in "stg pull" on detached head and outside
> the repository.
>
> Signed-off-by: Pavel Roskin <proski@gnu.org>

Thanks. Applied.

Catalin
