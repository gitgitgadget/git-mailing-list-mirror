From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Multiple pack files in .git/objects/pack
Date: Fri, 26 Aug 2005 21:25:18 +1200
Message-ID: <46a038f905082602251140dc2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Aug 26 11:26:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8aSq-0005fQ-R6
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 11:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbVHZJZT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 05:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbVHZJZT
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 05:25:19 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:1798 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751487AbVHZJZS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 05:25:18 -0400
Received: by rproxy.gmail.com with SMTP id i8so532139rne
        for <git@vger.kernel.org>; Fri, 26 Aug 2005 02:25:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YA2h4AOxBrGyqZbBHoTMoS5AdGKutuKkxIu8zx37nz9lEmEB4Z1bkSjQtUmItYCF4YFvpnTD8fObbblFjF4uYkqwxKQbRxn4559K9Jhtg+tMZFynA6r7YQ1y1d1x3RcYvo8BowNfJR/1cEBwH1fc1jOvoSD27J0zgO05qpKx7vU=
Received: by 10.38.88.55 with SMTP id l55mr1651104rnb;
        Fri, 26 Aug 2005 02:25:18 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Fri, 26 Aug 2005 02:25:18 -0700 (PDT)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7796>

I suspect I may have cancelled a git-repack-script execution, and now
a repo has a redundant pack eating 70MB. I can tell the right one by
running git-repack-script again, and nuking the "older" one, but is
there a reliable way to determine which pack is the correct one?

>From the behaviour of the http transfers, there is a pointer to it somewhere. 

cheers,


martin
