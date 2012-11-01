From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Wrap commit messages on `git commit -m`
Date: Thu, 1 Nov 2012 15:12:03 -0700
Message-ID: <20121101221203.GE6213@elie.Belkin>
References: <CALkWK0kQ+qCsOa87yY4wma279mp+9h+LFv3qCP_qrNdDyGNcsQ@mail.gmail.com>
 <m3a9v170ca.fsf@black.gullik.net>
 <CAO54GHDRBDyQYvo-g_xEvsQJRgtfbbT-4-kop8hoSK1D37G44w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Lars Gullik =?utf-8?Q?Bj=C3=B8nnes?= <larsbj@gullik.org>,
	git <git@vger.kernel.org>
To: Kevin <ikke@ikke.info>
X-From: git-owner@vger.kernel.org Thu Nov 01 23:12:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU2zx-0004Wt-Mk
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 23:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992555Ab2KAWMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 18:12:13 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42795 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992551Ab2KAWML (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 18:12:11 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2022201pbb.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 15:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1WfoV9QWz+kHTS1ffY8TZdO2DLBbApjWxrZ8jYuaP9A=;
        b=rac6RmpGk9uf6ZSGrpQEg+Ppj45xnwe0lJr7ln0f3U4B5dyVEmEGwOEoOs+3NavBy1
         njeO0mqGdCwum0N1bpX1EpbnKoqRyhacPmsKcResNtaenRH/quKc+AzqEe9NLO7+hN1P
         +jm+zX7qzysClGK1QFjvAIxdTN9+3QI4momwRIsCNkaeQRMmT+HfDznDfGwvFy1GjtcN
         9MXuoiYxZApNgKqvgzferDiDYZjhvbwLsdb/dbMK25FWwLe6OOY3z8KhZIVRy0F7/8L4
         UhZaDEbdGaNY1w5d6Eub1jMpvol1aGV35y8/rNwIicLyOf9AVcDMq7mAyy9sNsNusLBf
         uc1Q==
Received: by 10.66.87.163 with SMTP id az3mr114944619pab.62.1351807931162;
        Thu, 01 Nov 2012 15:12:11 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id nd6sm4615065pbc.68.2012.11.01.15.12.09
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 15:12:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAO54GHDRBDyQYvo-g_xEvsQJRgtfbbT-4-kop8hoSK1D37G44w@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208893>

Kevin wrote:

> As I see it, the problem is not the possibility to add new lines, but
> colleagues being too lazy to add them.

I suspect the underlying problem is that we make it too hard to tell
git which text editor to run.

Ram, what platform do your colleagues use?

Thanks,
Jonathan
