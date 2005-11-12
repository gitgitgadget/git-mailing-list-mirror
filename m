From: Craig Schlenter <craig@codefountain.com>
Subject: Re: Balanced packing strategy
Date: Sat, 12 Nov 2005 17:14:36 +0200
Message-ID: <b6abcb70496730705046934973221b93@codefountain.com>
References: <1131800663.29461.11.camel@blade> <cae2e895f6598781f4f22b76e781684b@codefountain.com> <20051112135947.GC30496@pasky.or.cz>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 16:19:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eax8q-0005rS-DY
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 16:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVKLPSE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 10:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVKLPSE
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 10:18:04 -0500
Received: from mail-01.jhb.wbs.co.za ([196.30.31.196]:40589 "EHLO
	mail-01.jhb.wbs.co.za") by vger.kernel.org with ESMTP
	id S932392AbVKLPSD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 10:18:03 -0500
Received: from wbs-196-2-106-33.wbs.co.za ([196.2.106.33] helo=[172.17.17.2])
	by mail-01.jhb.wbs.co.za with esmtp (Exim 4.50)
	id 1Eax8e-0005H1-4U; Sat, 12 Nov 2005 17:18:00 +0200
In-Reply-To: <20051112135947.GC30496@pasky.or.cz>
To: Petr Baudis <pasky@suse.cz>
X-Mailer: Apple Mail (2.623)
X-Original-Subject: Re: Balanced packing strategy
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11690>

On 12 Nov 2005, at 3:59 PM, Petr Baudis wrote:

> Dear diary, on Sat, Nov 12, 2005 at 02:40:50PM CET, I got a letter
> where Craig Schlenter <craig@codefountain.com> said that...
>> The 100MB situation is not cool for those of us on a tight bandwidth
>> budget or slow links. Can anyone tell me if the native git protocol is
>> any better at this stuff please?
>
> Yes, the native GIT protocol transfers only the objects you need.

Ah, magic, thanks!

> But the 100MB situation is still bad. FWIW, this is my proposal I sent
> about a month ago to some packs-related discussion at the kernel.org
> mailing list (ok, I updated it a little):

It would be nice if there was some meaningful automatic packing that
didn't hurt "non-git-aware protocol" users.

Does the pack index file contain enough information to enable a client
to send http byte range requests to grab individual objects from a pack?
It does seem to store object offsets but maybe I'm missing something ...

Thank you,

--Craig
