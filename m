From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] rebase --fix: interactive fixup mode
Date: Mon, 9 Jan 2012 21:16:09 +0100
Message-ID: <20120109201609.GB25269@ecki>
References: <20120108213134.GA18671@ecki.lan>
 <878vlh1bnm.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 09 21:24:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkLli-00050s-AE
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 21:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933402Ab2AIUY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 15:24:28 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:29968 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933256Ab2AIUY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 15:24:27 -0500
Received: from localhost (p5B22D760.dip.t-dialin.net [91.34.215.96])
	by bsmtp.bon.at (Postfix) with ESMTP id 41B3B130050;
	Mon,  9 Jan 2012 21:24:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <878vlh1bnm.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188187>

On Mon, Jan 09, 2012 at 10:13:33AM +0100, Thomas Rast wrote:
> 
> Given the name I would expect --fix to rebase far enough to make recent
> fixup!/squash! commits take effect.  Perhaps name it --recent?

Sure, I am not particular about the name.

> (And I also think that the 20 is rather arbitrary...)

Well, I need some kind of limit. Otherwise we will list the entire
history up to the root commit in case of repos with only linear history.
And that can be rather slow.

Clemens
