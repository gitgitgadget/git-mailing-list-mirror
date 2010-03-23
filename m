From: Howard Miller <howard@e-learndesign.co.uk>
Subject: How to ignore changes on remote
Date: Tue, 23 Mar 2010 13:54:54 +0000
Message-ID: <26ae428a1003230654m50c35caci4a02e2df321f289c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 14:55:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu4ZS-0002Qk-8C
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 14:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab0CWNy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 09:54:57 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:65165 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302Ab0CWNy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 09:54:56 -0400
Received: by ewy8 with SMTP id 8so430841ewy.28
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=EJb6tY/ahwHAF3y4EHSrbLSk+6dqDIay/OxIyWb8EA4=;
        b=S+vhDvtzAA/HZy8rgtNkgIPhoS0HNXNXC3m5alrrO3/N4E69/ACg/j5sA7KLBj8zJV
         dNPjUXWxwN+zjxDulKS24R1JACvOxItw4PMPhXXzSCiWVyl2f22BfEPgdD8Yo/w66CPB
         /qgIxBt8AUUOY3oykwi9cWK4WgfHgLL1U/8vI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=kB6y1oWy+F9ZOSaOFWhdlBdyE/mn+lJCd4oqqlUCsp9giragm2H1M66bhKIX6z66Xl
         eYpcFQuFpmQFPlMhCsVmnP/RrhfmYRRIO/4SVtV6z/4Wz3XufDRFdG/yzJNNY03BnmMp
         T/HHK+TQ2oUMyvX+4wXkrwxTybBbiG8m0QJUY=
Received: by 10.239.188.139 with SMTP id p11mr582652hbh.102.1269352494687; 
	Tue, 23 Mar 2010 06:54:54 -0700 (PDT)
X-Google-Sender-Auth: fb25218595d73051
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143015>

My remote branch has changes that are not fast forward (I forgot to
merge). I have now made incompatible changes on my local branch. I
simply want to use the local version and push it to the remote. I
don't care about the remote version. I don't want to merge as there'll
be loads of conflicts and the answer will always be 'use the local
one'. Is there an easy way to do this? I can't think of anything.

Cheers!
