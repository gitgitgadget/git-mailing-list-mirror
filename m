From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Update based on suggestions by Petr Baudis
Date: Wed, 21 Apr 2010 23:20:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004212304510.7232@xanadu.home>
References: <20100422020746.5205B475FF1@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Eric Raymond <esr@snark.thyrsus.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 05:24:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4n29-0003D6-Hk
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 05:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942Ab0DVDYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 23:24:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18495 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab0DVDYu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 23:24:50 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L1900883D9M2FB1@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 21 Apr 2010 23:20:11 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100422020746.5205B475FF1@snark.thyrsus.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145497>

On Wed, 21 Apr 2010, Eric Raymond wrote:

> ---
>  contrib/ciabot/ciabot.py |  130 +++++++++++++++++++++++++---------------------
>  contrib/ciabot/ciabot.sh |  106 +++++++++++++++++++++----------------
>  2 files changed, 130 insertions(+), 106 deletions(-)
[...]

That would be better if you improve your patch message a bit.

First, the email subject is used by tools to provide a summary line for 
the changes.  Example:

[PATCH] improvements to the ciabot scripts

Then, in the email body you may add more information, such as a more 
elaborate explanation of the change.  It is also where such credits as 
"Update based on suggestions by Petr Baudis" should go.

If you want to add further comments that should not be part of the 
commit log, then just place them after the three-dash line.

When making a commit with Git, the convention is to use the very first 
line of the commit message for the summary line (without the [PATCH] 
prefix), then a blank line separating it from the rest of the commit 
message.  This way tools such as 'git format-patch' or 'git send-email' 
will do the right thing automatically.

Finally, your patch description message should also include a 
Signed-off-by tag as explained in Documentation/SubmittingPatches.


Nicolas
