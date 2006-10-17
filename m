From: Sam Vilain <sam@vilain.net>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 16:52:02 +1300
Message-ID: <45345362.8040902@vilain.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	 <egrgqe$1i9$1@sea.gmane.org>	 <9e4733910610141606g749d268eudd85791620e1363a@mail.gmail.com>	 <20061015182303.GW20017@pasky.or.cz>	 <9e4733910610151249m37c9f6abv37e07d7a801758bc@mail.gmail.com>	 <20061016032314.GA20017@pasky.or.cz> <9e4733910610152030q45dbeb31l9eb0eb06bd6fd159@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 05:52:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZg08-00042C-QK
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 05:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422829AbWJQDwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 23:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422868AbWJQDwM
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 23:52:12 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:44686 "EHLO
	magnus.utsl.gen.nz") by vger.kernel.org with ESMTP id S1422829AbWJQDwL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 23:52:11 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id EB75E13810F; Tue, 17 Oct 2006 16:52:08 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id D2580138021;
	Tue, 17 Oct 2006 16:52:04 +1300 (NZDT)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910610152030q45dbeb31l9eb0eb06bd6fd159@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29013>

Jon Smirl wrote:
> cvsps works ok on small amounts of data, but it can't handle the full
> Mozilla repo. The current idea is to convert the full repo with
> cvs2git and build the ini file needed by cvsps to support incremental
> imports. After that use cvsps.
>   

Looking through the client.mk used to check out the sub-portions of the
CVS repository, I have to ask;

Why are you trying to import this big collection of projects into a
single git repository?

View git's repositories not as a container for an entire community's
code base, but more as object partitions.  Currently you are quite happy
to use per-file version control partitions inherent to CVS.  Now you are
looking at removing all of the partitions completely and hoping to end
up with something managable.  That it has been possible at all to fit it
into the space less than the size of a CD is staggering, but surely a
piecemeal approach would be a pragmatic solution to this problem.

Sam.
