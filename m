From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Sat, 07 Dec 2013 23:23:11 +0100
Message-ID: <87fvq41esw.fsf@thomasrast.ch>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
	<52A37D70.3090400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 07 23:23:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpQHb-0001qf-K9
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 23:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098Ab3LGWX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 17:23:27 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:52870 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754289Ab3LGWX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 17:23:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id D58CB4D6510;
	Sat,  7 Dec 2013 23:23:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dl_qe5tTHKDk; Sat,  7 Dec 2013 23:23:13 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 7FA064D64C4;
	Sat,  7 Dec 2013 23:23:13 +0100 (CET)
In-Reply-To: <52A37D70.3090400@gmail.com> (Karsten Blees's message of "Sat, 07
	Dec 2013 20:56:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239027>

Karsten Blees <karsten.blees@gmail.com> writes:

> Extending 'struct hashmap_entry' with an int-sized member shouldn't waste
> memory on 64-bit systems. This is already documented in api-hashmap.txt,
> but needs '__attribute__((__packed__))' to work. Reduces e.g.

You'd have to guard __attribute__((__packed__)) with some compiler
detection in git-compat-util.h though.

-- 
Thomas Rast
tr@thomasrast.ch
