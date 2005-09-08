From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: gitweb feature request: tarball for each commit
Date: Thu, 8 Sep 2005 16:30:22 +1200
Message-ID: <46a038f905090721305dcbf61@mail.gmail.com>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Sep 08 06:34:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDE45-0002eF-G5
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 06:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbVIHEaw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 00:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVIHEaw
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 00:30:52 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:16823 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751328AbVIHEaw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 00:30:52 -0400
Received: by rproxy.gmail.com with SMTP id a36so1053929rnf
        for <git@vger.kernel.org>; Wed, 07 Sep 2005 21:30:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bWcS+MCU0WD+SqDoCD+WaHxy0bzsBHYeHIeQ34iAMS8Kt1Xghh5qeqb4fYvpfcp5TkVDA5zQgI8UmLLZ+AkatCtvB9P0/R4wre5NGEgS3L+VIrWF3g02r5/uVp7KIuKhQauhT0UNfaycbJqWjwZvoJsOwvkycz110+HNPWrdpew=
Received: by 10.38.101.34 with SMTP id y34mr1749292rnb;
        Wed, 07 Sep 2005 21:30:42 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Wed, 7 Sep 2005 21:30:11 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8194>

With Archzoom, when looking at a particular commit/cset you get a
small "[tarball]" link that does an 'export' of the whole tree at that
patchlevel and tars it up for the user. It's heavy on the server and
bandwidth, but if you can afford it, it is mighty useful to push out
patches immediately to non-git-using end users.

Here's an example of an archzoom page --- it's among the top-right
links. I'm sure we could do something like this with git-tar-tree...

Actually... should get it done. I'll see if I can sneak it in sometime soon... 

cheers,


martin
