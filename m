From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: "bash: git-upload-pack: command not found" ??
Date: Thu, 6 Mar 2008 11:06:00 +0000
Message-ID: <20080306110600.GA925@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 12:38:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXEQO-0000nO-Kj
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 12:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbYCFLhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 06:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754189AbYCFLhe
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 06:37:34 -0500
Received: from mhs.swan.ac.uk ([137.44.1.33]:37349 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754121AbYCFLhe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 06:37:34 -0500
X-Greylist: delayed 1890 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Mar 2008 06:37:33 EST
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.69)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1JXDvE-0006Sv-S6; Thu, 06 Mar 2008 11:06:00 +0000
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id C0454DAF29;
	Thu,  6 Mar 2008 11:06:00 +0000 (GMT)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id A896F741BA; Thu,  6 Mar 2008 11:06:00 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76379>

Hello,

when using

Transitional> git pull ssh://user@host.xz/~/path/to/Transitional master

on a remote machine I get

Password:
bash: git-upload-pack: command not found
fatal: The remote end hung up unexpectedly

On both machines I have version 1.5.4.3 installed, but this behaviour
was never different in the past (I'm using git for 8 months; to circumvent the
error I always created a copy of the remote repository and then pulled locally).

It might be some path issue, but I don't find anything in the documentation
on how to instruct the remote machine where actually to find git.

Hope that somebody can enable me to use "git pull" as it should be.

Oliver

