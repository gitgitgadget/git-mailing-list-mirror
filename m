From: Bill Lear <rael@zopyra.com>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 15:42:49 -0600
Message-ID: <17900.36569.805689.922989@lisa.zopyra.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 22:43:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOKxP-0008Pa-OK
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 22:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933633AbXCEVm4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 16:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933457AbXCEVm4
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 16:42:56 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60199 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933633AbXCEVmy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 16:42:54 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l25Lgqf00972;
	Mon, 5 Mar 2007 15:42:52 -0600
In-Reply-To: <Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41490>

On Monday, March 5, 2007 at 21:44:26 (+0100) Johannes Schindelin writes:
>Hi,
>
>On Mon, 5 Mar 2007, Bill Lear wrote:
>
>> On Monday, March 5, 2007 at 20:16:35 (+0100) Johannes Schindelin writes:
>>
>> >If somebody (might be even you yourself) pushes into your repo, under 
>> >the name of the branch to which you switch back to right after that. 
>> >Bingo. Files changed.
>> 
>> Yes, they change, and so would the timestamp.  So what?
>
>Think about it. Why would the timestamp change? Because Git wrote the 
>file? But that was exactly the behaviour you were complaining about.

Not because git wrote the file, but because git notices that content
changes, and writes the file (and timestamps it) "smartly".  If
someone writes into the repo, the timestamp stored becomes invalidated
and the write of the file just creates the timestamp at the time of
the checkout.  If no write into the repo index occurs, the stored
timestamp is applied after the file is checked out.


Bill
