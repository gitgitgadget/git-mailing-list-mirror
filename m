From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] submodule: don't print status output with ignore=all
Date: Sun, 11 Aug 2013 11:33:50 -0700
Message-ID: <20130811183350.GA2942@elie.Belkin>
References: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net>
 <1375550060-5406-3-git-send-email-sandals@crustytoothpaste.net>
 <20130803182420.GG2893@elie.Belkin>
 <20130811160316.GE164436@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, judge.packham@gmail.com, iveqy@iveqy.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, gitster@pobox.com,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Aug 11 20:34:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8aSq-0005iZ-5M
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 20:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539Ab3HKSd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 14:33:59 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:63690 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385Ab3HKSd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 14:33:58 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so2520564pdj.18
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IxQn9dkOqoamELEUnAztKAVYzQ/tUhTaTQRr0auTO3g=;
        b=x3QZtKnlyEw+tqGDGwNxx21uSa2BNX42oFAT7/J6X4L2Von2lVwB02lp79ENRCrCOV
         7/QIhWND+bz59pUy51W56I7gnRD99z+mBCJJO7I8WVnY2XVnDOsMQHSgQyMpslJ5KA0/
         NpgkWOEGgPOagWdSUqDXAI2Vy8kQEUCP1t4dhWM3dS3hSpePxrRtgHt/yKvoJ9ndOBvc
         il3UOBgPYRzkgPmInJaz6jhvUOv3S/gvRP1bWlGLwqz5nb5mxa9DR5dRiI30VkPaYJ5c
         5at2lWKbFwBagMk6XG0KRPDJVgRq8w8cySkZUqFE6k4mYQG+6SwNa/ZM0eiWmrq1gxQU
         ZF5A==
X-Received: by 10.66.219.38 with SMTP id pl6mr10309665pac.59.1376246038297;
        Sun, 11 Aug 2013 11:33:58 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id xe9sm32471016pbc.21.2013.08.11.11.33.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 11 Aug 2013 11:33:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130811160316.GE164436@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232138>

brian m. carlson wrote:

> module_name uses whatever's in .gitmodules.  I'm not sure what you mean
> by "renamed a submodule", since "git mv foo bar" fails with:
>
>   vauxhall ok % git mv .vim/bundle/ctrlp .vim/bundle/ctrlq
>   fatal: source directory is empty, source=.vim/bundle/ctrlp, destination=.vim/bundle/ctrlq
>
> Can you provide me a set of steps to reproduce that operation so I can
> test it effectively?

Ah, I forgot Jens's "submodule-mv" patch series has not hit master yet.
You can get it by running

	git merge origin/pu^{/jl/submodule-mv}^2

before building git.

Thanks,
Jonathan
