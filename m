From: "Sam G." <ceptorial@comcast.net>
Subject: Searching all git objects
Date: Wed, 25 Jun 2008 16:06:31 -0700
Message-ID: <E99352BE-5C43-437E-A5E6-622BEEA03DFA@comcast.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 01:14:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBeBp-0004Wr-Dj
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 01:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbYFYXNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 19:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753904AbYFYXNQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 19:13:16 -0400
Received: from mail.box.net ([67.15.218.250]:53479 "EHLO mail.box.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbYFYXNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 19:13:16 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Jun 2008 19:13:16 EDT
Received: (qmail 17830 invoked from network); 25 Jun 2008 18:05:12 -0500
Received: from c-24-130-19-112.hsd1.ca.comcast.net (HELO ?192.168.1.199?) (24.130.19.112)
  by mail.box.net with (AES128-SHA encrypted) SMTP; 25 Jun 2008 18:05:12 -0500
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86366>

Hi all,

We recently had a developer make a large commit (mostly centered  
around one file) which she believed she properly pushed to a remote  
repository last week, but looking at both her repository and the  
remote repository, that commit is now nowhere to be found. If somehow  
the master branch she was working on in her repository has lost the  
reference to the commit through perhaps some errant rebasing, then  
perhaps an object containing the commit (or an object containing the  
file in that commit) still exists somewhere inside her .git/objects  
directory? We haven't done any git-gc recently. If so, how can I  
search through every single git object in her objects directory,  
searching for perhaps a specific part of the commit string, a line in  
the code or the filename of the file which was changed? Any help with  
this would be greatly appreciated. Thanks!

-Sam
