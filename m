From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] rebase -i: commit when continuing after "edit"
Date: Tue, 25 Sep 2007 17:54:14 +0200
Message-ID: <46F92F26.6050204@viscovery.net>
References: <20070923224502.GB7249@potapov> <Pine.LNX.4.64.0709240121080.28395@racer.site> <7vlkav71bv.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709251249450.28395@racer.site> <46F90C95.5060903@viscovery.net>    =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?Pine.LNX.4.64.07?= =?ISO-8859-1?Q?09251439070.2839?=
	=?ISO-8859-1?Q?5@race=04r.site>?= <46F91879.6030301@viscovery.net> <86ve9y6bvm.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 17:54:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaCkC-00073j-BY
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 17:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756551AbXIYPyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 11:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbXIYPyS
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 11:54:18 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:10764 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441AbXIYPyR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 11:54:17 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IaCjn-00048X-97; Tue, 25 Sep 2007 17:54:15 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D9709546; Tue, 25 Sep 2007 17:54:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <86ve9y6bvm.fsf@lola.quinscape.zz>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59143>

David Kastrup schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>> I poked around a bit, but one major obstacle is that the assignments
>> in $author_script are on separate lines, which you would have to
>> splice into a single line before you can insert them in the eval.
> 
> Hm?  Why?  Newlines separate assignments just as reliable as spaces
> do.  They are primarily special to the tty as line separators, not the
> shell as such.

The task here is to have the assignments on the same line as the command at 
the end so that they are locally exported. Here we are inside an 'eval', and 
the new-lines *do* what their name suggest: make new lines.

-- Hannes
