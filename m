From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: replaying commits against CVS
Date: Mon, 12 Sep 2005 18:56:42 +1200
Message-ID: <46a038f905091123564b663062@mail.gmail.com>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Sep 12 08:57:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEiFD-0002wT-0i
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 08:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVILG4n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 02:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVILG4n
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 02:56:43 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:62568 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751185AbVILG4n convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 02:56:43 -0400
Received: by rproxy.gmail.com with SMTP id i8so315414rne
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 23:56:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LTKqSB/1duZh2/8jd/FPtYTHEFXT2knNvFXXGGTShXRlW9ybYBlHP4UPlDEXqZFWpBkA8I9jQGnT1V63d8PLP0DLJq6V7aUsHQZgeXMc3U4R5Z6Hvd8Q6IqwojuZ1A3/xpX8oHejWHHZG/u3XtTWkKe4TEkO9RYdgP7CVJygYAk=
Received: by 10.38.79.78 with SMTP id c78mr261718rnb;
        Sun, 11 Sep 2005 23:56:42 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Sun, 11 Sep 2005 23:56:42 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8370>

I am not looking for a full-blown 2 way gateway. But we do work quite
a bit on some projects where the upstream is using CVS, and it'd be
great to be able to replay our history against CVS. (And thus, when
the commits are echoed back, git-cherry will do the right thing and
skip them).

My current plan is to take git-apply-mbox and transform it to perform
the nasty deed. But smarter people have been merging mbox-formatted
patches automatically for ages, and perhaps there's a script out there
that is known to work reliably.

cheers,


martin
