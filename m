From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS keyword expansion
Date: Mon, 23 Jul 2007 20:43:31 -0400
Message-ID: <9e4733910707231743w759afabfvd43045ad2e2eba5a@mail.gmail.com>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com>
	 <Pine.LNX.4.64.0707222013200.14781@racer.site>
	 <9e4733910707221248q45fb3aaala9c79afd4b09830e@mail.gmail.com>
	 <Pine.LNX.4.64.0707222238180.14781@racer.site>
	 <9e4733910707221645x21d74e70y3c43bc8c02a9d4ca@mail.gmail.com>
	 <Pine.LNX.4.64.0707230048570.14781@racer.site>
	 <9e4733910707221711u6e965e6cr29e06fa8fb09165@mail.gmail.com>
	 <Pine.LNX.4.64.0707230136360.14781@racer.site>
	 <9e4733910707230744u2d3a0a31t9f65d5c9e68c9805@mail.gmail.com>
	 <Pine.LNX.4.64.0707231933030.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 02:43:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID8V4-0001Ze-5B
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 02:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940AbXGXAnd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 20:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755256AbXGXAnd
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 20:43:33 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:60745 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238AbXGXAnd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 20:43:33 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1250903nze
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 17:43:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Soe2secQhRQicWXymV3+4+Ih6ZZoH1J41Erbl+u0EPsk9sMNZ5SYGwKpD6uWDjpQKmAbzoaAYNXmDFWCGtJ2LQRJab8HdRY/39dQpl0bOY0Jf5xFLdcxndcTk6sgjAz8s1mAZwd4NrdwvxnBc9AukXM7D4rawYo+T1IQCMCX3yk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Awrc7xIVhE44Jk0FtVBW3bGg4lI+8WzNezWs7gQiomYk1vtCE4UHUtVhPkajYweIfRbQIC+KK6NrZZRU9F7Ww/ySCC3ubHgxSF89Y/8xV4fighVACtr9LXCN99cPntzBwx/JHo0ydXidl0w5P9ehClVmUozmU76Ljld/2wNguLQ=
Received: by 10.115.79.1 with SMTP id g1mr3527594wal.1185237811350;
        Mon, 23 Jul 2007 17:43:31 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Mon, 23 Jul 2007 17:43:31 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707231933030.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53516>

Thanks for working on this. I'd like to see it added to git toolkit.
This diff is way easier to read now. I can see that it has SPI support
backported from some future version.

But... it still has some problems.
For the phytec patch it's not getting the $Log changes in the qlogic
files right.

I'm checking the output diff line by line for problems. It's down to
11,528 lines from 88,787. That's a lot of junk removed, I'll have to
make sure it isn't removing too much.

-- 
Jon Smirl
jonsmirl@gmail.com
