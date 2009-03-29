From: Lachlan Deck <lachlan.deck@gmail.com>
Subject: git svn init --username ignored
Date: Mon, 30 Mar 2009 08:56:50 +1100
Message-ID: <9FB623A2-03A6-4B35-B631-DF4745971DB9@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 23:59:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo31w-0002q1-9V
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 23:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbZC2V52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 17:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753507AbZC2V52
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 17:57:28 -0400
Received: from ti-out-0910.google.com ([209.85.142.186]:20537 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbZC2V51 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 17:57:27 -0400
Received: by ti-out-0910.google.com with SMTP id i7so1429845tid.23
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=3tzLPreQ9RLmE50Xb9HE5bl5qFYlvOydGIqj+2DyQw0=;
        b=BX3gpjoNvoPJ3E5aJKWa0K+CSATxbmiFey6AEe3IaOc+hGYcUdBD9HtVcuXBTcmW3T
         HnBfxKo+G9iu6GFvGsYWIhggkiDH+TEXFZN1pbA6DTR8ATOaGmx/5Ph8/z2aAjCtNlz8
         /A2VWEF28w1skhgS0IeGxbdyIbt69Bbm+lF0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=q+KniinJ3SA/ba/wLtD7vLg/YszXx1LDqgeB7VbsAzSEuhjxbSaD4OyjvDd3DWGQ+0
         nkZ6i/EVMd/DDSOHK9P4yKQrAKM0epwR7wgEeIARLgFDltHIWddE/47+YyXKdQ6VvOUW
         B4xaoAzhZCa2SLHwfTm+XkWrgPIwYLyvH8aeE=
Received: by 10.110.73.19 with SMTP id v19mr6446352tia.33.1238363844695;
        Sun, 29 Mar 2009 14:57:24 -0700 (PDT)
Received: from ip-144.ish.com.au (ip-144.ish.com.au [203.29.62.144])
        by mx.google.com with ESMTPS id i9sm1732554tid.13.2009.03.29.14.57.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Mar 2009 14:57:16 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115041>

Hi there,

Is it a bug that the when specifying --username=foo for either git-svn  
init or git-svn clone  that this isn't stored in .git/config?

It means that for http[s] urls you need to specify it each time for  
git-svn fetch, for example.

Is there any way to specify it manually in the config file - or would  
that have some bad consequences?

Thanks.

with regards,
--

Lachlan Deck
