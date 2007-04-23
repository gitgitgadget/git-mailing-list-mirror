From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: adding file by absolute name -- problem
Date: Mon, 23 Apr 2007 12:39:03 +0300
Message-ID: <f36b08ee0704230239i4892983q4feb4a1872a320ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 11:39:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfv0o-00027u-UX
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 11:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965686AbXDWJjH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 05:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965692AbXDWJjH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 05:39:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:52647 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965686AbXDWJjE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 05:39:04 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1719681wxd
        for <git@vger.kernel.org>; Mon, 23 Apr 2007 02:39:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mape1FqWdfXLWdkUuv3jpscF01D5H4ADq3+aMgnOutwxRvx+7Hoy5B2UXE+fBr/Siccfy+dvqZ4but0RKndPXMdEmzw4kqUViSNdHwoLBPfD4olkI6BGBP6PM90rrkMjGqXo7Hsv3Sb1jIfq+Om2F5smrNO8uHxWNpaID5Imclk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CDWFfzL3pedn8Q2dLwdlqpgicw6KLYeZ3KN3BiaUZ3i9qUDmsRxPlRM8pec3ZCDaMCzOCFdTWOGdm0m9Rx1OjXVlqtYzxEEhMD9o1Q++wpEudIYDGu1GLyojh9chGzoZqMMmQIviTcUIPotlXMe4lJmfIU0F5UveXNywLK9rxXs=
Received: by 10.90.98.3 with SMTP id v3mr4403296agb.1177321143663;
        Mon, 23 Apr 2007 02:39:03 -0700 (PDT)
Received: by 10.90.73.8 with HTTP; Mon, 23 Apr 2007 02:39:03 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45308>

When I give absolute pathname /a/b/repo/d to git add, it
mostly does not work. I get errors from git-add. Is it by design ?

(When I cd to repo and fo 'git-add d', it works. But
'git-add `pwd`/d' gives error. I use scrits that wrap git-add
and give it mostly absolute names, and they fail).

Besides, I get infinite loop in git-add (1.5.1.1) when several
absolute names are given to git-add. I am trying to investigate it

Yakov
