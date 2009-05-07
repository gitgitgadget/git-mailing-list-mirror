From: david@lang.hm
Subject: RE:
Date: Thu, 7 May 2009 15:43:40 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0905071543120.15782@asgard>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
 <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain> <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain> <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain> <alpine.DEB.1.10.0905071521130.15782@asgard>
 <alpine.LFD.2.01.0905071531030.4983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Bevan Watkiss <bevan.watkiss@cloakware.com>,
	"'Alex Riesen'" <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 08 00:45:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2CLP-0004wU-I7
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 00:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbZEGWpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 18:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbZEGWpN
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 18:45:13 -0400
Received: from mail.lang.hm ([64.81.33.126]:39852 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbZEGWpM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 18:45:12 -0400
Received: from asgard.local (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n47MheN2025326;
	Thu, 7 May 2009 15:43:40 -0700
X-X-Sender: dlang@asgard
In-Reply-To: <alpine.LFD.2.01.0905071531030.4983@localhost.localdomain>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118533>

On Thu, 7 May 2009, Linus Torvalds wrote:

> On Thu, 7 May 2009, david@lang.hm wrote:
>>
>> his use case (as I understand it) is that the working tree is never updated by
>> anything other than git. it never recieves patches or manual edits.
>
> Well, you can certainly just use the CE_VALID bit in the index too (and
> this time I really mean CE_VALID). But it won't help anybody else, so it
> wouldn't be nearly as interesting. And I wonder how badly that code has
> rotted, thanks to not getting used.
>
> But yes, one thing to do would be
>
> 	git update-index --assume-unchanged --refresh
>
> which should hopefully set the bit, and then after that setting
> 'core.ignoreStat' should hopefully keep it set.
>
> Of course, you had then better _never_ make any mistakes and touch the
> files with non-git commands.

even with this a git checkout -f should replace all files, correct?

David Lang

> And hope that the code still works ;)
>
> 		Linus
>
