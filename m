From: Christoph Duelli <duelli@melosgmbh.de>
Subject: restriction of pulls
Date: Fri, 9 Feb 2007 11:49:12 +0100
Organization: MELOS GmbH
Message-ID: <200702091149.12462.duelli@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 11:55:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFTPK-0003Bi-3n
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 11:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946298AbXBIKzH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 05:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946356AbXBIKzH
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 05:55:07 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:53746 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946298AbXBIKzF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 05:55:05 -0500
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Feb 2007 05:55:05 EST
Received: from gw2.melosgmbh.de (p549B02B9.dip0.t-ipconnect.de [84.155.2.185])
	by post.webmailer.de (mrclete mo18) (RZmta 4.5) with ESMTP id F03c75j19ABCCu
	for <git@vger.kernel.org>; Fri, 9 Feb 2007 11:48:16 +0100 (MET)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.073,BAYES_00: -1.665,TOTAL_SCORE: -1.592
X-Spam-Level: 
Received: from duelli.melosgmbh.de ([172.27.1.229])
	by gw2.melosgmbh.de (Kerio MailServer 6.3.0)
	for git@vger.kernel.org;
	Fri, 9 Feb 2007 11:48:14 +0100
User-Agent: KMail/1.7.1
Content-Disposition: inline
X-RZG-AUTH: hvKqOO6Ph79JHUJJIwMxXgzUdNi97hMDGc5n+ojdbo9B56/YXBysNp6yRT6vKXIWMkPu
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39174>

Is it possible to restrict a chechout, clone or a later pull to some 
subdirectory of a repository?
(Background: using subversion (or cvs), it is possible to do a file or 
directory-restricted update.)

Say, I have a repository containing 2 (mostly) independent projects A and B 
(in separate) directories:
- R
  -  A
  -  B
Is it possibly to pull all the changes made to B, but not those made to A. 
(Yes, I know that this causes trouble if there are dependencies into A.)


Regards
-- 
Christoph Duelli
MELOS GmbH
