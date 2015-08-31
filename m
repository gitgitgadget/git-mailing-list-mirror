From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] INSTALL: Add docs on how to use custom Python paths.
Date: Mon, 31 Aug 2015 07:53:59 -0700
Message-ID: <xmqqr3mjy0e0.fsf@gitster.mtv.corp.google.com>
References: <1441027358-27245-1-git-send-email-ehsan@mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ehsan Akhgari <ehsan@mozilla.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 16:54:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWQTH-0005eR-Jf
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 16:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbbHaOyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 10:54:03 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33630 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbbHaOyC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 10:54:02 -0400
Received: by padhy3 with SMTP id hy3so37173147pad.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=q0/P+afYWl0RsFtrYtfJPtKBEs0HAG7+dyHl0JJAA5E=;
        b=dML/VQJ8uaea2qpqYGzr12Z1AitjRZ2qLklSG0knQPkk8ygUbY/J2UQqHqLRBZmjWq
         NOzGvYoU0H/LiaAvbcoxR8PTa6pQ4ldAF96CdFdMgxrtSR197vudHwPEF8RHGSsWPN62
         8mZLmgyJFLixlJpaCaYabVBM5okhYGFMr++iIPEB83fzWW4Qq3waQfabFg5d0FGlPuwX
         zNZ4mDesQB+X97MRLS6vBo4kidWgWl61F7Ums41Q3xI+c1LAmMRtYY9OxL9YZqJCEm11
         iOGZw9B9mlZl+dzm1LAXx/TGpVziNnrJQH3LR6cCCjhWq0yLPF7NVa0/oFPEkqDTFwhU
         ERHg==
X-Received: by 10.68.69.108 with SMTP id d12mr39273988pbu.24.1441032841287;
        Mon, 31 Aug 2015 07:54:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id le8sm14870302pbc.24.2015.08.31.07.54.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 07:54:00 -0700 (PDT)
In-Reply-To: <1441027358-27245-1-git-send-email-ehsan@mozilla.com> (Ehsan
	Akhgari's message of "Mon, 31 Aug 2015 09:22:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276881>

Ehsan Akhgari <ehsan@mozilla.com> writes:

> Signed-off-by: Ehsan Akhgari <ehsan@mozilla.com>
> ---
>  INSTALL | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/INSTALL b/INSTALL
> index ffb071e..5b7fe91 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -148,6 +148,11 @@ Issues of note:
>  	  supported by Perforce) is needed to use the git-p4 interface
>  	  to Perforce.
>  
> +	  By default, git looks for Python installed in /usr/bin/python.
> +	  On systems with a different Python installation path, pass the
> +	  --with-python argument to configure, or set the PYTHON_PATH
> +	  environment variable when using make to build.
> +
>   - Some platform specific issues are dealt with Makefile rules,
>     but depending on your specific installation, you may not
>     have all the libraries/tools needed, or you may have

Thanks for a patch, but I doubt that it is a good idea to do this.

The paragraph we see in the post-context of your patch is meant to
cover it, together with 47 other platform specific locations like
SHELL_PATH, PERL_PATH, CURLDIR, etc.
