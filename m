From: Eric LEBIGOT <Eric.Lebigot@normalesup.org>
Subject: Is it possible to have a file shared between branches?
Date: Mon, 12 Apr 2010 11:10:10 +0200 (CEST)
Message-ID: <alpine.OSX.2.01.1004121058390.52293@kroll.spectro.jussieu.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 12 11:26:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1FuD-0003FZ-Hl
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 11:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab0DLJZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 05:25:38 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:62171 "EHLO shiva.jussieu.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753419Ab0DLJZf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 05:25:35 -0400
X-Greylist: delayed 916 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2010 05:25:35 EDT
Received: from y-wing.spectro.jussieu.fr (y-wing.spectro.jussieu.fr [134.157.7.7])
          by shiva.jussieu.fr (8.14.3/jtpda-5.4) with ESMTP id o3C9AGJO083961
          for <git@vger.kernel.org>; Mon, 12 Apr 2010 11:10:16 +0200 (CEST)
X-Ids: 165
Received: from kroll.spectro.jussieu.fr (kroll.spectro.jussieu.fr [134.157.7.136])
          by y-wing.spectro.jussieu.fr (8.14.2/jtpda-5.4) with ESMTP id o3C9AFR6004057
          for <git@vger.kernel.org>; Mon, 12 Apr 2010 11:10:15 +0200
X-X-Sender: lebigot@kroll.spectro.jussieu.fr
User-Agent: Alpine 2.01 (OSX 1266 2009-07-14)
X-Virus-Scanned: ClamAV 0.94.2/10728/Mon Apr 12 04:24:35 2010 on shiva.jussieu.fr
X-Virus-Status: Clean
X-Miltered: at jchkmail.jussieu.fr with ID 4BC2E378.004 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 4BC2E378.004/134.157.7.7/y-wing.spectro.jussieu.fr/y-wing.spectro.jussieu.fr/<Eric.Lebigot@normalesup.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144717>

Hello,

Is it possible for git to track a single file that would be shared accross 
branches?  Case in point: a to-do list file that describes what has to be 
done in all the branches; it can be convenient to put all the things that 
have to be done in a single, shared file, while keeping this to-do list in 
sync with the code (so that it lists what has been done, and what remains to 
be done).  Committing in a branch would in effect also commit the shared file 
in the other branches (another possibility may be to have in effect many 
"trees" in a single git directory, with a specific tree for the to-do list).

Is this something git can do?

EOL
