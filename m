From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: --diff-filter=T does not list x changes
Date: Fri, 17 Oct 2008 09:08:10 +0200
Message-ID: <87ej2fvgv9.fsf@kalibalik.dk>
References: <871vyhbsys.fsf@cup.kalibalik.dk>
	<20081016102201.GB20762@sigill.intra.peff.net>
	<7vhc7cq8uq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 09:09:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqjSg-0002Hf-MP
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 09:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbYJQHIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 03:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbYJQHIN
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 03:08:13 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:48126 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbYJQHIN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 03:08:13 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 21C9914062;
	Fri, 17 Oct 2008 09:08:11 +0200 (CEST)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 9BC3A1405A;
	Fri, 17 Oct 2008 09:08:10 +0200 (CEST)
In-Reply-To: <7vhc7cq8uq.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 16 Oct 2008 19\:00\:13 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98451>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>   Select only files [...] have their type (mode) changed (T) [...]
>>
>> which to me indicates that your test case should work. 
>
> That documentation is quite loosely written. Typechange diff is what
> T has always meant, and it never was about the executable bit. The
> word "mode" in that sentence only means the upper bits
> S_IFREG/S_IFLNK (iow, masked by S_IFMT).

I hope you agree that this reading is not obvious from the
documentation, so I will send a patch later fixing up the prose (if
nobody beats me to it).

How about adding a diff-filter=X for the executable bit? I could
probably look at that during the weekend.


Anders.
