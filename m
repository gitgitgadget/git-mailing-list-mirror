From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Suggestion: "man git clone"
Date: Thu, 21 Aug 2008 10:22:47 -0700
Message-ID: <48ADA467.1030407@zytor.com>
References: <48ACB29C.7000606@zytor.com> <48ACB5F4.3000905@sneakemail.com>	 <48AD99DF.5090802@zytor.com> <32541b130808211007xf295e40l567ecf785a8fca22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>, flucifredi@acm.org,
	Git ML <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 19:24:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWDt9-0007aY-Ge
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 19:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbYHURWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 13:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbYHURWz
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 13:22:55 -0400
Received: from terminus.zytor.com ([198.137.202.10]:47239 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbYHURWy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 13:22:54 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7LHMmBp001858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Aug 2008 10:22:49 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7LHMmQn027037;
	Thu, 21 Aug 2008 10:22:48 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7LHMlhE018665;
	Thu, 21 Aug 2008 10:22:47 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <32541b130808211007xf295e40l567ecf785a8fca22@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.93.3/8065/Thu Aug 21 08:27:29 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93178>

Avery Pennarun wrote:
> 
> [and I put him back...]
> 
> Unfortunately what we don't have is a proposal that would work better.
>  Also, changing the behaviour of 'man' wouldn't work on any platform
> other than Linux (presumably), which means the git documentation
> wouldn't be able to rely on that behaviour.
> 
> Still, in a perfect world, what *should* man do in such a case?
> Automatically open /usr/man/man1/git/clone.1?
> 

That would probably be the best option, other options are 
$MANPATH/man1/git\ clone.1 or $MANPATH/mangit/clone.git (I actually 
tried that on the assumption that it might treat "git" as a section; 
unfortunately, it didn't work.)

	-hpa
