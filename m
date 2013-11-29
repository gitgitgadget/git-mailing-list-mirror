From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 1/2] commit-slab: document clear_$slabname()
Date: Fri, 29 Nov 2013 20:35:09 +0100
Message-ID: <87txevdms2.fsf@thomasrast.ch>
References: <cover.1385405977.git.tr@thomasrast.ch>
	<7f773c5c5ea16b19840f67ba99961be132940d32.1385405977.git.tr@thomasrast.ch>
	<20131125202409.GO4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 29 20:35:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmTqf-0001Ay-Qd
	for gcvg-git-2@plane.gmane.org; Fri, 29 Nov 2013 20:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab3K2Tfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Nov 2013 14:35:30 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:36040 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752634Ab3K2Tf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Nov 2013 14:35:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id C26A54D6574;
	Fri, 29 Nov 2013 20:35:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 67SbAdEXiTVV; Fri, 29 Nov 2013 20:35:12 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (unknown [213.55.184.182])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id E9D554D64DE;
	Fri, 29 Nov 2013 20:35:10 +0100 (CET)
In-Reply-To: <20131125202409.GO4212@google.com> (Jonathan Nieder's message of
	"Mon, 25 Nov 2013 12:24:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238535>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thomas Rast wrote:
>
>> + *
>> + * - void clear_indegree(struct indegree *);
>> + *
>> + *   Free the slab's data structures.
>
> Tense shift (previous descriptions were in the present tense, while
> this one is in the imperative).
>
> More importantly, this doesn't answer the questions I'd have if I were
> in a hurry, which are what exactly is being freed (has the slab taken
> ownership of any memory from the user, e.g. when elemtype is a
> pointer?) and whether the slab needs to be init_ ed again.
>
> Maybe something like the following would work?
[...]

Ok, I see that while I was procrastinating, you sorted this out and
Junio merged it to next.

Thanks, both.

-- 
Thomas Rast
tr@thomasrast.ch
