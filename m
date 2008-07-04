From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: Re: [msysGit] Re: [PATCH 06/12] connect: Fix custom ports with plink
 (Putty's ssh)
Date: Fri, 04 Jul 2008 16:11:35 -0400
Message-ID: <486E83F7.8070105@thewritingpot.com>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de>
 <1214987532-23640-5-git-send-email-prohaska@zib.de>
 <1214987532-23640-6-git-send-email-prohaska@zib.de>
 <200807022104.20146.johannes.sixt@telecom.at>
 <7vod5euhw3.fsf@gitster.siamese.dyndns.org>
 <7188A895-D5B9-480E-8486-8A69B8861646@zib.de>
 <1f748ec60807040909r4022d714s4487f5991f6020dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: prohaska@zib.de, Junio C Hamano <gitster@pobox.com>,
	johannes.sixt@telecom.at, msysGit <msysgit@googlegroups.com>,
	git@vger.kernel.org
To: piyo@users.sourceforge.net
X-From: git-owner@vger.kernel.org Fri Jul 04 22:12:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEre6-0002vg-Vk
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 22:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbYGDULp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 16:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbYGDULp
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 16:11:45 -0400
Received: from mta1.srv.hcvlny.cv.net ([167.206.4.196]:61509 "EHLO
	mta1.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbYGDULo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 16:11:44 -0400
Received: from [192.168.0.10] (ool-18e45099.dyn.optonline.net [24.228.80.153])
 by mta1.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTP id <0K3I000OJ03JYWN0@mta1.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Fri, 04 Jul 2008 16:11:44 -0400 (EDT)
In-reply-to: <1f748ec60807040909r4022d714s4487f5991f6020dc@mail.gmail.com>
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87417>

Clifford Caoile wrote:
> Perhaps I have traded one problem for another, because the msysgit
> user still has to be aware of MSYSGIT_REAL_PLINK (at least she doesn't
> have to set it up). And of course, the installer has to be modified to
> accommodate plinkssh and my proposal.

This feels unnecessarily complicated.

What would be cool is if we could just set GIT_SSH to plinkssh 
-path-to-plink "C:\Path\To\plink.exe" (obviously a shorter flag or 
something). Unfortunately, this doesn't seem to work with Git's current 
command argument handling.
