From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Fixed default install location
Date: Fri, 25 Jul 2008 22:46:27 +0100
Message-ID: <b0943d9e0807251446w1e9ed73erfa7c1638191d88a@mail.gmail.com>
References: <20080724202031.55dec8e8@whitehouse.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Daniel White" <daniel@whitehouse.id.au>
X-From: git-owner@vger.kernel.org Fri Jul 25 23:47:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMV8N-0000eS-61
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 23:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbYGYVq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 17:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbYGYVq3
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 17:46:29 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:43001 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbYGYVq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 17:46:28 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2185644waf.23
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 14:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=E/j4n5Nn+bGHV+jRTO5SbC6uRfgk+QwRT7kJoj6BI0g=;
        b=PzBY97u4vqwkTuV4N//EBMPHTFbd6Ps4tH0zVmY5SYehZ9Muv4q/zPlqgyIUTk890m
         sWN5XIMRj332zPvxcukpE+ggyIyB6Spzopxv3BFAtwIF5L7PfKm+ZVR34Hd2jEvvM/YZ
         WNGBwsmyJVw5yZA6vHi6yOmCO2NxhJp31dHtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gi/zQAMYtdJQWGdUVHvD9nao8itbWpseXpII5o+a1JOASkzf2RzThNamPKRPNB/08Y
         9cXkhOhQnpEfCWZI5KZ7FzLECdf5AyDY4FSo3U+jPA56+SPKPTb7hUz2hT+Asu3wEXew
         lJT1v/S9pizQ89pThTzgpq6bz36vptarJbMU4=
Received: by 10.114.77.19 with SMTP id z19mr2634158waa.138.1217022387946;
        Fri, 25 Jul 2008 14:46:27 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Fri, 25 Jul 2008 14:46:27 -0700 (PDT)
In-Reply-To: <20080724202031.55dec8e8@whitehouse.id.au>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90122>

2008/7/24 Daniel White <daniel@whitehouse.id.au>:
> Originally broken by addition of Debian package support.
>
> Signed-off-by: Daniel White <daniel@whitehouse.id.au>
> ---
>
> The default installation direction is actually /usr at present despite
> what 'INSTALL' says.
>
> The 'debian/rules' makefile specifies the prefix as /usr so doesn't
> seem to depend on this. I've tested the resulting debian package and
> everything is still installed correctly under /usr.

I also use "python setup.py bdist_rpm" when releasing, I think it will
get confused by a different prefix.

-- 
Catalin
