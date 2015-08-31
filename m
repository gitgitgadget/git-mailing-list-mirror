From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] INSTALL: Add docs on how to use custom Python paths.
Date: Mon, 31 Aug 2015 15:28:35 +0100
Message-ID: <CAE5ih7-5giLEUK3BvVcQ_2zMZiBdumDE-8LRsQxFnOZacLktTQ@mail.gmail.com>
References: <1441027358-27245-1-git-send-email-ehsan@mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Ehsan Akhgari <ehsan@mozilla.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 16:28:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWQ4k-00005Q-Ew
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 16:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbbHaO2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 10:28:38 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36186 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbbHaO2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 10:28:36 -0400
Received: by oibi18 with SMTP id i18so59640187oib.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xJRU2hIvLJDNuuaIph8LnyLOXnJ2NN4Ojt3FmyHlSRw=;
        b=IdJA/8+XvvHUB318R8vWq21ZwZQ2QqVSt0mClzl65IOc4gG6aYC0OU3pSLet3HZucJ
         NVShfpAXKagwxmK//qxTiYuBvysFMGe9Bz3G7lW1F4Mmo8f2F/aj3c3p6dC+KyUtQBbA
         dZg3Q0/CXQcvHT0Z5BAWEh5XO15aMtxSHMUN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=xJRU2hIvLJDNuuaIph8LnyLOXnJ2NN4Ojt3FmyHlSRw=;
        b=bCx0qeVzjmP0HCly9kgFgypJ7AQm8ZqTrKsVMsQVrdH77GB0GhUK7OnFYjy5Nme169
         HDyH6iQ6Ok5BQCyJYUbUCvqBoIG8yeXXCAuifHynjcn0vt82iaKRc3rviCFCuY4UvBRY
         2wJ+LcGSVXYW1BuyMfsrgIEGlFANdqPhgVQDy7TmY5282Ion2P4/dtV/s9EX6pqRWsuB
         Ty3smi99BdQJ46WQ7UvSXsGHZi7hunWD56RJq8mKFOdUemTtBhBT/1Xj9GkWg+kaBVGu
         6mzfPCFp3t8VVG1j3/PtQIZ3V/Gxonb7p1bSMVmBj5NxbT7htfLMvVzan8L/EAlqsNDW
         hYsQ==
X-Gm-Message-State: ALoCoQk7CZSvK8K/03yS4AduGERGzkfYsBL5t1jCCLhk1qwopWIkSkBhI8Z7iDGm+apNb6C7+GSi
X-Received: by 10.202.211.65 with SMTP id k62mr13149346oig.34.1441031315517;
 Mon, 31 Aug 2015 07:28:35 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Mon, 31 Aug 2015 07:28:35 -0700 (PDT)
In-Reply-To: <1441027358-27245-1-git-send-email-ehsan@mozilla.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276878>

On 31 August 2015 at 14:22, Ehsan Akhgari <ehsan@mozilla.com> wrote:
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
>           supported by Perforce) is needed to use the git-p4 interface
>           to Perforce.
>
> +         By default, git looks for Python installed in /usr/bin/python.
> +         On systems with a different Python installation path, pass the
> +         --with-python argument to configure, or set the PYTHON_PATH
> +         environment variable when using make to build.
> +
>   - Some platform specific issues are dealt with Makefile rules,
>     but depending on your specific installation, you may not
>     have all the libraries/tools needed, or you may have

Looks good to me.

Thanks
Luke
