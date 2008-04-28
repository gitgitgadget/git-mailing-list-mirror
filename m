From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Use perl instead of tac
Date: Mon, 28 Apr 2008 10:07:49 -0400
Message-ID: <E58664C1-86E5-452A-A7CD-2007DD59A75E@silverinsanity.com>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com> <slrng1be8l.25r.joerg@alea.gnuu.de> <alpine.DEB.1.00.0804281444320.5399@eeepc-johanness>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 16:09:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqU25-0003iY-L8
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 16:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933277AbYD1OHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 10:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933167AbYD1OHw
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 10:07:52 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:41570 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932407AbYD1OHv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 10:07:51 -0400
Received: from [192.168.1.7] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 086181FFD6C4;
	Mon, 28 Apr 2008 14:07:47 +0000 (UTC)
In-Reply-To: <alpine.DEB.1.00.0804281444320.5399@eeepc-johanness>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80535>


On Apr 28, 2008, at 9:46 AM, Johannes Schindelin wrote:

> How about fixing the code to not need tac instead?  We went to great
> lengths to introduce the --reverse option to the rev-list command, in
> order to avoid tac in the original version of rebase -i.

Because this is reversing the output of a sub-shell (ll.395-471), not  
rev-list.  And making the shell code insert commands before the lines  
the produce it would make the code complex at best.  (And it's not  
simple code either.)

Or at least that's why I didn't do it.  Someone who understands it  
better can feel free to make it work in reverse in the first place.

~~ Brian
