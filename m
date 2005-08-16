From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Importing from CVS issues
Date: Tue, 16 Aug 2005 23:26:13 +1200
Message-ID: <46a038f90508160426450eff12@mail.gmail.com>
References: <1124188894.7444.9.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 13:27:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4zaJ-0004n1-7v
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 13:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbVHPL0S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 07:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbVHPL0S
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 07:26:18 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:26587 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932636AbVHPL0R convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 07:26:17 -0400
Received: by rproxy.gmail.com with SMTP id i8so933886rne
        for <git@vger.kernel.org>; Tue, 16 Aug 2005 04:26:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jlNY7IHmi0I/Pt39M07afCphA/vBtPyLLFMkU01tcuB1c7HNVF5QI/iDvtoo1/5FJireP7HnmjFe9ShOaOR0lzo+FbjFzBraWE7VR55UWatGjN/ejQd3+zbenZj8686BeqZ9B/rY23LwxT2wrR5YTygq4yB36U2dpcAVjham5/g=
Received: by 10.38.181.48 with SMTP id d48mr2304218rnf;
        Tue, 16 Aug 2005 04:26:13 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Tue, 16 Aug 2005 04:26:13 -0700 (PDT)
To: Alex Bennee <kernel-hacker@bennee.com>
In-Reply-To: <1124188894.7444.9.camel@okra.transitives.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I haven't seen this problem myself. There are some recent patches
Junio merged that handle some oddities better. Give the 'pu' branch a
go if you can.

I take it that the repo is not public. I'd like to try and reproduce
the problem. Can you get it to happen with a public repository?

For debugging, I'd say proofread the cvsps output, see ~/.cvsps/#repo
. that could give you hints as to the 'nameless' branches. Why is
origin missing is a different problem.

Ah! Important: if you're adding debugging statements by hand, bear in
mind that part of the code is executed in a forked child process, and
prints there will mess things up.

cheers,


martin
