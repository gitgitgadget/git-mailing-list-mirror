From: Marc Singer <elf@synapse.com>
Subject: Re: Let me ask again: How do we import patches from non-git
	sources?
Date: Tue, 12 Jun 2007 09:27:33 -0700
Message-ID: <1181665653.4194.24.camel@zealous.synapsedev.com>
References: <1180017010.21181.2.camel@zealous.synapsedev.com>
	 <1181151454.6086.23.camel@zealous.synapsedev.com>
	 <20070606175458.GH12774@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 18:27:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy9DV-0001fO-Ae
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 18:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755AbXFLQ1g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 12:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752997AbXFLQ1g
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 12:27:36 -0400
Received: from henry.synapsedev.com ([66.147.194.230]:37992 "EHLO
	henry.synapse.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbXFLQ1f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 12:27:35 -0400
Received: from sanjuan.synapsedev.com (localhost.localdomain [127.0.0.1])
	by henry.synapse.com (Postfix) with ESMTP id F3022D2C189
	for <git@vger.kernel.org>; Tue, 12 Jun 2007 09:27:34 -0700 (PDT)
Received: from sanjuan.synapsedev.com ([192.168.1.2] helo=sanjuan.synapsedev.com)
	by ASSP.nospam; 12 Jun 2007 09:27:34 -0700
Received: from zealous.local ([192.168.0.5]) by sanjuan.synapsedev.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 12 Jun 2007 09:27:34 -0700
In-Reply-To: <20070606175458.GH12774@fieldses.org>
X-Mailer: Evolution 2.6.3 
X-OriginalArrivalTime: 12 Jun 2007 16:27:34.0469 (UTC) FILETIME=[9505EF50:01C7AD0E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49971>

On Wed, 2007-06-06 at 13:54 -0400, J. Bruce Fields wrote:
> Based on my notes from the last time I needed to feed a bunch of
> non-mbox, non-git-produced patches into git-am, the hard part was
> figuring out how it split a file into separate messages; my notes say:
> 
> 	"Finds lines begining with "From " and ending with "hh:mm:ss
> 	yyyy".  See builtin-mailsplit code for more details."
> 
> Other than that, I think it just needs and From: and Subject: lines to
> get author and first-line of the commit.  the git-am man page has some
> documentation of this.  It could probably use more.
> 

I'm not sure that I understand your response. 

git-am complains that it cannot find an email address, but raw patches
seldom have these.  So, either we could use another command, or it would
be handy if we could supply the email address to git-am (or some other
data it needs so that it can split the patch.)  I suppose the mistaken
assumption is that the patch source in an email instead of already being
a nice clean patch.
