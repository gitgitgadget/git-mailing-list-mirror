From: Adrian Stern <adrian.stern@unchained.ch>
Subject: Fwd: cannot checkout svn repository
Date: Thu, 9 Oct 2014 15:21:04 +0200
Message-ID: <CAOHZ5L5YAww1NMVv83Hifev6NG6Yoy7h8D8+RpF+N-m__FQktg@mail.gmail.com>
References: <CAOHZ5L7qcfiQAu2puD-Nv=k4etGNtKCPukSgm1UpSDGBcnPmTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 15:21:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcDek-0004px-7L
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 15:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755646AbaJINVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 09:21:09 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35609 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbaJINVF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 09:21:05 -0400
Received: by mail-ig0-f179.google.com with SMTP id h18so4017430igc.0
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 06:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=YRQmBeNL/ax6mN1yVIgzWYjJ9A6VIOyVntmUP6wQhtg=;
        b=MPNChYYQ8Y9PhjBA/EmIPoUhGyii4R3ymLrQb7tcEVrcbeOwH/hbDO9ZXFYGs6e6C/
         DS8WhSS7sL4TwA6AClGk4uoS/wNrFpH57aDyP9Ib1S/RVVaKkHLVM5wlrWbuwV2ENhBT
         K2THaxxk62GimTMMmWAqqXD5EsFHMM6L2XcXZMjldcF1GGq3MvGwkQcpA58zBiuhNVbg
         TIqxw6pBkf+38iOCp7pwziRl/cnPVA03dynZxfCDYMhr3KcStyrpOHIbmMQ5/8PCiz2N
         bx5KJeBAUALbcGjEKmvkn2zc0yIprYl+O4X/jqT7zdas2WPhFUy2OD0C8oTGgbZQUnuP
         Sr4Q==
X-Gm-Message-State: ALoCoQmoOQzoKHICB3zW3fKewDILBrp2qFDnx+lkDVjvdfgjVuap1GoQKqrx8lUVXUvrcI1zbU0C
X-Received: by 10.43.61.129 with SMTP id ww1mr8227986icb.78.1412860864941;
 Thu, 09 Oct 2014 06:21:04 -0700 (PDT)
Received: by 10.42.198.6 with HTTP; Thu, 9 Oct 2014 06:21:04 -0700 (PDT)
In-Reply-To: <CAOHZ5L7qcfiQAu2puD-Nv=k4etGNtKCPukSgm1UpSDGBcnPmTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I'm unable to checkout this subversion repository with git. Can
somebody help me?

svn co http://svn.apache.org/repos/asf/ofbiz/branches/release13.07 ofbiz.13.07

Yes i can clone it with SVN and add it to git. But this disturbes the
workflow and causes problems when someone commits to this branch which
should be a read-only mirror only.

Works fine with svn, git svn clone however does not work.

Regards,

Adrian Stern
unchained - web solutions

adrian.stern@unchained.ch
+41 79 292 83 47
