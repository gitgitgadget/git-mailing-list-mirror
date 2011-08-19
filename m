From: David Aguilar <davvid@gmail.com>
Subject: Re: Unable to build git on Lion - missing config.h from Perl header files
Date: Fri, 19 Aug 2011 13:58:55 -0700
Message-ID: <9B588F2F-ACDF-4DA7-BE30-E075CA729731@gmail.com>
References: <611AB1F99D784B92B1F7278139D6EED5@gmail.com> <CAGDPfJr01SPXvqDkYwingJ0Vu9DZx7GXO4G2uhFFfOWPvm1Rgw@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 8C148a)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Sorin Sbarnea <sorin.sbarnea@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 22:59:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuW9n-0003li-VX
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 22:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab1HSU7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 16:59:08 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63095 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab1HSU7F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 16:59:05 -0400
Received: by pzk37 with SMTP id 37so5434147pzk.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to;
        bh=QaM4G7PsKzhhYkVVRmHKZlunYoPgO3M6wcT5SmCuvws=;
        b=afgZKNm6Ly6uTPn4XXTJOOeMiKHMRGJO4YpW8JPqGn/tFHhdbS5a0QeDr6IoWZeuQF
         M/vJFeu+Yn/gFuIQ0v8eD27uCWbmntFQAuZlYUyxDG1n3lQN+I6vjGzIeYo1MfN63+Be
         b7TBD8edcL92LMYVR2Vzo8Yksy9/UzrCR6ufw=
Received: by 10.142.213.14 with SMTP id l14mr108973wfg.16.1313787544362;
        Fri, 19 Aug 2011 13:59:04 -0700 (PDT)
Received: from [10.26.228.101] ([166.205.141.12])
        by mx.google.com with ESMTPS id p7sm2608363pbn.65.2011.08.19.13.59.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Aug 2011 13:59:03 -0700 (PDT)
In-Reply-To: <CAGDPfJr01SPXvqDkYwingJ0Vu9DZx7GXO4G2uhFFfOWPvm1Rgw@mail.gmail.com>
X-Mailer: iPhone Mail (8C148a)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179725>

On Aug 19, 2011, at 9:31 AM, Sorin Sbarnea <sorin.sbarnea@gmail.com> wrote:

> Hi,
> 
> I came across the following problem while trying to build git (1.7.6) on Lion
> https://github.com/mxcl/homebrew/issues/7091
> 
> The only files existing in
> /System/Library/Perl/5.12/darwin-thread-multi-2level/CORE/ are
> libperl.dylib andperl.h.
> 
> make[2]: *** No rule to make target
> `/System/Library/Perl/5.12/darwin-thread-multi-2level/CORE/config.h',
> needed by `perl.mak'.  Stop.
> make[1]: *** [instlibdir] Error 2
> 
> If possible it would be a good idea to continue the discussion on
> homebrew bug tracker
> 
> Thanks,
> -- 
> Sorin Sbarnea

Did you upgrade to lion from a system where you were building previously? Did you try "make clean"?

-- 
                                        David