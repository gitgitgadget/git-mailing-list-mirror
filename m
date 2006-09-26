From: Matthew L Foster <mfoster167@yahoo.com>
Subject: git and time
Date: Tue, 26 Sep 2006 16:23:16 -0700 (PDT)
Message-ID: <20060926232316.98065.qmail@web51009.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: mfoster167@yahoo.com
X-From: git-owner@vger.kernel.org Wed Sep 27 01:23:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSMGo-0001ND-1w
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 01:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWIZXXS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 19:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWIZXXS
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 19:23:18 -0400
Received: from web51009.mail.yahoo.com ([206.190.39.128]:61061 "HELO
	web51009.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932102AbWIZXXR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 19:23:17 -0400
Received: (qmail 98067 invoked by uid 60001); 26 Sep 2006 23:23:16 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=FeCAmESa5vFAKOMbMvrqPDWK7wpUM8VlLU2ApMS8J7AZC+JYHfCtMjnLOan05HTtFQMc6skUkTsSKRRyOpkNcBhdQwuBtPrbwSefmFjznImF8MZhTPnnboawPoyKFfJHmLpeYi/odg1YxLG8Z6jCBUnxnFwkZa8qSKaZ/4xSElg=  ;
Received: from [207.172.80.85] by web51009.mail.yahoo.com via HTTP; Tue, 26 Sep 2006 16:23:16 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27835>


After seeing how git currently accepts a remote repository's timestamp it occurred to me that
git should probably instead prefer the time a particular changeset was committed to _this_
repository. Perhaps I don't know enough about git but it seems to me the important information is
when a particular changeset was committed to this repository, all other remote/sub/parent
repositories' timestamps are secondary (or at least should be tracked separately).

-Matt



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
