From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Fri, 2 Jun 2006 20:09:16 -0400
Message-ID: <9e4733910606021709g4156f814md543f51b6a8eb2e8@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149204044.27695.38.camel@neko.keithp.com>
	 <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
	 <1149214075.5521.31.camel@neko.keithp.com>
	 <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com>
	 <1149219593.5521.34.camel@neko.keithp.com>
	 <9e4733910606012047h727a25f1vb367c880f8933c4e@mail.gmail.com>
	 <1149220518.5521.43.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 03 02:09:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmJhm-0003wo-FI
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 02:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbWFCAJT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 20:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWFCAJT
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 20:09:19 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:10270 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751609AbWFCAJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 20:09:16 -0400
Received: by nz-out-0102.google.com with SMTP id s18so744586nze
        for <git@vger.kernel.org>; Fri, 02 Jun 2006 17:09:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d0krLg18BdjAdZIa0EtoJNtwT7/NxlDoDe0f4da6wL2QIZ+7hDRGrpaoHdN0Wx4vENCVL5wEaQwk5N74/aAkM7Qu+RRPsDx0cVXAPo9mJo0/9KFSgG9Upxm07CHAtxPN3+VKNNr4TVVPmzgf4w6mOQPDn9PUnbw9jshgZQ7i5hw=
Received: by 10.36.46.17 with SMTP id t17mr2726036nzt;
        Fri, 02 Jun 2006 17:09:16 -0700 (PDT)
Received: by 10.36.39.3 with HTTP; Fri, 2 Jun 2006 17:09:16 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>
In-Reply-To: <1149220518.5521.43.camel@neko.keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21180>

If I parsecvs this pair it fails:

/home/jonsmirl/mozilla/mozilla/dom/src/base/nsFocusController.h,v
/home/jonsmirl/mozilla/mozilla/dom/src/base/nsGlobalWindow.cpp,v

[jonsmirl@jonsmirl foo]$ ../parsecvs <sm2
defaulting to local storage area
Load:                nsGlobalWindow.cpp,v ....................*     2 of     2
Warning: branch point MOZILLA_1_0_BRANCH -> master matched by date
fatal: Not a valid object name (null)
git-read-tree '(null)' failed
[jonsmirl@jonsmirl foo]$

But parsecvs works on each of them individually.

-- 
Jon Smirl
jonsmirl@gmail.com
