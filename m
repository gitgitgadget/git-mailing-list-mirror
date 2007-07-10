From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: how to combine two clones in a collection
Date: Tue, 10 Jul 2007 19:51:11 +1200
Message-ID: <46a038f90707100051l5f226799sa8f3231b1c096722@mail.gmail.com>
References: <20070709222250.GA8007@piper.oerlikon.madduck.net>
	 <alpine.LFD.0.999.0707091923300.3412@woody.linux-foundation.org>
	 <20070710062104.GA22603@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git discussion list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 09:51:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8AV9-0000o3-Kp
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 09:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbXGJHvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 03:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752916AbXGJHvN
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 03:51:13 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:40100 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbXGJHvM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 03:51:12 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1122930wxd
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 00:51:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nyGhcjVA6JCUU/iFXwY/MWRbK0KXYrhPVJ8cykd3UtZejTGJ72ldz6boydzRlL0uIDEUNlpUiO1DUNS1PqQhl3ex7CnY3NJME6iBtSl98UKABSK1T1LWE2Whx69qd3G8IROmbY8mw6YaxRVsf7kgvppRKpwzQLvVzM/MY0QeMw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AvsqaJUhz8dMwYWqG+F8JP7mh16xr35POUto5Nh1FCL0mRiotrmZ8NdbdG9IJdYOyYQBCa49EBHnXI1ksyVk22gFTtJ9qZgQL+dOevZV9vh32H1lyFKmcauTWKGD1PpSKz8uoPVdNXUUhcm6FnbIUdFTrk9LhBG22DGGHo0lQzY=
Received: by 10.90.100.2 with SMTP id x2mr2628341agb.1184053871538;
        Tue, 10 Jul 2007 00:51:11 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Tue, 10 Jul 2007 00:51:11 -0700 (PDT)
In-Reply-To: <20070710062104.GA22603@piper.oerlikon.madduck.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52053>

On 7/10/07, martin f krafft <madduck@madduck.net> wrote:
> It does mean, however, that I duplicate the upstream into my repo,
> and thus into the published repo at git.debian.org, because I cannot
> just publish a single branch ('debian') in such a way that people
> could clone it and still be able to build the package against
> upstream (which they'd have to obtain for themselves), right?

Yes. But is that a problem? In most cases, the complete history of the
project is fairly small if your repo is well packed. Often not much
bigger than a tarball of one source snapshot.

What does the following say?

   git repack -a -d
   du -sh .git/objects/pack

cheers,


martni
