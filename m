From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Tue, 16 Jan 2007 13:12:12 +0100
Message-ID: <46d6db660701160412v6de41281sf167f23e7045017e@mail.gmail.com>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
	 <8E585186-FC3F-473B-BA1F-91CFEF1A63F4@silverinsanity.com>
	 <20070113203456.GA17648@spearce.org>
	 <Pine.LNX.4.63.0701141340020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070114224204.GA10888@spearce.org>
	 <7v4pqtf699.fsf@assigned-by-dhcp.cox.net>
	 <20070115011217.GA11240@spearce.org>
	 <Pine.LNX.4.64.0701151727310.20138@iabervon.org>
	 <200701160034.l0G0YC5J005016@laptop13.inf.utfsm.cl>
	 <Pine.LNX.4.64.0701152154030.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 16 13:12:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6nAn-0005yp-DF
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 13:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbXAPMMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 07:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbXAPMMO
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 07:12:14 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:28705 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbXAPMMO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 07:12:14 -0500
Received: by wr-out-0506.google.com with SMTP id i20so163562wra
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 04:12:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RYz+9jQDsey8MvvToF4GS7wjkXslvvQEKdSCCY3RhYgbchMzf1nFXHzPli4nNvSosX0L2T7JE6RBPLXiz1MUxM0Ielj4txOxncg7j/tIUl1NGuGbDPjs7pWqB7sMb2c1DnTvvydsyV9jsQ3ybwcyU48WRJdjZjgaGgcJTcOgquE=
Received: by 10.35.43.10 with SMTP id v10mr9859599pyj.1168949532431;
        Tue, 16 Jan 2007 04:12:12 -0800 (PST)
Received: by 10.35.30.9 with HTTP; Tue, 16 Jan 2007 04:12:12 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0701152154030.20138@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36934>

This is an interesting idea... so I went through the <<silly>> exercise of
downloading 117 tar bzipped versions of the kernel 2.6 (from 2.6.0 to
2.6.19.2, without the release candidates). Quite an interesting
benchmark.

Then I started importing them, through a similar script, creating a
branch for each version (for easy checkout). It takes around
1.5 hours to complete.

Results:
======

initial point: 4.3Gb of tar.bz2 files

intermediate: ~800Mb with ~120000 git objects

final point: 100Mb with prune-packed objects
(so it's about 2.5x the average tar.bz2 size of just a single kernel)

--
Christian
