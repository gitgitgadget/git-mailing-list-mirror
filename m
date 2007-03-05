From: Bill Lear <rael@zopyra.com>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 17:27:19 -0600
Message-ID: <17900.42839.514960.613003@lisa.zopyra.com>
References: <17895.18265.710811.536526@lisa.zopyra.com>
	<20070302091426.GA2605@diana.vm.bytemark.co.uk>
	<17896.9631.316001.869157@lisa.zopyra.com>
	<Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070302162136.GA9593@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070305072323.GA31169@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.27067.247950.419438@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.30394.172067.743310@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.36569.805689.922989@lisa.zopyra.com>
	<Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org>
	<17900.39124.763603.695942@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052339050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 06 00:27:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOMag-0005m2-Pz
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 00:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbXCEX1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 18:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbXCEX1X
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 18:27:23 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60360 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbXCEX1W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 18:27:22 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l25NRKw12965;
	Mon, 5 Mar 2007 17:27:20 -0600
In-Reply-To: <Pine.LNX.4.63.0703052339050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41504>

On Monday, March 5, 2007 at 23:56:02 (+0100) Johannes Schindelin writes:
>...
>It may not be infeasible.
>
>But it is wrong. It "fixes" a totallc clear idiom, ...

A very valid point.  I dislike breaking clear idioms also.

>> the timestamp for that file on that branch would be invalidated, and the 
>> file would get whatever timestamp it got when it was written to disk.
>
>This approach is so fragile! It is invasive, easy to get wrong (count the 
>ways how to invalidate the timestamp), and serves only an obscure use 
>case, which is better solved otherwise to begin with.

More very valid points.

>> >So stop even asking for this. We'd have to be totally and utterly 
>> >incompetent to do what you ask for. We're simply not that stupid. 
>
>FWIW I have to agree here. I saw quite a few projects go wrong, because 
>management insisted on abolishing a perfectly good design, just because 
>they had this pet idea.

This is not my "pet idea".  I could care less about it: I have other
alternatives.  I was just engaging in what I hoped would be a friendly
exchange about this, but it seems to have touched a nerve, and then
invective with unsubtle charges of STUPID was loaded into the
catapult and flung across the sea ...

I loathe politics getting in the way of something clean, robust, and
useful.  I would be the last to advocate it: besides were I really
convinced that git MUST have this or die, I would try to write it
myself --- I was just hoping for an argument showing why it was such a
lame-brained idea from a logical, not implementation, standpoint.

Thanks again for your time.


Bill
