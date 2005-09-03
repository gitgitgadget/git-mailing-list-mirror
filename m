From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Replay on arbitrary branches
Date: Sat, 3 Sep 2005 13:11:40 +1200
Message-ID: <46a038f905090218113587f64f@mail.gmail.com>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Sep 03 03:12:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBMa9-0000yP-Mk
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 03:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbVICBLn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 21:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbVICBLn
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 21:11:43 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:37151 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750996AbVICBLn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 21:11:43 -0400
Received: by rproxy.gmail.com with SMTP id i8so442210rne
        for <git@vger.kernel.org>; Fri, 02 Sep 2005 18:11:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QIzm2m9UokhHtJ14YC3f7h3pwaUVt1yPyIuiK5PXse0FR3BJNjt+i/0x+E9AxWAf5GLhiqjLoar8gteviHUb4tR7zvnrhldGXUs3XLe1LUiLoZl1fxBy8kLeCcf0UX66yzNsCuSRFi5Tom2cI5BA/Ipe9K633kJhVU/+RFfSz0c=
Received: by 10.38.104.67 with SMTP id b67mr34041rnc;
        Fri, 02 Sep 2005 18:11:40 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Fri, 2 Sep 2005 18:11:40 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8030>

Is there a way to replay a merge on a head that GIT considers unrelated? 

I have been playing with exporting to mbox format with
git-format-patch-script, and applying those to the destination branch.
However, this drops binary files -- and I _do_ have binary files in
some of the projects I work on.

cheers,


martin
