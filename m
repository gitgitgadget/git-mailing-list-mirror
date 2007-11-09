From: "Ivan Shmakov" <oneingray@gmail.com>
Subject: tracking remotes with Git
Date: Fri, 9 Nov 2007 19:44:50 +0700
Message-ID: <b1e3a35f0711090444g3c31e862g4ef4ef8139927840@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 13:45:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqTER-0004F1-5M
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 13:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757914AbXKIMoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 07:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbXKIMoy
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 07:44:54 -0500
Received: from ik-out-1112.google.com ([66.249.90.177]:26928 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbXKIMox (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 07:44:53 -0500
Received: by ik-out-1112.google.com with SMTP id c28so258269ika
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 04:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=5SyJtyJHB8DqNTRYzromEnTCsiOnKlle3mAXUBxzMfw=;
        b=dq4+S4OcqfAuDicRnETsyHdz3cTpoMGnoxFEO3stDwzEheLWyQMn7xquUZ+VQPcICln+DW5L8f/n3oqS8r4tOOoMg9OotlE1Op6x5kEXH6ET0pSnyMyIJT6ESOpXfX2PbH6EGeQL0UA0JCF8ppYqjN646iMxG6DJc5WVwH+1u9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZKXb093wJASZRdcPzBYK4ixdEAOgQVlGS3XIRlAQMY8vTeVLOV0CgEoNjcVBFHwiwN1XEfoHykPEwdWA6JSSC/VRxc6g4BApgHGz90glUgwBlew+dfBxZ6PTTp9StpTPEVTLaB2r5k7e887K3MYDSFCWDi4COn8HN6XXyyMRX28=
Received: by 10.78.149.15 with SMTP id w15mr2292614hud.1194612290738;
        Fri, 09 Nov 2007 04:44:50 -0800 (PST)
Received: by 10.78.192.2 with HTTP; Fri, 9 Nov 2007 04:44:50 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64172>

        I'm using Git (1.5.3.5 debian 1) for about a day or so, and I'm
        quite impressed that it allows tracking remote repositories
        (I've tried CVS and SVN) so easily with `git-cvsimport' and
        `git-svn'.  However, I've ran into a couple of problems with
        them:

        * it looks like `git-cvsimport' uses its own CVS protocol
          implementation which doesn't support compression; I've tried
          to clone a repository of a project hosted in CVS since circa
          1998 and it 20 MiB or so to obtain revisions until 2000 or so;
          any ways to minimize traffic?

        * how many revisions will `git-svn fetch' obtain from the SVN
          repository? I had to run it for several times to get the full
          history; I've tried to use (undocumented) `--fetch-all'
          option, but it appears to help (may be but for a little.)

        BTW, does http://.../git.git/ mean a ``bare repository (i. e., a
        would be /git/.git/) for Git''?

PS.  I wonder, if this mailing list accepts mail from unsubscribed
        `From:'s?
