From: "Mike Pape" <dotzenlabs@gmail.com>
Subject: Git on MSys
Date: Fri, 3 Aug 2007 11:37:43 -0400
Message-ID: <fd2562310708030837l7cc3bf1dx10297ad7a5109d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 17:37:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGzDn-0002ZS-VX
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 17:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761950AbXHCPhp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 11:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761971AbXHCPhp
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 11:37:45 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:26576 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761883AbXHCPho (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 11:37:44 -0400
Received: by wr-out-0506.google.com with SMTP id 36so311947wra
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 08:37:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Iy02gIEZNUSOlc11CrthsG2ItYwRSiI6ZfXSfRUI3OoI7r2RDTdtcjmsNNof1Trzr1BgsYQZE+T25hnKcxIiuu7Bgw0xNWOywlVnLtAxzGEvtNamd8sPbhKuch46HmDCnak8/mSyIvnzT8M693J5GllCVZpLEw8xJCPhqnab8mg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uhd7/FQG4t2Y9/pAKKHhK/QftgwWzSKklZqpYr4jLanBh1+78Zz/57c8r3MliIGBdqfWyO58DSGY/DwfV1uapi3jAYm8SQFIt0tDwsvfbROg9sQ69nRGCdEqvjs8YXo+C4GWxu5oxvt//YaM7egmR5h92y66uJcgQmIajHnPb+0=
Received: by 10.90.36.3 with SMTP id j3mr3203809agj.1186155463585;
        Fri, 03 Aug 2007 08:37:43 -0700 (PDT)
Received: by 10.90.55.17 with HTTP; Fri, 3 Aug 2007 08:37:43 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54730>

I'm not subscribed to the list, so I'm sorry I'm not continuing the
existing thread.  I've been hacking on git using a regular MSys
install but tried the new "all in one" installer.  It compiles fine
but hangs indefinitely on make install.  When GIT-VERSION-GEN runs, it
tries to run 'git diff-index --name-only HEAD' with no .git directory
and that seems to not return.  Doing the same operation (git
diff-index with no .git directory) errors and exits correctly in
cygwin.  Should there be a check for .git or is the mingw branch
missing something from the main git branch?

Mike

Please cc me.
