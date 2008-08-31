From: "Weyert de Boer" <weyert@gmail.com>
Subject: Problems with using git svn dcommit
Date: Sun, 31 Aug 2008 09:29:22 +0200
Message-ID: <c7d83d0d0808310029s15c1413m49cad5c68a568271@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 31 09:39:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZhX1-0006Qg-6s
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 09:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbYHaH3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 03:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbYHaH3Z
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 03:29:25 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:25922 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbYHaH3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 03:29:24 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1421874rvb.1
        for <git@vger.kernel.org>; Sun, 31 Aug 2008 00:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=0sW4p7v8pvDR6l0n5fgeo+JcM96XntSAkRYtdqyGxRQ=;
        b=Rs1qO2cTTAY24+SzRoPg9ejy8CDqTcn2CGHJ6YUgi0lcQE63j2zjMR2/ey3UbzqKXu
         mwn2z0fwvRRm4FolzW5v3hQqZETTIQiEYhdIhXkiS5ipdMmhdx3WuYhu5gB4kYKy3ULy
         Ep9zW6Nmn73sIR0pN38wTaG0t9KRy5vHmvzuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=r1IYVsYGzJW20m8eiQw8QT9gGDc+iHmrgcfofl/Fbnk5yRVD3TYQr+hMzFzetbebrZ
         V960AdoJZt7BJ0m+PnhYngZs6gp7yirVoaRuFzXUwYDoJdA5vfNKx6EtecaC3fQt7t1/
         Vi3X8c8FOEwjfgr8Ti0redVmXFYchNzfenJOI=
Received: by 10.140.144.6 with SMTP id r6mr2573305rvd.293.1220167763013;
        Sun, 31 Aug 2008 00:29:23 -0700 (PDT)
Received: by 10.140.203.3 with HTTP; Sun, 31 Aug 2008 00:29:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94462>

I have initialized a GIT repository for using a subversion repository
hosted at beanstalk.com. Only I have problems with it. Each time I try
to trigger GIT SVN DCOMMIT. I am getting the following error message:

Can't call method "full_url" on an undefined value at
/opt/local/libexec/git-core/git-svn line 425.

Really strange on other repos it's working fine. Anyone might know
what could cause this?

Here you can find some output:
http://www.dustyfrog.nl/dropbox/git-svn-1.txt
http://www.dustyfrog.nl/dropbox/git-svn-2.txt

I am currently using GIT 1.6.0.1 on MacOSX 10.5.4 installed via MacPorts
