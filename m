From: Claudio Scordino <cloud.of.andor@gmail.com>
Subject: Suggestions for documentation
Date: Tue, 19 Jun 2007 09:33:05 +0200
Message-ID: <467786B1.5000009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 09:33:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0YDM-0003QF-Rt
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 09:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755733AbXFSHdT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 03:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755839AbXFSHdT
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 03:33:19 -0400
Received: from ms01.sssup.it ([193.205.80.99]:58247 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755733AbXFSHdS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 03:33:18 -0400
Received: from [193.205.82.7] (HELO gandalf.sssup.it)
  by sssup.it (CommuniGate Pro SMTP 4.1.8)
  with ESMTP-TLS id 31291226 for git@vger.kernel.org; Tue, 19 Jun 2007 09:25:07 +0200
Received: from [10.30.3.110] ([10.30.3.110])
	by gandalf.sssup.it (8.12.10/8.12.10) with ESMTP id l5J6UJqi019099
	for <git@vger.kernel.org>; Tue, 19 Jun 2007 08:30:19 +0200
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50452>

Hi,

    I just want to suggest to put some missing information in the git manpages.

1) As my previous question shown, how to clone from a specified port is not 
currently documented. You should just add a sentence saying that the command is

git clone git://server:port/path/

2) Maybe it is better to highlight that after a push on a remote repository, the 
user has to do a checkout on that repository (people from the CVS and SVN worlds 
get easily confused, otherwise).

Moreover (and I did not fully understood why) if I just use "git checkout" 
without the -f option, I cannot see the changes that have been pushed from the 
cloned repository.

Regards,

          Claudio
