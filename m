From: Bert Douglas <bertd@tplogic.com>
Subject: rename directory weirdness
Date: Thu, 26 Jul 2007 02:47:41 -0500
Message-ID: <46A8519D.5050801@tplogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 09:48:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDy4y-0005rR-52
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 09:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756663AbXGZHsG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 03:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757218AbXGZHsF
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 03:48:05 -0400
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:34496 "EHLO
	imf22aec.mail.bellsouth.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753826AbXGZHsE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2007 03:48:04 -0400
Received: from ibm65aec.bellsouth.net ([68.220.183.197])
          by imf22aec.mail.bellsouth.net with ESMTP
          id <20070726074803.QJSS13480.imf22aec.mail.bellsouth.net@ibm65aec.bellsouth.net>
          for <git@vger.kernel.org>; Thu, 26 Jul 2007 03:48:03 -0400
Received: from [192.168.1.96] (really [68.220.183.197])
          by ibm65aec.bellsouth.net with ESMTP
          id <20070726074803.GQOK275.ibm65aec.bellsouth.net@[192.168.1.96]>
          for <git@vger.kernel.org>; Thu, 26 Jul 2007 03:48:03 -0400
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53802>

I am new user.  Trying to understand git.

I renamed a directory.
$ mv dir1 dir2
$ git add dir2
$ git commit -a

It popped up my editor with long list of files that it recognized as 
'renamed'.
But one file it listed as 'copied' and further down as 'deleted'.

Why this one file out of thousands not recognized as 'renamed' ?
Is this a sign of a problem ?

Thanks again for all help.
