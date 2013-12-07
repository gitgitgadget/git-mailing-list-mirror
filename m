From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v3 12/21] rev-list: add bitmap mode to speed up object lists
Date: Sat, 07 Dec 2013 17:05:57 +0100
Message-ID: <87txekk5ne.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <20131114124157.GA23784@sigill.intra.peff.net>
	<20131114124523.GL10757@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Vicent =?utf-8?Q?Mart=C3=AD?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 07 17:06:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpKOV-0007Nc-8b
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 17:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304Ab3LGQGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 11:06:11 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:52138 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755204Ab3LGQGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 11:06:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 0F78C4D6510;
	Sat,  7 Dec 2013 17:06:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sexWlqHGmDoN; Sat,  7 Dec 2013 17:05:58 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (84-73-190-173.dclient.hispeed.ch [84.73.190.173])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id B12264D64C4;
	Sat,  7 Dec 2013 17:05:57 +0100 (CET)
In-Reply-To: <20131114124523.GL10757@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Nov 2013 07:45:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238987>

Jeff King <peff@peff.net> writes:

>  Documentation/git-rev-list.txt     |  1 +
>  Documentation/rev-list-options.txt |  8 ++++++++
>  builtin/rev-list.c                 | 39 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)

Nice and short.  Cheating though, as a lot of the support code is from
[10/21] ;-)

Reviewed-by: Thomas Rast <tr@thomasrast.ch>

-- 
Thomas Rast
tr@thomasrast.ch
