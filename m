From: "Michael J. Cohen" <michaeljosephcohen@mac.com>
Subject: [RFC] OSX Mail.app IMAP cache support for git-mailsplit?
Date: Sun, 4 Nov 2007 01:49:32 -0400
Message-ID: <06FE21A2-20D0-4AAA-B0C7-35783C604B68@mac.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 06:49:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoYMp-0007o0-1d
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 06:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbXKDFtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 01:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbXKDFtf
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 01:49:35 -0400
Received: from smtpoutm.mac.com ([17.148.16.79]:50716 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041AbXKDFtf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 01:49:35 -0400
Received: from mac.com (asmtp010-s [10.150.69.73])
	by smtpoutm.mac.com (Xserve/smtpout016/MantshX 4.0) with ESMTP id lA45nYYc000956
	for <git@vger.kernel.org>; Sat, 3 Nov 2007 22:49:35 -0700 (PDT)
Received: from mac-pro.lan (c-71-196-112-35.hsd1.fl.comcast.net [71.196.112.35])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp010/MantshX 4.0) with ESMTP id lA45nWeM019215
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sat, 3 Nov 2007 22:49:34 -0700 (PDT)
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63354>

Trivially, adding support for checking for Messages/ inside the  
specified Maildir after cur/ is found not to exist would be enough to  
make this work.

Is there interest in a patch for this at all?

-mjc
