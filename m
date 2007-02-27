From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] commit-tree: bump MAX_PARENTS to 128
Date: Tue, 27 Feb 2007 00:16:42 -0800
Message-ID: <7vr6scj9qt.fsf@assigned-by-dhcp.cox.net>
References: <20070226121557.GA18114@coredump.intra.peff.net>
	<20070226143142.GA1390@spearce.org>
	<Pine.LNX.4.63.0702261736570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 09:16:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLxVv-0005Ez-Dq
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 09:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbXB0IQo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 03:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbXB0IQo
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 03:16:44 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:38238 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbXB0IQn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 03:16:43 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227081642.DGJU6078.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 03:16:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UYGi1W00U1kojtg0000000; Tue, 27 Feb 2007 03:16:43 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40699>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 26 Feb 2007, Shawn O. Pearce wrote:
>
>> My recollection is that only git-commit-tree and git-gui knew about this 
>> 16 parent limit.
>
> AFAIRC git-show-branch has a limit of 28 parents or so...

That's limit of the number of _tips_ to traverse from, and I do
not think it has anything to do with maximum size of Octopus.

But as Shawn pointed out, Octopus makes bisect less (much less)
efficient for the end users, I tend to think the current 16 is
already insanely large.
