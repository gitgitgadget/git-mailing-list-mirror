From: Santi <sbejar@gmail.com>
Subject: Ouput of git diff with <ent>:<path>
Date: Wed, 17 May 2006 00:24:12 +0200
Message-ID: <8aa486160605161524j5d7e672eo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 17 00:24:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg7xk-0007kr-8c
	for gcvg-git@gmane.org; Wed, 17 May 2006 00:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWEPWYQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 18:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWEPWYP
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 18:24:15 -0400
Received: from wx-out-0102.google.com ([66.249.82.201]:34640 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932214AbWEPWYN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 18:24:13 -0400
Received: by wx-out-0102.google.com with SMTP id s6so61734wxc
        for <git@vger.kernel.org>; Tue, 16 May 2006 15:24:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pJkSyA8bPTLdtMWlXinC8Fb0+EL3GD/YdjbZ0OL2d49kfUYnuG2lduriwAe0fE9Sx4unSIWbimffdQDxuPIeEGFSotWOL4WGW5SLrj0QzNFzsg8GUxKdsCx5gQCx9BZJXB2Mweq9mYF0DG7dezrfERN/3AtCHGaroiYlDO/JYqY=
Received: by 10.70.95.16 with SMTP id s16mr287873wxb;
        Tue, 16 May 2006 15:24:12 -0700 (PDT)
Received: by 10.70.20.2 with HTTP; Tue, 16 May 2006 15:24:12 -0700 (PDT)
To: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20141>

Hi *,

   just curious if this is the expected output. I find this syntax
very usefull but the "a/v1.3.3:" of even without the tree "a/:" a bit
confusing. And I didn't expect the rename from/to neither the
similarity index 0%.

diff --git a/v1.3.3:Makefile b/Makefile
similarity index 0%
rename from v1.3.3:Makefile
rename to Makefile
index b808eca..55d1937 100644
--- a/v1.3.3:Makefile
+++ b/Makefile

Thanks.

Santi
