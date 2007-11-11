From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Local branch to remote branch translation
Date: Sun, 11 Nov 2007 13:02:00 -0500
Message-ID: <9e4733910711111002x2f8cabf7yce263faf7b33bde1@mail.gmail.com>
References: <9e4733910711110954m3ed3f9adtf19ca15dff61f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 19:02:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrH8Y-00059z-W2
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 19:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756403AbXKKSCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 13:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756374AbXKKSCD
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 13:02:03 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:3689 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756313AbXKKSCB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 13:02:01 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1271351wah
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 10:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HgcgXw5le7ATpV/wFl/YCFwR2d71HvYAx1/BEp+4KgU=;
        b=lXKJtCACEdtai9L1od0Q8ItMZqn/fqqwAMapR26WXe1EnevT/+eJl9B15Wpbd6HGJE69hXfWnKMVjo6QBqZcOWSzKLogMx6wdnv9ZRIxrh8Xn3RbW1rHGWRHR6Ohi4yK+zST0GAu9ZcPiwS2/GklXHy30bWyJ/bnMP9VsYsuu7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BldISocMw0MHotipTonuC2ystwr79pazLXVOJX/3H0XIqC87tUOJ1KlhqGGSRHkFCv7Ss7VvY6tbGtrvSDE3Du0AqUkpTo1vNSDYJjqN4xDh8HLjnDE+UOFUKfZNS9aHgtY4+faM8ROCf3U4jo5KBC598xtC6WQkCteRbHJDoYg=
Received: by 10.114.144.1 with SMTP id r1mr1109673wad.1194804120591;
        Sun, 11 Nov 2007 10:02:00 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Sun, 11 Nov 2007 10:02:00 -0800 (PST)
In-Reply-To: <9e4733910711110954m3ed3f9adtf19ca15dff61f0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64490>

Is the remote config not correct?

[remote "dreamhost"]
        url = ssh://jonsmirl1@git.digispeaker.com/~/mpc5200b.git
        fetch = +refs/heads/*:refs/remotes/dreamhost/*
        push = +refs/heads/*:refs/remotes/linus/*


-- 
Jon Smirl
jonsmirl@gmail.com
