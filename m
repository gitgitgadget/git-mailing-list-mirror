From: Duncan Ferguson <duncan_j_ferguson@yahoo.co.uk>
Subject: git-svn and sharing a single subversion repo to multiple clients
Date: Fri, 12 Feb 2010 08:13:28 +0000
Message-ID: <838B8633-E2B2-4833-BE09-5DCE9A13BBE1@yahoo.co.uk>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 09:20:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfqlG-0000RX-CH
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 09:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918Ab0BLIUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 03:20:20 -0500
Received: from smtp143.mail.ukl.yahoo.com ([77.238.184.74]:27138 "HELO
	smtp143.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750805Ab0BLIUU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 03:20:20 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Feb 2010 03:20:19 EST
Received: (qmail 28746 invoked from network); 12 Feb 2010 08:13:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:Subject:From:Content-Type:Message-Id:Date:To:Content-Transfer-Encoding:Mime-Version:X-Mailer;
  b=c7HMo8a7UX0C1/56SwAL6sKCIo/trIRvs/hLffgsYbGB2EAQJT2dz5k2MeKnqg9PPPlwobng87iyHoHIpHNZ2XG3kuIJ5opNeRcZp3UgG/BajmAKi6Yrs8vdBh0XoKeOO9JuO40TATDQ8vSfUYHIT2I04HjSPTTsm3RKTS7w+Zk=  ;
Received: from cpc2-dudl1-0-0-cust759.wolv.cable.virginmedia.com (duncan_j_ferguson@82.37.66.248 with plain)
        by smtp143.mail.ukl.yahoo.com with SMTP; 12 Feb 2010 08:13:37 +0000 GMT
X-Yahoo-SMTP: XvxsLIaswBDKFd9O7cZyiXj2RzudnBbDLrAPZzQs
X-YMail-OSG: hPk.oeEVM1k7wL4vGNL5bvSvl2iMJG6SZho5OxTWJVtEi3vwGz.s0Fx7qAA6adiUlG3Sx1iAt36twVjhPMDYscIQc4hAhaOUDh_OSUR5rAM4j_x16pgTrCGDTzjn6eZe8WMWzfIz7s6gQ2uf187fbfZujAPLTdUIeRpJS85W4SJX3SYCm7.R5TtYov2cC1NfHTuJ7GauH01GzZ_Gy8gYemLuVCAxjYQTNy2XNakAHJ3qZJ1STFgtfdUsXxKVSNc9
X-Yahoo-Newman-Property: ymail-3
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139662>

Hiya list,

The git-svn man page has a section on setting up a single git-svn repository and sharing it out so multiple clients can then clone it (in the section in 'BASIC EXAMPLES', starting at "The initial git-svn clone can be quite time-consuming ....").

I have tried following this but it does not work for me on 1.6.3.3

My situation is my company has a subversion repository that takes a significant amount of time to git-svn clone (many hours) due to the length of time its been used.  I work across a number of dev servers all using the same single subversion repo and dev servers are semi-regularly rebuilt.  I'd like to check out the subversion repo once on a 'stable' server and then git clone it to all the dev servers to speed up creating a new dev server (and reduce disk space), but also be able to pull any new subversion commits and also push new commits back.

What is the best/correct way of setting this up as I cannot find any other docs apart from the section in the git-svn man page that doesn't work?

Thanks

  Duncs