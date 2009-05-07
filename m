From: david@lang.hm
Subject: RE:
Date: Thu, 7 May 2009 16:07:51 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0905071607080.15782@asgard>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
 <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain> <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain> <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain> <alpine.DEB.1.10.0905071521130.15782@asgard> <alpine.LFD.2.01.0905071531030.4983@localhost.localdomain>
 <alpine.DEB.1.10.0905071543120.15782@asgard> <alpine.LFD.2.01.0905071553570.4983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Bevan Watkiss <bevan.watkiss@cloakware.com>,
	"'Alex Riesen'" <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 08 01:12:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Cky-000728-8F
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 01:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbZEGXJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 19:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbZEGXJG
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 19:09:06 -0400
Received: from mail.lang.hm ([64.81.33.126]:42169 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbZEGXJG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 19:09:06 -0400
Received: from asgard.local (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n47N7pS6025415;
	Thu, 7 May 2009 16:07:51 -0700
X-X-Sender: dlang@asgard
In-Reply-To: <alpine.LFD.2.01.0905071553570.4983@localhost.localdomain>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118536>

On Thu, 7 May 2009, Linus Torvalds wrote:

> On Thu, 7 May 2009, david@lang.hm wrote:
>>
>> even with this a git checkout -f should replace all files, correct?
>
> Hmm. I don't think so.
>
> As far as I recall, "-f" only overrides certain errors (like unmerged
> files or not up-to-date content), it doesn't change behavior wrt files
> that git thinks are already up-to-date.

what about a reset --hard? (is there any command that would force the 
files to be re-written, no matter what git thinks is already there)

David Lang
