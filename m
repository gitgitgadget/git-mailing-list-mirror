From: Johan Herland <johan@herland.net>
Subject: Re: RFD: Handling case-colliding filenames on case-insensitive
 filesystems
Date: Thu, 24 Feb 2011 01:30:05 +0100
Message-ID: <201102240130.05800.johan@herland.net>
References: <201102231811.45948.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 24 01:30:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsP61-000206-0V
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 01:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab1BXAaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 19:30:10 -0500
Received: from smtp.getmail.no ([84.208.15.66]:57246 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006Ab1BXAaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 19:30:09 -0500
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LH300082IQ7T770@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 24 Feb 2011 01:30:07 +0100 (MET)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 2161E1EEF108_D65A68FB	for <git@vger.kernel.org>; Thu,
 24 Feb 2011 00:30:07 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 3C7551EEEFD7_D65A68EF	for <git@vger.kernel.org>; Thu,
 24 Feb 2011 00:30:06 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LH300NXJIQ61B00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 24 Feb 2011 01:30:06 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <201102231811.45948.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167755>

On Wednesday 23 February 2011, Johan Herland wrote:
> Are there better suggestions on how to deal with this?

Just a small note that I forgot in the first email:

For the record, this issue has been discussed on stackoverflow <URL: 
http://stackoverflow.com/questions/2528589/git-windows-case-sensitive-file-
names-not-handled-properly > and the last comment there suggests an 
alternative way to work around the case-colliding problem without having to 
remove either file from the repo:

Use sparse-checkout to exclude the case-colliding files from the working 
tree.

Obviously, this isn't a permanent solution, but I thought I'd just throw it 
out there, as something to consider until a more permanent solution is in 
place.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
