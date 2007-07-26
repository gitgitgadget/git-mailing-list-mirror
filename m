From: Bert Douglas <bertd@tplogic.com>
Subject: problem after cvsimport
Date: Wed, 25 Jul 2007 20:49:13 -0500
Message-ID: <46A7FD99.9000305@tplogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 03:49:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDsTz-0006Gy-DQ
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 03:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbXGZBtg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 21:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754663AbXGZBtg
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 21:49:36 -0400
Received: from imf20aec.mail.bellsouth.net ([205.152.59.68]:59431 "EHLO
	imf20aec.mail.bellsouth.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754384AbXGZBtf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jul 2007 21:49:35 -0400
Received: from ibm64aec.bellsouth.net ([68.220.183.197])
          by imf20aec.mail.bellsouth.net with ESMTP
          id <20070726014934.QJXN8519.imf20aec.mail.bellsouth.net@ibm64aec.bellsouth.net>
          for <git@vger.kernel.org>; Wed, 25 Jul 2007 21:49:34 -0400
Received: from [192.168.1.96] (really [68.220.183.197])
          by ibm64aec.bellsouth.net with ESMTP
          id <20070726014934.BSJZ19302.ibm64aec.bellsouth.net@[192.168.1.96]>
          for <git@vger.kernel.org>; Wed, 25 Jul 2007 21:49:34 -0400
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53746>

I am new to git, so probably doing something wrong.
Hope somebody can enlighten me.
Here is what happened so far.

Followed instructions here:
http://www.kernel.org/pub/software/scm/git/docs/cvs-migration.html

Did command like this:

$ git cvsimport -C <destination> <module>

This was done from top level of existing cvs working directory.
Destination was new empty directory, outside the cvs tree.

It worked for several hours and seemed to complete ok.
I can look at history in destination git directory with gitk and git log.
All the stuff in ".git" looks normal, as far as I can tell.

But I have no files in the working directory.
When I do command:
$git checkout master

I get a bunch of lines to console with "D" in front.
Btw, what does that mean?  Nothing about it in "man git-checkout" or elsewhere that I can find.
Then it says -- Already on branch "master"

But working directory is still empty.


Thanks much,
Bert Douglas
