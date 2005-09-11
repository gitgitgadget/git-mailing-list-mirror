From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: git-rev-list and git-format-patch script oddness
Date: Sun, 11 Sep 2005 20:52:51 +1200
Message-ID: <46a038f905091101529e045af@mail.gmail.com>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Sep 11 10:53:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EENaM-0005wm-5k
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 10:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVIKIw4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 04:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVIKIw4
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 04:52:56 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:13943 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932451AbVIKIwz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 04:52:55 -0400
Received: by rproxy.gmail.com with SMTP id i8so244454rne
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 01:52:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aNvJ1IgsqGSY8iGzq1LCIO2275cXNEv9UoJMEDfQYT+GqFTxWqVqIuJa8eDBSWHqwMKXosmcfcwxveTo4/U5A2dhYDuBofmSAS/XFZ+3VuRBUgIlrI68M5fRbpDam/eImScL4Q/iQjU14EL0+tOeKnrah2D8gQ36fU3IuBCUlII=
Received: by 10.38.181.7 with SMTP id d7mr189592rnf;
        Sun, 11 Sep 2005 01:52:51 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Sun, 11 Sep 2005 01:52:51 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8278>

When I run git-format-patch, it insists on outputting merges that have
already been merged upstream, regardless of the fact that
git-merge-base knows better.

Is there a way to get it to skip merged-in patches that git already
has detected as merged upstream?

cheers,

martin
