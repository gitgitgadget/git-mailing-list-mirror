From: Samium Gromoff <_deepfire@feelingofgreen.ru>
Subject: Git-cvs import loops endlessly redownloading the same stuff.
Date: Thu, 19 Feb 2009 16:57:33 +0300 (MSK)
Message-ID: <20090219.165733.239525532716457724._deepfire@feelingofgreen.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 15:06:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La9Wr-0006KY-Et
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 15:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbZBSOEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 09:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752609AbZBSOEA
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 09:04:00 -0500
Received: from 69-100-st.zelcom.ru ([80.92.100.69]:50907 "HELO
	feelingofgreen.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S1752296AbZBSOD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 09:03:59 -0500
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Feb 2009 09:03:58 EST
Received: (qmail 28420 invoked from network); 19 Feb 2009 16:56:59 +0300
Received: from unknown (HELO localhost) (10.128.0.1)
  by auriga.feelingofgreen.ru with SMTP; 19 Feb 2009 16:56:59 +0300
X-Mailer: Mew version 5.2 on Emacs 23.0.90 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110700>


Good day list,

it appears that git 1.6.1.3, as packaged by debian, fails to terminate
when instructed like that:

git cvsimport -d :pserver:anoncvs@sources.redhat.com:/cvs/src newlib


It gets two ~20MB files into /tmp, converts them into blobs, around
8 and 9 megabytes, accordingly, and then attempts to proceed with the next,
36M-large, piece, essentially locking into what appears to be a download-it,
delete-it cycle.


regards, Samium Gromoff
