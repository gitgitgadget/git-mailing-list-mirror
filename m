From: Ark Xu <ark.work@gmail.com>
Subject: git svn bug?
Date: Thu, 2 Oct 2008 16:50:45 +0800
Message-ID: <36C9BCCC-875A-4C65-98E2-0AD486FF8F61@gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 10:52:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlJul-0006fX-4c
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 10:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbYJBIux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 04:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbYJBIux
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 04:50:53 -0400
Received: from ti-out-0910.google.com ([209.85.142.186]:5188 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbYJBIuw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 04:50:52 -0400
Received: by ti-out-0910.google.com with SMTP id b6so407323tic.23
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 01:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=+/pSZRUVYVTo93EwEnPlxoi1HgUXRb4boNVq0JGo+fY=;
        b=rkE6DbfyxMWmNWh2SlsmEMgaJQr+VvyEb1HkgZBrb4Gr5kw/GYVgcEGQcV4rJa56FC
         8+mOJq62pV3ZpViUabcQ5QdGj6okerJBD0QBNxpLOnxviQwkJakCQl2/pm39Sr0b8I+o
         uz0BVfIQTbk0+PBZv2DPmsv8B+OAnUAaP4y0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=tSY7dPyVVUTE99Fm8HeGLIizNY+PtoEbqJ8h2n3G3JQSxjrhOnGBUH+SWFzhbYAHeh
         /Ci0P9Guia0QJesU2VVAYTUSzytVM2bIUSFRYNI/LYmw7LOHA4Yd8JKcSSdjT2vrLcTW
         8X6pdMKYxDuvP36HiyNGplmfkbCV/BYdsal1I=
Received: by 10.110.52.1 with SMTP id z1mr13645386tiz.19.1222937449170;
        Thu, 02 Oct 2008 01:50:49 -0700 (PDT)
Received: from ?192.168.1.222? ([61.171.68.52])
        by mx.google.com with ESMTPS id 2sm3541390tif.0.2008.10.02.01.50.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 01:50:48 -0700 (PDT)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97295>

Hi guys,

   I like git very much so I also use git svn for subversion repo.

   Now I got a tough problem which stopping me for any svn related  
operations. There is a file log4j.xml that is somehow strange because  
when I fetch it, i got the following message:

tms-service/src/test/resources/log4j.xml has mode 120000 but is not a  
link at /opt/local/bin/git-svn line 3230.
M	tms-service/src/test/resources/log4j.xml

   And then, all the operation will lead to :
Checksum mismatch: branches/5.3/tms-service/src/test/resources/ 
log4j.xml 51031cbb0e1a2e878e4a3836cf0baa9b80a037a5
expected: fab6daef9fc355b9342e26047f5d0141
      got: 0e7e9081d608c80d2de0340ba5cd1600

Could anybody help?

regards,
Ark
