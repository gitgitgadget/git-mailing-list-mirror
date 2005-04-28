From: Tony Luck <tony.luck@gmail.com>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 10:10:04 -0700
Message-ID: <12c511ca050428101070e12e74@mail.gmail.com>
References: <200504271251.00635.mason@suse.com>
	 <200504271423.37433.mason@suse.com>
	 <Pine.LNX.4.58.0504271506290.18901@ppc970.osdl.org>
	 <200504280745.05505.mason@suse.com>
	 <1114706099.4212.25.camel@localhost.localdomain>
Reply-To: Tony Luck <tony.luck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chris Mason <mason@suse.com>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 19:05:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRCRP-0002zi-CM
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 19:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVD1RKJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 13:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVD1RKJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 13:10:09 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:24870 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262173AbVD1RKE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 13:10:04 -0400
Received: by zproxy.gmail.com with SMTP id 13so526309nzp
        for <git@vger.kernel.org>; Thu, 28 Apr 2005 10:10:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kyf8Q5tDAg2WSYpKZ0YHodhoGzunVHI7XL5COjLagRGJlVjY8dAH0GhjADhaFQ2T/igoaV48cdDClU+mpFLvqwrbokyPMsmMEjXjPtd201/J2C4cdVLPTx084aAvvn/Ybjmgm60wPGVhznqIFc7dhkzaXQIThLeC2XrnqHP3gWk=
Received: by 10.36.24.7 with SMTP id 7mr108699nzx;
        Thu, 28 Apr 2005 10:10:04 -0700 (PDT)
Received: by 10.36.60.3 with HTTP; Thu, 28 Apr 2005 10:10:04 -0700 (PDT)
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <1114706099.4212.25.camel@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Not really happy clicky, but ... :)
> 
> Look at the (history) link:
>   http://ehlo.org/~kay/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fb3b4ebc0be618dbcc2326482a83c920d51af7de

Looks very useful.  Would it be possible to display the date (from the
commit) instead of
the 40-hex-char blobname (but have the link still point to the blob). 
Like this:

2005-04-27 [PATCH] USB: MODALIAS change for bcdDevice
2005-04-26 Merge with
kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
2005-04-26 Merge with kernel.org:/pub/scm/linux/kernel/git/gregkh/aoe-2.6.git/

That way you'd trade some screen space that is filled with hex numbers for some
useful information.  Dates could either be absolute (as in my
example), or relative
("4 hours ago", "2 weeks ago", etc.)

-Tony
