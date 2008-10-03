From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How to remove a commit object?
Date: Fri, 03 Oct 2008 14:03:14 +0200
Message-ID: <48E60A02.7080608@viscovery.net>
References: <D53D127D-97DD-417C-9109-ABD46BBD4E18@midwinter.com>	 <48D36DF4.3030607@drmicha.warpmail.net>	 <33f4f4d70810020636g77f4180cm7aa6b7de07ae5beb@mail.gmail.com>	 <m3ljx7qemk.fsf@localhost.localdomain>	 <33f4f4d70810020726g71c6f39eq16585269fb268322@mail.gmail.com>	 <48E4E27E.7030308@viscovery.net> <33f4f4d70810030442l5042fdbfw18f97336c5a331cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Steven Grimm <koreth@midwinter.com>,
	Git Users List <git@vger.kernel.org>
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 14:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KljPk-0000as-Gt
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 14:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbYJCMDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 08:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752781AbYJCMDS
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 08:03:18 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40440 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbYJCMDS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 08:03:18 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KljNL-00053a-3F; Fri, 03 Oct 2008 14:03:15 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D1B6969F; Fri,  3 Oct 2008 14:03:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <33f4f4d70810030442l5042fdbfw18f97336c5a331cc@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97417>

Klas Lindberg schrieb:
> On Thu, Oct 2, 2008 at 5:02 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> I assume that you used --subdirectory-filter. This has issues that will be
>> fixed in 1.6.1. You need a current 'master' git (at least b805ef08).
>
> Is there some way to do what I need with git-filter-branch today, or
> must I wait until 1.6.1 is released?

You can remove all occurences of the "--full-history" flag from your
/usr/libexec/git-core/git-filter-branch script. This is sufficient for
some repositories because this triggers the bug less often. This means
that the resulting history may still be incorrect, but chances are higher
that it is correct.

Other than that, you can just clone git.git and compile it yourself. It's
a simple matter of "make prefix=$HOME/mytempgit install".

-- Hannes
