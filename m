From: Andrew Bush <andrew@patchprint.co.nz>
Subject: adding arbitary folders to the git index, from outside of the repository
Date: Wed, 29 Apr 2009 10:54:54 +1200
Message-ID: <8ABE87D6-F70D-4A86-8307-88B95FAF350F@patchprint.co.nz>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 01:55:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyx8j-0007TF-NC
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 01:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552AbZD1Xy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 19:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754197AbZD1Xy4
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 19:54:56 -0400
Received: from smtp.patchprint.co.nz ([203.97.68.102]:9951 "EHLO
	patchprint.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148AbZD1Xy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 19:54:56 -0400
X-Greylist: delayed 3598 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Apr 2009 19:54:55 EDT
Received: from [192.168.81.164] ([192.168.81.164] verified)
  by patchprint.co.nz (CommuniGate Pro SMTP 3.5.2)
  with ESMTP-TLS id 2612439 for git@vger.kernel.org; Wed, 29 Apr 2009 11:02:43 +1200
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117837>

Hi all,

I have a desire to have a single git repository that tracks the  
content of an array of folders located in various places across my  
file system.

this doesn't *appear* to be supported in any way, I found some stuff  
about using shortcuts but that was apparently removed in version 1.6  
because of the problem of deciding when to follow them and when to  
index them.


Ideally what I would like is a way to specify in the git config file  
for a repository an arbitary list of folders that it should index,  
instead of only having the choice of indexing the folder the  
repository is stored in.


this *feels* like it might be possible with a little hacking,depending  
on how git is designed, but before I plunge into the Cold Depths Of  
Unknown Code I was wondering whether anyone else has any knowledge of  
an existing git solution for this kind of problem, or maybe some  
suggestions for where I should start looking in the code or how I  
should approach it?

I am also interested in whether anyone else has an interest in this  
feature?

thanks for any suggestions or insights at all.


- Andrew
