From: Christopher Faylor <me@cgf.cx>
Subject: Re: First cut at git port to Cygwin
Date: Tue, 4 Oct 2005 23:15:47 -0400
Message-ID: <20051005031547.GC1393@trixie.casa.cgf.cx>
References: <433B3B10.5050407@zytor.com> <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com> <43428C65.3040205@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 05 05:17:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMzlR-000213-7h
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 05:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbVJEDPv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 23:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVJEDPv
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 23:15:51 -0400
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:37270 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1751193AbVJEDPu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 23:15:50 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id 9EA7413C101; Wed,  5 Oct 2005 03:15:47 +0000 (UTC)
To: "H. Peter Anvin" <hpa@zytor.com>, Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <43428C65.3040205@zytor.com>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9697>

On Tue, Oct 04, 2005 at 07:06:29AM -0700, H. Peter Anvin wrote:
>Alex Riesen wrote:
>>
>>I noticed that rename(2) in my copy of cygwin (1.5.18-1) does not remove 
>>the
>>target and returns an error (probably EPERM, but I have reasons not to 
>>trust
>>strerror on that thing).
>>The repository was on FAT.
>>Taking "rename(2)" from cygwin's libiberty solved this (they unlink if 
>>link(2)
>>returns EEXIST).
>>
>>PS: Does broken rename(2) qualify a system "not worthy to support"?
>
>In this case a better way would be to just add -liberty to all link 
>lines if necessary, but I would expect the core cygwin code to do this.

AFAIK, cygwin has a working rename().  Many packages rely on it.

If rename() is not working then a bug report with a test case would be
appreciated.
--
Christopher Faylor			spammer? ->	aaaspam@sourceware.org
Cygwin Co-Project Leader				aaaspam@duffek.com
TimeSys, Inc.
