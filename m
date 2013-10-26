From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] for-each-ref: avoid loading objects to print %(objectname)
Date: Sat, 26 Oct 2013 10:35:17 +0200
Message-ID: <877gd0pgze.fsf@linux-k42r.v.cablecom.net>
References: <20131024084638.GA761@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 26 10:35:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZzLc-0007Wy-O1
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 10:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963Ab3JZIff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 04:35:35 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:50343 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825Ab3JZIfd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 04:35:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 267314D6514;
	Sat, 26 Oct 2013 10:35:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7kr6nME1jf41; Sat, 26 Oct 2013 10:35:20 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [213.55.184.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id C76984D6414;
	Sat, 26 Oct 2013 10:35:19 +0200 (CEST)
In-Reply-To: <20131024084638.GA761@sigill.intra.peff.net> (Jeff King's message
	of "Thu, 24 Oct 2013 04:46:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236743>

Jeff King <peff@peff.net> writes:

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 752f5cb..2b4b9a9 100755
[...]
> +test_atom head *objectname ''
> +test_atom head *objecttype ''
[...]
> +test_atom tag *objectname '67a36f10722846e891fbada1ba48ed035de75581'
> +test_atom tag *objecttype 'commit'

Can you quote the *?  I may have become somewhat paranoid, but still.
This is the first use of the *<field> syntax, and test_atom seems
written to correctly quote its arguments, so why risk it? :-)

-- 
Thomas Rast
tr@thomasrast.ch
