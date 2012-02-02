From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: how to determine oldest supported version of git
Date: Thu, 2 Feb 2012 13:23:40 -0600
Message-ID: <20120202192124.GA19873@burratino>
References: <jgeekn$of2$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 20:24:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2GQ-0002XR-7R
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 20:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932812Ab2BBTYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 14:24:04 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43090 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932687Ab2BBTYC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 14:24:02 -0500
Received: by iacb35 with SMTP id b35so3530234iac.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 11:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Q5/1Z4WSXwgdOzB6ueqd48uBAt851Y9lIulKEbM0oY0=;
        b=i/1tEBOlHwIsmSQtSD+soUoK5TeYW2wuBLr3ZWt9zFRrayq9JXxC5EbG1aSJsOz49S
         Gn+ou2T7q58kF6VKZEo34IGjOzCCjzUhbzjb4q8OhL4W55/l5rNr39sgVv4zXzWRrf7O
         VaGY0qcejiiW2KuPsHVauW8FC3PB4CSOa5AUw=
Received: by 10.42.132.137 with SMTP id d9mr3928614ict.3.1328210641641;
        Thu, 02 Feb 2012 11:24:01 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id cv10sm1125527igc.0.2012.02.02.11.24.00
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 11:24:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <jgeekn$of2$1@dough.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189678>

Hi Neal,

Neal Kreitzinger wrote:

> What is the best way for me (a git user) to determine what is currently the 
> oldest supported version of git (the oldest version still getting bugfixes)? 
> IOW, when can I tell that my version of git is no longer supported?

It depends what supported means.  Even very old git releases might get
point updates to fix major problems such as security bugs.

If you want to see which branches Junio is actively maintaining,
looking at the last commit date from the maint-* branches on [1] is
one way.

However, in my experience people interested in product lifetimes more
often mean "versions the vendor will respond to bug reports about"
rather than "versions getting updates".  If you have discovered a bug
in an old version of git, even if it is only a couple of major
releases ago, a good debugging strategy is almost always to try with
the newest release and see if it still exhibits the bug.  If you don't
try that, people on this list might just try it themselves.  If it
doesn't affect recent releases, I would not be surprised if people on
this list do not necessarily care much.  One can more easily interest
me at least by pointing out which regression is making it hard to
upgrade instead.

Thanks,
Jonathan

[1] git://github.com/gitster/git.git
