From: "Ron Parker" <ron.parker@mobot.org>
Subject: Switching branch before commit
Date: Thu, 10 May 2007 14:43:23 -0500
Message-ID: <769697AE3E25EF4FBC0763CD91AB1B0201D496E7@MBGMail01.mobot.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 10 21:43:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmEY1-0007hU-IZ
	for gcvg-git@gmane.org; Thu, 10 May 2007 21:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323AbXEJTn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 15:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755849AbXEJTn1
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 15:43:27 -0400
Received: from mbgmail01.mobot.org ([63.78.97.14]:13299 "EHLO
	mbgmail01.mobot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323AbXEJTn1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2007 15:43:27 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Switching branch before commit
Thread-Index: AceTO3hbLuoAeOZjTeOXZ+2Avz5rAQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46889>

I know this is probably a FAQ and I thought I found it somewhere once,
but... How do I commit changes from in my working directory to another
(possibly non-existent) branch?
 
All too often I am working on changes and realize I am sitting on master
or a topic branch and I need to commit my mods to different branch.  I
really don't like:
 
    git commit
    git branch <other-branch>
    git reset --hard HEAD^
 
Is there anything like:
    git commit -b <other-branch> [<file>...]?

If not, would patches to implement such a change be accepted?
