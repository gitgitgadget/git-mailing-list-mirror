From: Jeff Garzik <jeff@garzik.org>
Subject: gitweb age bug
Date: Tue, 08 Aug 2006 07:26:40 -0400
Message-ID: <44D874F0.6000907@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 08 13:26:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAPjS-0003kI-4K
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 13:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWHHL0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 07:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWHHL0m
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 07:26:42 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:46307 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964855AbWHHL0m (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 07:26:42 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1GAPjN-0008NY-8d
	for git@vger.kernel.org; Tue, 08 Aug 2006 11:26:41 +0000
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25066>

At URL

	http://www.kernel.org/git/?o=age

one can see the various repositories, sorted by last-modified time.

However, AFAICS, only the 'master' branch is checked.  This causes an 
incorrect age to be returned, for kernel hackers who always do work in 
topic branches ('master' is Linus vanilla kernel).

Thus, the age on my repositories is only updated when I update the 
'master' branch with new linux-2.6.git goodies.  Development work I do 
in topic branches is never noted in the 'age' column.

	Jeff
