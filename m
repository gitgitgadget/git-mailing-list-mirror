From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Re: Gitk --all error when there are more than 797 refs
 in a repository
Date: Mon, 21 Sep 2009 16:09:20 +0200
Message-ID: <4AB78910.7010402@viscovery.net>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com> <878wgcbb52.fsf@users.sourceforge.net> <19124.8378.975976.347711@cargo.ozlabs.ibm.com> <6F87406399731F489FBACE5C5FFA0458518DE8@ex2k.bankofamerica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org
To: "Murphy, John" <john.murphy@bankofamerica.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 16:09:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mpja7-0007T1-7y
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 16:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756000AbZIUOJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 10:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755934AbZIUOJU
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 10:09:20 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:43583 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880AbZIUOJT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 10:09:19 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MpjZw-0007EF-Qb; Mon, 21 Sep 2009 16:09:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 81C136D9; Mon, 21 Sep 2009 16:09:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <6F87406399731F489FBACE5C5FFA0458518DE8@ex2k.bankofamerica.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128887>

Murphy, John schrieb:
> Paul Mackerras writes:
> 
>> I knew about the 32k command-line limit under windows, but I don't see
>> how that applies in this case unless it is $revs that is too long (and
>> if that is the case then I don't see how your patch helps).  Is there
>> also a 32k limit on the size of data returned by a command executed
>> with [exec]?
> 
> In this case $revs is "--all"
> 
> I believe what I am experiencing is a 32K limit with [exec]

But in order to have a $revs that exceeds 32K, you would already have to
invoke gitk with a huge command line that exceeds the limit (but this is
not possible), no?

How do you run gitk?

-- Hannes
