From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Merging to and from non-current branches.
Date: Wed, 05 Aug 2009 19:15:02 -0700
Message-ID: <86y6pxsn6h.fsf@blue.stonehenge.com>
References: <D5200130-C7D7-4010-BF62-3A3374F2E3B0@mgreg.com>
	<alpine.LNX.2.00.0908042236240.2147@iabervon.org>
	<518952FC-626C-43FB-BD53-98DE849C9751@mgreg.com>
	<81b0412b0908051428g40b7678ewc549f079abbd03ee@mail.gmail.com>
	<C766A4F9-C12B-4F94-8B24-9BD3665B70E8@mgreg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: "lists@mgreg.com" <lists@mgreg.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 04:42:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYsw3-0002PO-Ig
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 04:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbZHFCmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 22:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbZHFCmX
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 22:42:23 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:25064 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbZHFCmX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 22:42:23 -0400
X-Greylist: delayed 1641 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2009 22:42:23 EDT
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 730551DE226; Wed,  5 Aug 2009 19:15:02 -0700 (PDT)
x-mayan-date: Long count = 12.19.16.10.6; tzolkin = 5 Cimi; haab = 4 Yaxkin
In-Reply-To: <C766A4F9-C12B-4F94-8B24-9BD3665B70E8@mgreg.com> (lists@mgreg.com's message of "Wed, 5 Aug 2009 21:48:34 -0400")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125023>

>>>>> "mgreg" == lists@mgreg com <lists@mgreg.com> writes:

mgreg> As I said, I understand what is being said, but in IMHO it would seem
mgreg> that a merge of that nature would be immediately desirable.  Think of
mgreg> it more as a local "push".  I'm never a fan of "because it hasn't be
mgreg> done means it shouldn't be".  I realize that's not exactly what you're
mgreg> saying though.  Anyway, I absolutely appreciate the post, and may very
mgreg> well post the script.

In other words, you'd be happy with it if it was just a fast-forward only?

Because the moment you might have conflicts, that *has* to be the workdir
so you can resolve those conflicts.  Dunno why this is so hard to grok.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
