From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 08/19] ewah: compressed bitmap implementation
Date: Sat, 26 Oct 2013 09:55:43 +0200
Message-ID: <87sivosby8.fsf@linux-k42r.v.cablecom.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
	<20131024180217.GH24180@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 26 09:56:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZyjE-0002pp-3A
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 09:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab3JZH4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 03:56:05 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:50240 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629Ab3JZH4B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 03:56:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 06E614D6414;
	Sat, 26 Oct 2013 09:56:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id U9riJPeXkR82; Sat, 26 Oct 2013 09:55:49 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [213.55.184.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id BC25A4D6514;
	Sat, 26 Oct 2013 09:55:48 +0200 (CEST)
In-Reply-To: <20131024180217.GH24180@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 24 Oct 2013 14:02:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236740>

Jeff King <peff@peff.net> writes:

> From: Vicent Marti <tanoku@gmail.com>
>
> EWAH is a word-aligned compressed variant of a bitset (i.e. a data
> structure that acts as a 0-indexed boolean array for many entries).

Does this contain any changes in response to

  http://thread.gmane.org/gmane.comp.version-control.git/228918/focus=228996

Otherwise that old review still applies ;-)

-- 
Thomas Rast
tr@thomasrast.ch
