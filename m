From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: Imports without Tariffs
Date: Sat, 13 Oct 2007 00:44:54 -0400
Message-ID: <C30A314A-C258-4585-86FD-C1158ACA85C2@mit.edu>
References: <1C0D32ED-59F7-43D4-88B1-D7A9E754D639@mit.edu> <3B7796D6-5901-40B0-B3FC-70642AC50B08@mit.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 06:45:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgYsI-0008QS-9X
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 06:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750AbXJMEo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 00:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755223AbXJMEo6
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 00:44:58 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:49381 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754297AbXJMEo5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Oct 2007 00:44:57 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9D4iuF5020404
	for <git@vger.kernel.org>; Sat, 13 Oct 2007 00:44:56 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9D4itM3013597
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sat, 13 Oct 2007 00:44:55 -0400 (EDT)
In-Reply-To: <3B7796D6-5901-40B0-B3FC-70642AC50B08@mit.edu>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60723>

On 12 Oct 2007, at 4:36:29 PM, mfwitten@MIT.EDU wrote:

> To make things simple, I think all of the necessary machinery
> should be put into git-cvsimport.
>
> The user should first git-cvsexportcommit as necessary.


Now that I have considered, it makes more sense to put the
machinery in git-cvsexportcommit.

The user could use a -b flag to specify the git branch to push
into after the cvs commit occurs, and git-cvsexportcommit would
update the .git/SCM_IMPORT file (changed from CVS_IMPORT).

Of course, this introduces other troubles.

Sometimes I run cvsexportcommit using a git repo on another server.
So perhaps one should also be able to use cvsexportcommit for just
pushing and editing the .git/SCM_IMPORT file.

That way it's possible to update CVS and then notify any other git
repo by hand.

Michael
