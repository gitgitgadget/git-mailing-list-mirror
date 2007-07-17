From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Seeing differences at origin/branch?
Date: Tue, 17 Jul 2007 16:53:03 +0100
Message-ID: <18071eea0707170853r41962edfge603ccec7b2e72cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 17:53:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IApMO-0003Kk-95
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 17:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbXGQPxI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 11:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752251AbXGQPxH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 11:53:07 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:33218 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbXGQPxE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 11:53:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2032462wah
        for <git@vger.kernel.org>; Tue, 17 Jul 2007 08:53:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=S7Txb7gd//elkTRd+GccGGyxuMHpPHiQnaoRr8RqTBtbr7zTryPJmu8nay4SMR4lHc3oCwgPrXvPc8EHfe+zKUSKXqQhFkJ1hbimHQvhuLC9x1Yw5ikcmxh+NhrB75UTmj378BFrdu1LrhGZHUGx+7AdAXSAlnojDLZxkR0u9O4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kn0wlRUB/4Hg5K4S0Z9ojx0y4Fbd47ztL+WIUx2+LENHIvzx3+VyfS56UimBgjs/EhT88u75YqPJc/sf/UZkrWi7rWAo5vhctNMSNvxP3ptO9qOTQDVcVhIisqgQeZ1X8xNV6LMRMW1aUy7Pe9R53Fm+wnpnMQk1Gba1p2O0mFI=
Received: by 10.115.72.1 with SMTP id z1mr542590wak.1184687583446;
        Tue, 17 Jul 2007 08:53:03 -0700 (PDT)
Received: by 10.114.134.14 with HTTP; Tue, 17 Jul 2007 08:53:03 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52764>

Hello all,

This is perhaps going to seem like a very CVS/SVN type of question,
but is there a way to see a list of differences between one's local
copy and the origin branch?  I'm after something analogous to "svn
status -u" really (yes, I know I could get my hands scorched for such
things.  :P).  Is this possible?

I've tried:

git-diff-tree -p origin/master

But that won't list changes waiting for me that I would get when I
issue a "git pull".

Many thanks,

Thomas Adam
