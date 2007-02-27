From: Bill Lear <rael@zopyra.com>
Subject: Re: Organizing (large) test data in git
Date: Tue, 27 Feb 2007 14:00:48 -0600
Message-ID: <17892.36336.249022.904854@lisa.zopyra.com>
References: <17892.28995.328911.23188@lisa.zopyra.com>
	<Pine.LNX.4.63.0702272049560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:00:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM8VM-0007iT-HY
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbXB0UAy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbXB0UAy
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:00:54 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61034 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520AbXB0UAx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:00:53 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1RK0oP06846;
	Tue, 27 Feb 2007 14:00:50 -0600
In-Reply-To: <Pine.LNX.4.63.0702272049560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40777>

On Tuesday, February 27, 2007 at 20:52:38 (+0100) Johannes Schindelin writes:
>Hi,
>
>On Tue, 27 Feb 2007, Bill Lear wrote:
>
>> We are contemplating files on the order of 500 megabytes a piece.
>
>I recommend splitting the files so that no file is that large (but the sum 
>of them can be). But I think that you really wanted to say that.
>
>I think the problem of large packs is tackled right now by Troy, Shawn and 
>Nico. Troy had exactly the same problem AFAIU, and Nico and Shawn are 
>working on a new pack file format, which would lift the 4GB limit on packs 
>while at it.
>
>This should solve your problems.

Welll... it's not really a matter of capacity, though I do agree that
lifting that limit will help.  We are more concerned with time to
clone the repos over the (often very slow) corporate network, for
example.  With future ratios of about 1% code to 99% test data, we
really would like to have a light-weight code repo that we can throw
hither and yon with little care, and a monster data repo that is
(somehow) sanely managed with git as well.  I was just curious if
others had run into the management problems that I mentioned with
separating test data from code and what they may have done to surmount
them.


Bill
