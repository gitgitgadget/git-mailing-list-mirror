From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git.pm
Date: Thu, 26 Apr 2012 15:31:36 -0500
Message-ID: <20120426203136.GA15432@burratino>
References: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
 <CAFouetgwRpB1GFJOC8PTVryVY-94S3xa5ZiSaWQWoz070qQ-6g@mail.gmail.com>
 <CAB3zAY0NeXuH-wXyYkbim5U74eANY4hq5D6SsVLu3KeUqHFqzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Henigan <tim.henigan@gmail.com>, git <git@vger.kernel.org>
To: Subho Banerjee <subs.zero@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 22:31:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNVLz-0001hA-Gt
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 22:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759331Ab2DZUbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 16:31:46 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38569 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004Ab2DZUbp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 16:31:45 -0400
Received: by ghrr11 with SMTP id r11so14992ghr.19
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 13:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aoSF3gtXZgbaYOTIju56qLQoX+AO4pMA/Ho7J0mFS6M=;
        b=YGSzmgm4g54xAJr2PuTxHFQubk5h1oAUaJUu79NpROzMNlkWNnKIauo57naavEYrGk
         u3WVf/euE14MQVo6AXsSiVMQ4LjAVuKnkkRAmp40iri8q9aNxjpDvlY67iF+qPzJbS19
         2Xb+qCQkck4bIjK14VIktKvOv3/sq+OUrqoTPdAc7uzCoxBBsP5zbYgTrh+m3gVFAQX4
         +CzSWe8SVy9B2gYWLW/d/HQBbo+NdQomC0ZzYCuWQL2IzWCQzZ8/FlmpjmO0FrmHDOtD
         js0Lo+ZaIwBsusc0fLOONeE65v6ydCxUNormLiMZjGnYMOXu9A0gBwrYIebzU6Bfue3L
         snrA==
Received: by 10.50.217.164 with SMTP id oz4mr20107899igc.70.1335472304867;
        Thu, 26 Apr 2012 13:31:44 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ez5sm2024314igb.11.2012.04.26.13.31.44
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Apr 2012 13:31:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAB3zAY0NeXuH-wXyYkbim5U74eANY4hq5D6SsVLu3KeUqHFqzQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196410>

Hi,

Subho Banerjee wrote:

> I will take care that I dont break those. 

Thanks, sounds good.

>                                           Should the tests in the t/
> folder of the codebase be enough to make sure everything is working as
> it should be even in the Git perl module?

No. :)

>                                           Also is there anything like
> a public build server which actually catalogs which tests are
> currently failing so that I know what has gone wrong after my changes,
> or are all commits supposed to pass every test?

When tests are known to fail, they are marked with test_expect_failure
so they don't affect the test result.

Hope that helps,
Jonathan
