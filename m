From: Erez Zilber <erezzi.list@gmail.com>
Subject: gitweb stops working sometimes
Date: Mon, 10 Aug 2009 11:01:43 +0300
Message-ID: <ce513bcc0908100101u70ade553h9d7dc413cb6a276d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 10:01:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaPpH-0003RV-FA
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 10:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbZHJIBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 04:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbZHJIBn
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 04:01:43 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:33155 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbZHJIBm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 04:01:42 -0400
Received: by an-out-0708.google.com with SMTP id d40so3210512and.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 01:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=M92svYf7aHQ8UvXLPXsLXMNPnJipxPIk9uxG/AMuuMI=;
        b=JZsBvOrLWUa0ytMkb4uhSDS//u4coAq+PswQ3No2ecbcBbkO2D0Sfpb4yv73bYjIE1
         DSf+tyIwnWcT44UOxjUQ+Gmu8pxJR5Hy+yPwgYwwT8beaBpMeucz5uMKk8yRnHiXr5eW
         ySoATF4FXb1OA9ftKOR/8hEINGIHWJ2tRVeHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=OJDLLQDdSkdTJt4I04jrpabpN0ysyzrnFZwQBK4Okl9jP0WIT1E430Vs2Mv9jb3ReE
         WWaNs5+G8/j57u1Pu60fFF3bXVkJez8uMPxgBSjI7mAf0P1aGqqm2ET4lx60J6kA/cQR
         Ah9cDoAfmBA+ZGbCZCNSlSW0trDLoSnRxdTOY=
Received: by 10.100.111.7 with SMTP id j7mr3094890anc.179.1249891303565; Mon, 
	10 Aug 2009 01:01:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm running gitweb on a centos 5.3 server and it works well 99% of the
time. Sometimes, I see the following behavior:
1. I'm able to load the page that shows all git trees.
2. When I click on one of the links that should show a specific tree,
it opens a page with the following text: "<div
class="title">&nbsp;</div>
"

If I restart httpd, it doesn't help. The only solution that I found so
far is to reboot the server and then everything works. However,
rebooting the server is a bad solution.

Any idea?

Thanks,
Erez
