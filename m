From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [RFC PATCH] Revamp git-cherry(1)
Date: Thu, 21 Nov 2013 22:02:02 +0100
Message-ID: <87pppt31v9.fsf@thomasrast.ch>
References: <3af3069696e3a59d513f1fef0ca797d103f6d882.1385033403.git.tr@thomasrast.ch>
	<xmqqli0h4kvj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, a.huemer@commend.com,
	"Michael S. Tsirkin" <mst@kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 21 22:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjbOB-0002tM-4Z
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 22:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab3KUVCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 16:02:12 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:48221 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755288Ab3KUVCH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 16:02:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id D04534D656F;
	Thu, 21 Nov 2013 22:02:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yTXJL-aOkhyt; Thu, 21 Nov 2013 22:02:04 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id C6C264D6414;
	Thu, 21 Nov 2013 22:02:03 +0100 (CET)
In-Reply-To: <xmqqli0h4kvj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 21 Nov 2013 11:26:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238155>

Junio C Hamano <gitster@pobox.com> writes:

>>  OPTIONS
>>  -------
>>  -v::
>> -	Verbose.
>> +	Verbose.  Currently shows the commit subjects next to their
>> +	SHA1.
>
> Whenever I see "Currently", it makes me wonder "why does it need to
> say that? Is there a plan to change it soon, and if so where is the
> plan described?".

I wanted to avoid documenting exactly what it does, so that in the
future it could do more than that.  Is that overly paranoid?

>> +EXAMPLES
>> +--------
>> +
>> +git-cherry is frequently used in patch-based workflows (see
>> +linkgit:gitworkflows[7]) to determine if a series of patches has been
>> +applied by the upstream maintainer.  In such a workflow you might
>> +create and send a topic branch like this (fill in appropriate
>> +arguments for `...`):
>
> I think the ASCII art commit graph that shows topology which we lost
> by this patch gave a more intiutive sense of what "a topic branch
> like this" looked like than an incomplete skeleton of a command
> sequence that would be understood by those who already know how to
> work with multiple branches.  Perhaps we want both?

Hmm.  I'll ponder for a moment and try to cook something up for v2.  I
can't say exactly what, but after initially trying to keep it, something
felt wrong to me about the ascii art.  Perhaps it's that it is only
vaguely related to the actual output format.

-- 
Thomas Rast
tr@thomasrast.ch
