From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 5/6] blame-options.txt: place each -L option variation on its own line
Date: Thu, 18 Jul 2013 13:56:55 +0200
Message-ID: <87hafs84jc.fsf@linux-k42r.v.cablecom.net>
References: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
	<1374096332-7891-6-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 14:05:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzmxs-00068U-TD
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 14:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757865Ab3GRMFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 08:05:40 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:60517 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757434Ab3GRMFk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 08:05:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 162894D651E;
	Thu, 18 Jul 2013 13:57:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MEVpXcMqqwnM; Thu, 18 Jul 2013 13:56:55 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net.ethz.ch (pctrast.inf.ethz.ch [129.132.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 8EBE64D64BD;
	Thu, 18 Jul 2013 13:56:55 +0200 (CEST)
In-Reply-To: <1374096332-7891-6-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Wed, 17 Jul 2013 17:25:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230684>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Standard practice in Git documentation is for each variation of an
> option (such as: -p / --porcelain) to be placed on its own line in the
> OPTIONS table. The -L option does not follow suit. It cuddles
> "-L <start>,<end>" and "-L :<regex>", separated by a comma. This is
> inconsistent and potentially confusing since the comma separating them
> is typeset the same as the comma in "<start>,<end>". Fix this by placing
> each variation on its own line.

Ok, but why not fix them all in one go?

Edited to remove the false positives:

$ git grep -n '^.*,.*::$' Documentation/*.txt
Documentation/blame-options.txt:12:-L <start>,<end>, -L :<regex>::
Documentation/config.txt:1252:gitcvs.dbuser, gitcvs.dbpass::
Documentation/config.txt:1513:http.lowSpeedLimit, http.lowSpeedTime::
Documentation/git-add.txt:90:-e, \--edit::
Documentation/git-check-attr.txt:22:-a, --all::
Documentation/git-check-ignore.txt:26:-q, --quiet::
Documentation/git-check-ignore.txt:30:-v, --verbose::
Documentation/git-check-ignore.txt:42:-n, --non-matching::
Documentation/git-log.txt:65:-L <start>,<end>:<file>, -L :<regex>:<file>::
Documentation/git-log.txt:156:git log -L '/int main/',/^}/:main.c::
Documentation/git-p4.txt:171:--verbose, -v::
Documentation/git-p4.txt:282:--dry-run, -n::

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
