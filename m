From: Adam Nielsen <adam.nielsen@uq.edu.au>
Subject: Unable to get "pretty" URL aliases working
Date: Mon, 11 Jan 2010 15:57:09 +1000
Organization: The University of Queensland
Message-ID: <4B4ABDB5.9000203@uq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 07:05:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUDPS-0005MV-To
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 07:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319Ab0AKGFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 01:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221Ab0AKGFp
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 01:05:45 -0500
Received: from mailhub3.uq.edu.au ([130.102.148.131]:48059 "EHLO
	mailhub3.uq.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab0AKGFp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 01:05:45 -0500
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jan 2010 01:05:45 EST
Received: from smtp4.uq.edu.au (smtp4.uq.edu.au [130.102.128.19])
	by mailhub3.uq.edu.au (8.13.8/8.13.8) with ESMTP id o0B5vAXJ018543
	for <git@vger.kernel.org>; Mon, 11 Jan 2010 15:57:10 +1000
Received: from [192.168.173.208] (rrtd-it1.research.uq.edu.au [192.168.173.208])
	by smtp4.uq.edu.au (8.13.8/8.13.8) with ESMTP id o0B5vAsq006663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 11 Jan 2010 15:57:10 +1000
User-Agent: Thunderbird 2.0.0.23 (X11/20091130)
X-UQ-FilterTime: 1263189430
X-Scanned-By: MIMEDefang 2.58 on UQ Mailhub on 130.102.148.131
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136606>

Hi all,

I'm attemping to learn Git but I've gotten stuck trying to configure a 
server to host my repositories.

I would like to be able to do this:

   git clone ssh://myserver/project.git
   git push

And have it work, but I keep getting errors about "/project.git" not 
existing in the root directory of my server.  (Which is correct, they 
are stored elsewhere.)

The only documentation I could find about mapping a deep path to a 
"pretty" URL like this was in git-push(1) which stated I should add 
something like the following to a "config file".  I'm guessing it means 
/etc/gitconfig on the server.

[url "ssh://myserver/path/to/repos/"]
   insteadOf myserver:

I'm a bit confused about where the colon comes into it, if I use that on 
the command line I get errors about resolving domain names.  I've tried 
many variations of the insteadOf line ("ssh://myserver/", "myserver:/", 
"myserver/" etc.) but none of them make any difference.  I don't even 
know if this file is being used.

Any pointers about how this URL mapping can be set up?

Many thanks,
Adam.

(Please CC)
