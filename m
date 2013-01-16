From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 17:18:09 +0000
Message-ID: <20130116171809.GA2476@farnsworth.metanate.com>
References: <1358348003-11130-1-git-send-email-max@quendi.de>
 <20130116160410.GC22400@sigill.intra.peff.net>
 <7vk3rdxe5y.fsf@alter.siamese.dyndns.org>
 <CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>, git <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:18:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvWdJ-00033Y-GM
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 18:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756303Ab3APRSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 12:18:16 -0500
Received: from dougal.metanate.com ([90.155.101.14]:8441 "EHLO metanate.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755726Ab3APRSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 12:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com; s=stronger;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=qd1xhpXsWFeWn7ZTatwreJLILZVEl3oZHh9/734ycEA=;
	b=LqpVx4KnamIxx39C3jU6AbVq2+S6bmUPxoJd9DXEhpPr2QqK4Hbca8LQ+JiC68/JKF0QtCCGNIUvC0TOGv33ZxZ7sDl0q7jpOtErBhv0Sc2Sw9FhzHKhnIl8OPqLOF2G7j5UDIeQqT2wGoopqcXMQfJQuDYOWnsVbGCQvnO7ttAypmg3ZZ6ATXeWfdFXB/JBhXOnexGGUuDjjXZ4aZnn0Lu0Ry8SpXCEy2eerLxpOnJcvs8r3SzauRFU74aIsEtSekMaBpVviNoWPuhAUMLANAGm2HLNuhTbLfUH0YKBZV9+3M6nhZ7oN6LNtCLpojJFYYZ30TYCc/FJSUwStKliAg==;
Received: from brian.metanate.com ([192.168.88.1] helo=farnsworth.metanate.com)
	by shrek.metanate.com with esmtps (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <john@keeping.me.uk>)
	id 1TvWcs-0004QN-0a; Wed, 16 Jan 2013 17:18:10 +0000
Content-Disposition: inline
In-Reply-To: <CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213774>

On Wed, Jan 16, 2013 at 06:12:57PM +0100, Antoine Pelisse wrote:
> FWIW, I also happen to have the warning:
> 
> advice.c:69:2: warning: expression result unused [-Wunused-value]
>         error("'%s' is not possible because you have unmerged files.", me);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./git-compat-util.h:314:55: note: expanded from:
> #define error(fmt, ...) (error((fmt), ##__VA_ARGS__), -1)
>                                                       ^~
> 
> with clang: Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final)
> (based on LLVM 3.0)

I have the same output with:

clang version 3.2 (tags/RELEASE_32/final)
