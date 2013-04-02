From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Composing git repositories
Date: Wed, 3 Apr 2013 00:49:07 +0530
Message-ID: <CALkWK0nq-Cfkf+s4BWiFPAg4LYefW=+ifbazLUnvDv39OWhjcQ@mail.gmail.com>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <201304010016.r310G79C032108@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:20:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6kj-00010w-HG
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761289Ab3DBTTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:19:49 -0400
Received: from mail-ia0-f180.google.com ([209.85.210.180]:36689 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab3DBTTs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:19:48 -0400
Received: by mail-ia0-f180.google.com with SMTP id f27so598208iae.25
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6R4PmriLNh+rd1bEshNi7KN+oDCUyTYnCmf0WaI5DiQ=;
        b=Cfx+Rz0pkMUZalaouYRoYH4K54uVu4j2r9irvWZwVci7B+MG17hTk8WVGUnzkbFLDa
         GdWfFwEgFTRtLPNDjjFDlQn1hDLHEiQ5VJ8ywzwchr1gsICgBh4EAvI1qmqLOQ8HMbID
         zBAMh/FwAi3NvtcZ1+qURrwyVm3VjZwlQHrjahdO+o8i/C1k1T1zJI2kR7cxrhkKwK20
         vSe+PtzRt3D6AHpfkjhMgg7OsTrgBIK/Ss7FSv7kVmhRn8VA662dmZIym4+o06xTEJH4
         BDZrk0L9Bvkcip28/BNujl3NhE2xgkT4dILcPMGv/23/iz+pXltgXFx7Yypq/xJpEPJJ
         jtIQ==
X-Received: by 10.50.17.201 with SMTP id q9mr5362244igd.107.1364930387772;
 Tue, 02 Apr 2013 12:19:47 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Tue, 2 Apr 2013 12:19:07 -0700 (PDT)
In-Reply-To: <201304010016.r310G79C032108@no.baka.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219856>

Seth Robertson wrote:
>
> In message <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>, Ramkumar Ramachandra writes:
>
>     As a user inexperienced with recursive submodules (I've only used them
>     in this repository), I found it highly confusing.  Thanks for clearing
>     them up.
>
> You may want to investigate third party alternatives like gitslave
> http://gitslave.sf.net Depending on what problem you are trying to
> solve, it can be better (or worse) to use compared to submodules.

I'm not looking for yet another specialized tool for my special
combined-repository workflow.  I'm looking to build one generalized
tool that will be able to do various kinds of compositions equally
well.

> [...]

Thanks.  I learnt one more workflow that people want to use.

It's one large Perl script.  Quite an involved hack.
