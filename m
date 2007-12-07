From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: In future, to replace autotools by cmake like KDE4 did?
Date: Fri, 7 Dec 2007 03:10:36 +0100
Message-ID: <998d0e4a0712061810k18e6388jde9d7bc5bd006b57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: gcc@gcc.gnu.org, git@vger.kernel.org,
	"David Miller" <davem@davemloft.net>,
	"Daniel Berlin" <dberlin@dberlin.org>,
	"Ismail Donmez" <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Fri Dec 07 03:11:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Sg7-0007pC-6M
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 03:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbXLGCKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 21:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbXLGCKi
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 21:10:38 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:7187 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbXLGCKh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 21:10:37 -0500
Received: by wr-out-0506.google.com with SMTP id c49so398297wra
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 18:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=EQ9Vw2LtzRk8+0wX5/KdGn8ohXghA3SRMEzD04Y5BSE=;
        b=F9fPw8kDaYoIDBhNKpG+J+uHuNcE5VJDEAD5vnN16MtRIIBQtyK1XE9p+G3k5+nodeJ1M56TqL68kICMJZwqeckQJCPVYXy4t/X2YFgmJrH0fnd2K1USRXr6Ipkzazjv8DoZU9UNY0oXC6LKAUDzfteQFZ47ToOLMDLPGCut2qw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TXrjTyoTSIJzFiU+WkA0qGk3/3DnFW+p/as0cJlY3h4sztHx28T50okfqfUYraDrcnWtUa+t+ElN0l9MjdlV+b8ON5YuTmtzenogqgBUVgd3zJdW8QEVAaCl4HFyYZgomCsj+wOIAxzYXB1nxEJXrDf+bZyHQwVCia0XCiTchfA=
Received: by 10.70.118.4 with SMTP id q4mr1794929wxc.1196993436099;
        Thu, 06 Dec 2007 18:10:36 -0800 (PST)
Received: by 10.70.54.17 with HTTP; Thu, 6 Dec 2007 18:10:36 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67366>

The autotools ( automake + libtool + autoconf + ... ) generate many big
files that they have been slowing the building's computation and growing
enormously their cvs/svn/git/hg repositories because of generated files.

To see below interesting links:
1. http://dot.kde.org/1172083974/
2. http://sam.zoy.org/lectures/20050910-debian/
3. https://lwn.net/Articles/188693/
4. http://en.wikipedia.org/wiki/GNU_Build_Tools
5. http://en.wikipedia.org/wiki/GNU_Automake

The benefits could be:
* +40% faster in the KDE4 building vs KDE 3.5.6.
* elimination of redundant and unnecesary generated files as those
  from autotools.
* smaller cvs/svn/git/hg repositories.
* less errors/crashes when it's configuring.
* can be improved the cmake's sources for better performance's gain.
* good and long maintainance life.

I hope if the files for cmake+make can be well integrated in GCC 4.4

   J.C.Pizarro
