From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: The merge from hell...
Date: Thu, 2 Feb 2006 08:25:40 +0100
Message-ID: <e5bfff550602012325s7d0a799ct5bfabbce2c579449@mail.gmail.com>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 08:25:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Yqe-00032J-Un
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 08:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423344AbWBBHZm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 02:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423345AbWBBHZm
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 02:25:42 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:21485 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423344AbWBBHZl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 02:25:41 -0500
Received: by zproxy.gmail.com with SMTP id 34so333194nzf
        for <git@vger.kernel.org>; Wed, 01 Feb 2006 23:25:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z9XtL7TLBCZm4bWtEgvkqrAWRzTLqWrEvGAc19pT9ATTmQ10rR8LEwt9eGbYUS6RlCsiddIYb8DYxyP1ocEUDMugyVc2HJQ1kb1c5WilSCMYyOljs4CcQdZ8ME8lV6kVdv4WiT3mm9v5D4i+iXe4KvQG2C6LQRVz1eRTZdZvaPU=
Received: by 10.65.192.11 with SMTP id u11mr186655qbp;
        Wed, 01 Feb 2006 23:25:40 -0800 (PST)
Received: by 10.64.131.15 with HTTP; Wed, 1 Feb 2006 23:25:40 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15489>

On 2/2/06, Linus Torvalds <torvalds@osdl.org> wrote:
>

> Btw, I think you're better off parsing the "git-diff-tree --cc" output
> than doing it yourself like gitk does, now that core git has support for
> things like that.
>

Currently the public git repo version of qgit uses "git-diff-tree -c"
for merges, It's not a problem to change qgit to use --cc option
instead. But I would like to use just one kind of option to filter
merges files.

So I would like to hear some feedback on using --cc vs -c.

Marco
