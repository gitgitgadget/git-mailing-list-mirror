From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Tue, 23 Jan 2007 09:07:08 -0800
Message-ID: <86bqkp1xkz.fsf@blue.stonehenge.com>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vwt3h7dp6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701202240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<200701210137.41219.robin.rosenberg.lists@dewire.com>
	<Pine.LNX.4.63.0701210234350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17842.53449.35322.514320@lisa.zopyra.com>
	<7vr6tp5aqq.fsf@assigned-by-dhcp.cox.net>
	<87vej0gh4k.fsf@morpheus.local> <m3zm89zxs1.fsf@maximus.localdomain>
	<873b6197jf.fsf@morpheus.local> <m3irexzua9.fsf@maximus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 18:07:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9P7R-0004FR-MQ
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 18:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933089AbXAWRHf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 12:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933093AbXAWRHe
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 12:07:34 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:22439 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933089AbXAWRHe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 12:07:34 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 6E1171DE65B; Tue, 23 Jan 2007 09:07:08 -0800 (PST)
To: Krzysztof Halasa <khc@pm.waw.pl>
x-mayan-date: Long count = 12.19.14.0.1; tzolkin = 3 Imix; haab = 14 Muan
In-Reply-To: <m3irexzua9.fsf@maximus.localdomain> (Krzysztof Halasa's message of "Tue, 23 Jan 2007 15:34:22 +0100")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37551>

>>>>> "Krzysztof" == Krzysztof Halasa <khc@pm.waw.pl> writes:

Krzysztof> Actually it is the correct way to do that. If people "reply to group"
Krzysztof> or whatever is it called, the reply goes to "Reply-To" list.
Krzysztof> If they "reply to author", the reply goes to "From" address and
Krzysztof> "Reply-To" is ignored.

Argh.  Such misinformation abounds on this topic!

The only reason a mail client has the ability to ignore the "reply-to"
(which *violates* the RFCs - go check it out) is because of *broken*
(but perhaps well-intentioned) mailing lists that add "reply-to: list".

The proper solution is to *follow* the RFCs, and leave the reply-to alone when
relaying.  If someone wants to reply to the list *and* the person, they can
reply to both the "from (or reply-to)" and "to" addresses, often called a
"wide reply".  If someone wants to reply to just the person, they use the
"reply-to" if it's present, or the "from" if not.  This is *proper* behavior:
it's only some broken mailing lists out there that have caused us to have to
work around it.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
