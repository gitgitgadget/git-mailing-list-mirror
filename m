From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Dangerous "git am --abort" behavior
Date: Mon, 20 Dec 2010 16:52:59 -0500
Message-ID: <1292881979.23145.5.camel@drew-northup.unet.maine.edu>
References: <AANLkTinP4SArMkjvTXOEG=tf=8EcEdP9fPAB7F=iitSc@mail.gmail.com>
	 <loom.20101220T203122-271@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 20 22:56:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUniF-0004II-CX
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 22:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758044Ab0LTV4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 16:56:05 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:35586 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757965Ab0LTV4E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 16:56:04 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id oBKLr5Hw014423
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 20 Dec 2010 16:53:10 -0500
In-Reply-To: <loom.20101220T203122-271@post.gmane.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=4
	Fuz1=4 Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oBKLr5Hw014423
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1293486891.14231@G4Kplmow3A/+FudVFzyHOw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164014>


On Mon, 2010-12-20 at 19:35 +0000, Adam Monsen wrote:
> Linus Torvalds writes:
> > What happened today was that I had been doing a pull or two, and then
> > applied an emailed patch with "git am" as usual. But as sometimes
> > happens, I actually had a previous "git am" that had failed - in fact,
> > it was the same patch that I applied today that had had an earlier
> > version that no longer applied.
> 
> It would be helpful if "git status" mentioned if a rebase or am operation is in 
> progress... this might have helped you avoid the situation described.

Adam,
Please don't cull the CC list...

In any case, are there any other mult-part operations for which we might
want to report "In Progress" in the "git status" output? How do we best
harvest and present this information to the user? This sounds like a
more general-purpose project than Linus' original scope.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
