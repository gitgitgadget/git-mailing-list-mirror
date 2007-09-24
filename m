From: mkraai@beckman.com
Subject: Missing strptime
Date: Mon, 24 Sep 2007 16:35:34 -0700
Message-ID: <OF8EBEA0A7.5425E9EA-ON88257360.00812AEA-88257360.00819919@beckman.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 01:59:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZxpf-0003EM-W4
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 01:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756086AbXIXX7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 19:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755504AbXIXX7K
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 19:59:10 -0400
Received: from svfulbcimail.beckman.com ([134.217.237.26]:38379 "EHLO
	mailgateful1.beckman.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755048AbXIXX7J (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2007 19:59:09 -0400
X-Greylist: delayed 1410 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Sep 2007 19:59:09 EDT
X-WSS-ID: 0JOWC8Q-04-4R1-01
Received: from mailgateful2.beckman.com (unknown [10.12.37.100])
	by mailgateful1.beckman.com (Tumbleweed MailGate) with ESMTP id 3546C1005B71A
	for <git@vger.kernel.org>; Mon, 24 Sep 2007 16:36:25 -0700 (PDT)
X-WSS-ID: 0JOWC8Q-01-8T9-02
Received: from svfulnotes1.beckman.com (svfulnotes1.beckman.com [10.12.38.60]) by
 mailgateful2.beckman.com (Tumbleweed MailGate) with ESMTP id 3AF4C381C3964 for
 <git@vger.kernel.org>; Mon, 24 Sep 2007 16:36:26 -0700 (PDT)
X-Mailer: Lotus Notes Release 6.5.4 March 27, 2005
X-MIMETrack: Serialize by Router on SVFULNOTES1/BII(Release 6.5.5|November 30, 2005) at 09/24/2007
 04:42:00 PM, Serialize complete at 09/24/2007 04:42:00 PM
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59081>

Howdy,

I'm porting Git to QNX.  Its C library doesn't provide strptime, so I'd 
was planning to use the Gnulib implementation.  Is that OK?  If so, should 
I try to leave it as close to upstream's version as possible or should I 
remove all of the unneeded cruft?  If not, is there an alternative 
implementation I should use?

Matt

P.S. Sorry for the footer.

The server made the following annotations 
---------------------------------------------------------------------------------
This message contains information that may be privileged or confidential and is the property of Beckman Coulter, Inc. It is intended only for the person to whom it is addressed. If you are not the intended recipient, you are not authorized to read, print, retain, copy, disseminate, distribute or use this message or any part thereof. If you receive this message in error, please notify the sender immediately and delete all copies of this message.

---------------------------------------------------------------------------------
