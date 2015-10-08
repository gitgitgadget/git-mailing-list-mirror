From: Rudy YAYON <ryayon@outlook.com>
Subject: Re: Exclude a file from a pull request
Date: Thu, 8 Oct 2015 09:50:12 +0200
Message-ID: <DUB130-W21C8C41143ED4495DB319ACE350@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "jacob.keller@gmail.com" <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 10:03:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk62t-0000Zp-Cx
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 09:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbbJHHzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 03:55:17 -0400
Received: from dub004-omc1s17.hotmail.com ([157.55.0.216]:49371 "EHLO
	DUB004-OMC1S17.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752153AbbJHHzQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 03:55:16 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Oct 2015 03:55:16 EDT
Received: from DUB130-W21 ([157.55.0.237]) by DUB004-OMC1S17.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Thu, 8 Oct 2015 00:50:12 -0700
X-TMN: [Y6/PFyWWGpOQ8AgP1mkOuPoyZrN1TQF2]
X-Originating-Email: [ryayon@outlook.com]
Importance: Normal
X-OriginalArrivalTime: 08 Oct 2015 07:50:12.0924 (UTC) FILETIME=[F69A0FC0:01D1019D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279221>


On Wed, Oct 7, 2015 at 9:33 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:

> Rudy YAYON <Rudy.YAYON.ext@boursorama.fr> writes:

> 

>>   My concern is that one important file (Puppetfile) needs to be pushed to my remote repository so I can check the changes I commited.

>>   To do that, I need to commit changes (included to the Puppetfile) then I need to push it to the remote repository.

>> 

>>   Once I want to merge these changes from a specific branch to the master branch, I do NOT want to include this file. In other words, I want to merge all files except the Puppetfile file.

>> 

>>   What is the best way for you to do that?

> 

> Create a branch that does not include the file.

> 

> Andreas.

> 

 

Why do the changes to "Puppetfile" need to be pushed to your github?

Just test it locally and then push it and pull-request a commit which doesn't have those changes in it.

 

Regards,

Jake


Hi Jake,


  Actually, once I run r10k, it will grab the Puppetfile from each branch from the remote repository to create Puppet environments (per git branch) and deploy other remote repositories.

  This file is mandatory on the repository.


Regards,
Rudy YAYON 		 	   		  