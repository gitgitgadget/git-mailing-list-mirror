From: Tony Luck <tony.luck@gmail.com>
Subject: gitweb search in multi-headed tree
Date: Fri, 16 Sep 2005 08:39:20 -0700
Message-ID: <12c511ca0509160839391ea012@mail.gmail.com>
References: <20050912181101.GA22221@vrfy.org>
Reply-To: tony.luck@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 16 17:40:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGIJA-0004n5-3m
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 17:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbVIPPjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 11:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161093AbVIPPjV
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 11:39:21 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:45958 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161072AbVIPPjV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 11:39:21 -0400
Received: by zproxy.gmail.com with SMTP id 13so455068nzn
        for <git@vger.kernel.org>; Fri, 16 Sep 2005 08:39:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ajRSxsMmLN+uDpkLMj7Mpi42Vrx7i0A8EhfD41T/47vvGc61bfNtNHkiWzHJ+wR1eaoc67mC3dueLvHY4+mEvKR13iheBMoClIy/OBevzPErlzBC86DcrsvUph0KVf9Mx16PjokpF3mbRfyutoQKfjwdFgjPUy5Dr1a0krIlOAU=
Received: by 10.36.220.26 with SMTP id s26mr335117nzg;
        Fri, 16 Sep 2005 08:39:20 -0700 (PDT)
Received: by 10.36.58.18 with HTTP; Fri, 16 Sep 2005 08:39:20 -0700 (PDT)
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050912181101.GA22221@vrfy.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8687>

Kay,

My tree on kernel.org (.../aegl/linux-2.6.git) has two branches in
refs/heads: release
and test.  The HEAD symlink points to the release branch.

It seems that a search traverses from HEAD to root, so can only find
things in the
release branch.  I tried clicking on the "test" branch link at the
foot of the top-level
page before doing the search ... but it still seems to search from HEAD.

Any syntax I'm missing for this search?

-Tony
