From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 01/14] msvc: Fix compilation errors in compat/win32/sys/poll.c
Date: Tue, 07 Dec 2010 22:54:54 +0000
Message-ID: <4CFEBB3E.2060401@ramsay1.demon.co.uk>
References: <4CFA8E64.6070402@ramsay1.demon.co.uk> <20101204204541.GA3170@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	kusmabite@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 01:30:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ7vI-0007JI-9N
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 01:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649Ab0LHAaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 19:30:13 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:52648 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754548Ab0LHAaM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 19:30:12 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1PQ7v9-0006MW-ar; Wed, 08 Dec 2010 00:30:11 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20101204204541.GA3170@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163152>

Jonathan Nieder wrote:
> Could it make sense to define this at the same time as _GNU_SOURCE et
> al?
> 
> 	#define _ALL_SOURCE 1
> 	#define _GNU_SOURCE 1
> 	#define _BSD_SOURCE 1
> 	#define _NETBSD_SOURCE 1
> 	#define _SGI_SOURCE 1
> 	#define _WIN32_WINNT 0x0502
> 
> Haven't thought carefully about the consequences, though; your patch
> is probably safer.

[Sorry for the late reply, I've been away from email for several days]

This would not fix the compilation errors, since compat/win32/sys/poll.c
does not include the git-compat-util.h header file (and I *don't* think
it should). ;-)

ATB,
Ramsay Jones
