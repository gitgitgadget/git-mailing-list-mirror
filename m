From: eduard stefan <eduard.stefan@gmail.com>
Subject: Git 1.6.5-rc git clone unhandled exception using http protocol
Date: Fri, 09 Oct 2009 20:27:50 +0300
Message-ID: <4ACF7296.3010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 09 19:29:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwJHT-0006hY-Bl
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 19:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbZJIR2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 13:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbZJIR2f
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 13:28:35 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:37977 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761212AbZJIR2f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 13:28:35 -0400
Received: by fxm27 with SMTP id 27so6601929fxm.17
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 10:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=nmf3Vr9MimAQTf2Q+33sZi71YQ66Br2Y5fgMF6tshMI=;
        b=t3u4wZA8QxNPDfBSHeB/khNX8gwmiUg9o2YSBBhmkQZ8gKSVyPpH2rj84XnZTRGm5z
         HcdKrA5v8dfaWhklz6x3EzfYIKy3v0mbjHp6BOxG9zpaZ/Lh7T1mB4GkPUvfEf73W4yV
         NXDPVZqOWbKZat4ualCV1NwVGkpmN7LeXKYCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=o2LGMh4cFHjve84l7baV5smVzh08S+cpbPhlX2Xt6M49oZ4bCs0qlNE3+kGmLRZV2T
         sJJSQK3cjy+S2vPnQUSrY+xG7zkKezUpLkX5vBnvLp2FicUDOAVdbA6EhTAuuPV/EYKC
         nN5d8DfxMs5CR9uCubtVgxNVYEzMMGFq2hWws=
Received: by 10.86.184.35 with SMTP id h35mr2635939fgf.18.1255109277677;
        Fri, 09 Oct 2009 10:27:57 -0700 (PDT)
Received: from ?192.168.2.8? ([89.136.114.133])
        by mx.google.com with ESMTPS id e20sm602330fga.15.2009.10.09.10.27.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 10:27:57 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129825>

I've tried Git 1.6.5 release candidates (rc1, rc2, rc3) with msysGit,
and "git clone git://github.com/loudej/spark.git" it's working,
but "git clone http://github.com/loudej/spark.git" crashes
with an Win32 unhandled exception.
  I have tried to create an empty repository and run both
"git remote-curl http://github.com/loudej/spark.git"
and "git remote-curl" , but it crashes with the same error.
  How can I obtain more information about the error?

BTW, Git 1.6.4.4 is working over both protocols,
on Windows Server 2008 SP2 x86, using the same msysGit
(msysGit-fullinstall-1.6.4-preview20090729.exe).

Have a nice day,
  A.
