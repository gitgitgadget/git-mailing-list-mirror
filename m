From: "Patrick Doyle" <wpdster@gmail.com>
Subject: Re: How to create & switch to a branch after changes have already been made?
Date: Mon, 2 Jul 2007 22:49:47 -0400
Message-ID: <e2a1d0aa0707021949k181f9042j26ebd124f61ca1ae@mail.gmail.com>
References: <e2a1d0aa0707021918mb335856j278b3128203a793a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 04:49:56 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5YSd-00043t-Le
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 04:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbXGCCtt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 22:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbXGCCtt
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 22:49:49 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:65049 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbXGCCts (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 22:49:48 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2584718wah
        for <git@vger.kernel.org>; Mon, 02 Jul 2007 19:49:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MPtbWIwPev5FbfR1cfzf3tM0dm1upEWJ+Wk1GB1prrN/a/GPHjZQwpsAC8TN0sq+b2EX7CSN1CgucLD/UtO3pkrXCjB1KRthIb8OKj1t79xADfU6YUZP0lT2awyuezCvu5AuzWyIcdbBlAyCTrubx8JExoCWuz8Qe1v1pMkClGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KkTCA3lbX7+EO4qc0QkVBIhSr9E3JRARcq9afQYFiQr/lHXBkigZOrsuDHyHri5LHdi0af+10yzQidrtULY+BWS8RyIGdVESwUa19H8/LBATl/TMRw66qXcVpIx3pm2FG+R94tzfklhBLTXlqka5JCcbQlvPBzNi3UxOX1rLfEk=
Received: by 10.115.111.1 with SMTP id o1mr5715779wam.1183430987839;
        Mon, 02 Jul 2007 19:49:47 -0700 (PDT)
Received: by 10.114.15.11 with HTTP; Mon, 2 Jul 2007 19:49:47 -0700 (PDT)
In-Reply-To: <e2a1d0aa0707021918mb335856j278b3128203a793a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51441>

Hmmm...
One thing I might tell the hypothetical person is to temporarily
delete or rename the new version of "somefile", so that the merge
could complete with problems, and then recreate or rename it back.
That would probably allow the hypothetical person to continue his/her
work.

--wpd
