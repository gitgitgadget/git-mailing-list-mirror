From: mkraai@beckman.com
Subject: Email address from username and hostname preferred over $EMAIL
Date: Thu, 5 Jul 2007 10:57:37 -0700
Message-ID: <OF40A04FE5.AA34B1BF-ON8825730F.005D733A-8825730F.0062A716@beckman.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 05 20:54:23 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6WT8-0004dl-Sq
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 20:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760329AbXGESyO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 14:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760245AbXGESyN
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 14:54:13 -0400
Received: from svfulbcimail.beckman.com ([134.217.237.26]:34260 "EHLO
	mailgateful1.beckman.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760180AbXGESyM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2007 14:54:12 -0400
X-Greylist: delayed 1592 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jul 2007 14:54:12 EDT
X-WSS-ID: 0JKPY46-04-E9C-01
Received: from mailgateful2.beckman.com (unknown [10.12.37.100])
	by mailgateful1.beckman.com (Tumbleweed MailGate) with ESMTP id 10F971005A19C
	for <git@vger.kernel.org>; Thu,  5 Jul 2007 11:31:13 -0700 (PDT)
X-WSS-ID: 0JKPWPE-01-HL0-02
Received: from svfulnotes1.beckman.com (svfulnotes1.beckman.com [10.12.38.60]) by
 mailgateful2.beckman.com (Tumbleweed MailGate) with ESMTP id 82A4B38084390 for
 <git@vger.kernel.org>; Thu, 5 Jul 2007 11:00:49 -0700 (PDT)
X-Mailer: Lotus Notes Release 6.5.4 March 27, 2005
X-MIMETrack: Serialize by Router on SVFULNOTES1/BII(Release 6.5.5|November 30, 2005) at 07/05/2007
 11:03:24 AM, Serialize complete at 07/05/2007 11:03:24 AM
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51689>

Howdy,

Git prefers to use an email address constructed from the username and 
hostname to the value of the EMAIL environment variable.  I think it 
should prefer the latter to the former.  This problem was introduced by 
ec563e8153cba89728a271a26c8a94e7a42d8152.

-- 
Matt

The server made the following annotations 
---------------------------------------------------------------------------------
This message contains information that may be privileged or confidential and is the property of Beckman Coulter, Inc. It is intended only for the person to whom it is addressed. If you are not the intended recipient, you are not authorized to read, print, retain, copy, disseminate, distribute or use this message or any part thereof. If you receive this message in error, please notify the sender immediately and delete all copies of this message.

---------------------------------------------------------------------------------
