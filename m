From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Bug with rev-list --reverse?
Date: Thu, 18 Apr 2013 06:18:42 -0500
Message-ID: <CAMP44s014Yv9+N7=0CYiYYybJCZJ7r-vQp_zcfg6Xo=3f21RWA@mail.gmail.com>
References: <CAMP44s25mUA1M+K+YKaC=bz3Dr7kSDyXK5g2ot8i+1EPy8zRhA@mail.gmail.com>
	<alpine.DEB.2.00.1304181146090.30868@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Apr 18 13:18:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USmrZ-0006IM-6u
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 13:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283Ab3DRLSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 07:18:45 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:61099 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652Ab3DRLSo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 07:18:44 -0400
Received: by mail-lb0-f179.google.com with SMTP id t1so2571294lbd.10
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 04:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ZD9EeFui4AqAZuu3UaGHCrhM8YFA9BG9QUtEuvD9Ses=;
        b=ExkbZxm/qlQsim830ibpuxc8Cvvi8Ms5kLqxV/NvFKNBiyKQ4afIerrXHKyMcV2lZy
         R3pJlFyQdXUkCPWpodZDETSslAQSbJrPsBEfzDCo3qUpZHwhYIBNbRe+yQ01SuV6U+R+
         f2B/WeLMcHrLKwSlJqezPoCaNVVOrNHrO5ddqZ6qzH/2wjPFYk0oHdOhASZpaGMv4LwQ
         DrSKgkXHlCFg7jeXjWFXM0tVlSiAhsRaNqXVpqPVFwZHawvARtIz5r0YZ6GpxU2sLxad
         64V438AmfoN0w8OPxvdS5/p2lUtZBu1LysuCo49WT+u+4i/IXNvSWJTXVnMAFCSYD/lf
         dbnA==
X-Received: by 10.112.163.6 with SMTP id ye6mr5562870lbb.59.1366283923021;
 Thu, 18 Apr 2013 04:18:43 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 04:18:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1304181146090.30868@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221650>

On Thu, Apr 18, 2013 at 5:47 AM, Peter Krefting <peter@softwolves.pp.se> wrote:

>> % git log --oneline -1 v1.8.1.5^..v1.8.1.6
>> % git log --oneline --reverse -1 v1.8.1.5^..v1.8.1.6
>>
>> I expect to get a different output, and not both showing v1.8.1.6.
>> Wouldn't you agree?
>
>
>  Quoting the manual page:
>
>  Commit Limiting
>    Besides specifying a range of commits that should be listed using the
> special notations explained in the description, additional commit limiting
> may be applied. Note that they are applied before commit ordering and
> formatting options, such as --reverse.
>
> Given that, I would expect the output to be the same.

If expectations were based on documentation, all one has to do is
document bugs, and there would be no bugs anymore :)

Code can be changed to fit more appropriately user expectations (which
are independent of documentation), and the documentation updated
accordingly.

-- 
Felipe Contreras
