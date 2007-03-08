From: "Andrew Kilroy" <lemonkandy@gmail.com>
Subject: attempting to clone the git repo
Date: Thu, 8 Mar 2007 16:49:27 +0000
Message-ID: <2fb03ecb0703080849m41ac8158y4895f2bc811934f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 17:49:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPLoP-0001IZ-7O
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 17:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbXCHQta (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 11:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbXCHQta
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 11:49:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:18973 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbXCHQt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 11:49:29 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1005842uga
        for <git@vger.kernel.org>; Thu, 08 Mar 2007 08:49:28 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=C5tEY2yTTDJ/Afq93YtuWsVFAk/sNnDO7lfnCpJxsRehoNvosnu7C0Wml3Oz+h97zJZ1mEbkRPE85TRlUrf4rQLqEHFB/YCxBKtsBFr8GPGm327DQSmygGCjEHKjsXSfjUse20fIGWq6ue+OdPJHT4V7QuViSKoCvhfQQWz5gNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HKUA0eaLTgoEq/cC/hnabCBj6Sq/Tx9x71/PUUL4Q/RFzMY8EliDjMuOwFqfkbbk2TNundyx8KPXPlWXgUpjgVuJLHbonVtRbCA7yq+GvASzWwv8LrrCrAKOk5pD8iD2pcm/j8T+z8y82Hi8oTZF00favQ2fcTo8vGY1F3flp6g=
Received: by 10.114.133.1 with SMTP id g1mr210481wad.1173372567081;
        Thu, 08 Mar 2007 08:49:27 -0800 (PST)
Received: by 10.114.166.4 with HTTP; Thu, 8 Mar 2007 08:49:27 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41756>

Hi,

I'm attempting to clone the git repository using git-1.5.0.3 in my workplace.
Port 9418's blocked by the firewall, so I'm trying via http:

    $ git clone http://git.kernel.org/pub/scm/git/git.git
    Initialized empty Git repository in /home/akilroy/workspace/git/.git/
    Cannot get remote repository information.
    Perhaps git-update-server-info needs to be run there?

Is there a problem at the server?  I've tried this before using an old version
of git, and that worked (1.4.4.4 I think).

Thanks,
Andy
