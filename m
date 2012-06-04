From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: 1.7.10.3 configure does not generate Makefiles
Date: Mon, 04 Jun 2012 14:14:37 +0200
Message-ID: <4FCCA6AD.7030202@lyx.org>
References: <20120529233238.GC3072@gmail.com> <CABPQNSZaNeu7n36_v_Xe26WHqtXNQWWXiPVutvVM7hk+q5S_-Q@mail.gmail.com> <20120603233420.GA3002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jupiter.hce@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 04 14:14:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbWBJ-00043v-4F
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 14:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919Ab2FDMOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 08:14:41 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58805 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab2FDMOk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 08:14:40 -0400
Received: by eaak11 with SMTP id k11so1137038eaa.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 05:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=EVjKKMxnZMHrDjHws0Nf1QZ8vSjdDLrO2JQJWB1pUTo=;
        b=I3KHND76vrNW+Yf4CYOaRuN0XSf7d+MqlOFactnWfPopJYCU22OwwyzbcaN6JhH1Mh
         q/EvAhaGQjnECdQfKPtTHKOdK+DExG0pzPFRvC6SV8N/WCgEgo6W+ioKwUrwfqRQAnu+
         zfwz/MaqxYZCmyh1Czloevh0bigJ+oaKtFjXQC4gnKD8qXdpNdBhtIHvmIlnKC/ShAnj
         qJJMtcTysdlt6y1X0NP9j1PCfNhBzSPe23TyHWVVT52k5+q8j4J0K88h89ZTGngD1gFU
         L7jtReCh+GdUZhIJtFQtLYbJeOqzSsktB0K6eSUA9I4ewlrKQ1Vjmm8OyUzhRD5dc93k
         xHKQ==
Received: by 10.14.40.18 with SMTP id e18mr5746839eeb.109.1338812079101;
        Mon, 04 Jun 2012 05:14:39 -0700 (PDT)
Received: from [145.94.168.245] (wlan-145-94-168-245.wlan.tudelft.nl. [145.94.168.245])
        by mx.google.com with ESMTPS id y54sm36641148eef.10.2012.06.04.05.14.37
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Jun 2012 05:14:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <20120603233420.GA3002@gmail.com>
X-Gm-Message-State: ALoCoQk1CRh7Ukz/TC9aujQCAlWqWVcoFbyDMcRWjiQ/zUXObBaIYQw/rjreZ76YVMGNzSeO9l0G
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199133>


> In reply to this post by Erik Faye-Lund-2
> I thought I've sent the comments, but did not see on the forum, sorry
> if it is duplicated.
> Thanks for all response. The Makefile is included in the source
> directory, but I'd like to build the git in a separated build
> directory, not the source directory. Is it possible to build the
> git in a separated build directory? Or if there is any way to
> geneerate a Makeifle in a separaed build directory?

I've written some CMake files to generate Makefiles and/or MSVC project 
files. It is still experimental, but it supports i18n, and building and 
running the test suite (also for MSVC).

Vincent
