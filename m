From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [Bug] Segfault in git status
Date: Thu, 21 Feb 2008 10:34:47 -0500
Message-ID: <76718490802210734o43e7eb2fid3f4677d5570ac2a@mail.gmail.com>
References: <F8D3F7F0-3A98-4576-BD89-6E5C682B351C@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dane Jensen" <careo@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Feb 21 16:35:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSDSG-0005sb-He
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 16:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbYBUPet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 10:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753792AbYBUPet
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 10:34:49 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:38055 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645AbYBUPes (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 10:34:48 -0500
Received: by wa-out-1112.google.com with SMTP id v27so73223wah.23
        for <git@vger.kernel.org>; Thu, 21 Feb 2008 07:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rCTrVQRW8iLVuErTtXFC52G+ydQ3cC7Hq9PyYKwpMsw=;
        b=WeaHD117nChO7K/DaCfEfB0s+pqjKuxXQxyKFJT985ydZUkKP04R6Qc93aE4zDICH0EUUxZh+OtzfZRAHMIbjBhtJTrkMThdBx4aa2mTqqtmv5x+sarWNkJ/QHeDH/B3cbJ/StGlvmQ1JqCaB1vXy5qpjlspuumxiWTSpPCOlUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ha06QXA4gstQDssIox5XnbXe9rZR1UBcJ2K+5PCUn3dPVLLilzt4W1cL0TJh46xr4EjBTdaaUAJzmtkV1Q1IfSEHncLtfKZza2LlT6b05ptkFlfGROC8ycAJBkwo8HwBmx2yFmlkkl6r2xfpuuvpkGwklO6E5igIeOlFMCLL7xY=
Received: by 10.115.54.1 with SMTP id g1mr4594237wak.132.1203608087874;
        Thu, 21 Feb 2008 07:34:47 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Thu, 21 Feb 2008 07:34:47 -0800 (PST)
In-Reply-To: <F8D3F7F0-3A98-4576-BD89-6E5C682B351C@fastmail.fm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74622>

On Mon, Feb 18, 2008 at 3:36 AM, Dane Jensen <careo@fastmail.fm> wrote:
> Hi all-
>
>  Somehow I've managed to create a repository that causes git status to
>  segfault. To be honest, I'm not entirely sure how just yet. This comes
>  after a weekend of splitting a repository into two separate
>  repositories, filtering out a directory from one, and then creating
>  grafts in those repositories to skip commits that now change nothing.
>
>  This was in OS X 10.5.2 with git compiled from cf5c51e. Falling back
>  to 1.5.4.2 cleared it up, so with the help of git bisect I've narrowed
>  the bug down to cf55870.
>
>  I'll spend some time this week trying to find the exact point in my
>  filtering that git status went south and report back if I can
>  replicate it in a more-controlled test.

BTW - you should have a crash log in ~/Library/Logs/CrashReporter and
that should list the function in which the crash occurred.

j.
