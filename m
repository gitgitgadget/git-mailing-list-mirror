From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Problems with git over http
Date: Sat, 20 Sep 2008 14:42:08 -0700 (PDT)
Message-ID: <m3wsh6lck1.fsf@localhost.localdomain>
References: <264855a00809201013h6003abbfr9bbdd20c92e9201d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sean Davis" <sdavis2@mail.nih.gov>
X-From: git-owner@vger.kernel.org Sat Sep 20 23:43:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhAEc-0001FV-7f
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 23:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbYITVmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 17:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbYITVmN
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 17:42:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:8344 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbYITVmM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 17:42:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so940993fgg.17
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 14:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Eh7Sem3r3itPN3L2xkbQDRVv+Nv3csRYoy7wmYwjNO0=;
        b=Y2szAVgKcYgsA674W3Lts9y3rnMuJDmODGBa/qcnJ/MqRsNRsBDqV324YuChzDIDtJ
         fclFryb34ECn9/Al57F7m3l4pBXxCYCH/tSB+2oS9/4Dyui7VBDCHWxJZbTteb884z/0
         yv7ZwP4RfiS68CzRoaXVCPZF9mb27gK8tfla4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=o0PC8Lr3qKEdRwYJCK6SIxVbVGmwiePY3ZXb7uAEtwIUbXq+jniU64vX1Ov8n/DYcq
         DLDjtT9plqRy87Sw2F618mlzl1zavEYdhOFd9O6EGsp29wEos81R5gFCg+EY4e/C/857
         QqhlgaQ+MiookRdUnRGJc0q2hL3zFJED5A7BU=
Received: by 10.86.68.1 with SMTP id q1mr3440132fga.2.1221946929583;
        Sat, 20 Sep 2008 14:42:09 -0700 (PDT)
Received: from localhost.localdomain (abvc201.neoplus.adsl.tpnet.pl [83.8.200.201])
        by mx.google.com with ESMTPS id 4sm3742845fge.8.2008.09.20.14.42.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 14:42:08 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8KLg8N7001221;
	Sat, 20 Sep 2008 23:42:08 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8KLg70A001218;
	Sat, 20 Sep 2008 23:42:07 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <264855a00809201013h6003abbfr9bbdd20c92e9201d@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96367>

"Sean Davis" <sdavis2@mail.nih.gov> writes:

> I am new to git and trying to set up a remote repository over http.  I
> have configured apache2 and the bare, empty repository.  Using curl, I
> can get the file HEAD without a password (seems .netrc is correct?).
> However, when I try to push to the repository, I get the following:
> 
> sdavis@lestrade:/tmp/testing> git push
> http://sdavis@watson.nci.nih.gov/git/sean_git.git/ master
> fatal: exec http-push failed.
> error: failed to push some refs to
> 'http://sdavis@watson.nci.nih.gov/git/sean_git.git/'

Errr... to _push_ via https you have to enable WebDAV.
See Documentation/howto/setup-git-server-over-http.txt
-- 
Jakub Narebski
Poland
ShadeHawk on #git
