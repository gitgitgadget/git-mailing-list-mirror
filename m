From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 3/4] line-log: convert to using diff_tree_sha1()
Date: Thu, 06 Feb 2014 22:01:53 +0100
Message-ID: <87wqh8arb2.fsf@thomasrast.ch>
References: <cover.1391619218.git.kirr@mns.spb.ru>
	<cover.1391619218.git.kirr@mns.spb.ru>
	<0df5c2e1e93e4873bf276f3f500109249fe1afee.1391619218.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Thu Feb 06 22:01:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBW4y-0008B9-7X
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 22:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756803AbaBFVBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 16:01:43 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:58606 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756750AbaBFVBm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 16:01:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 5B5024D657B;
	Thu,  6 Feb 2014 22:01:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FOm3crOViwnr; Thu,  6 Feb 2014 22:01:31 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 079AD4D64BD;
	Thu,  6 Feb 2014 22:01:29 +0100 (CET)
In-Reply-To: <0df5c2e1e93e4873bf276f3f500109249fe1afee.1391619218.git.kirr@mns.spb.ru>
	(Kirill Smelkov's message of "Wed, 5 Feb 2014 20:57:11 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241744>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> Since diff_tree_sha1() can now accept empty trees via NULL sha1, we
> could just call it without manually reading trees into tree_desc and
> duplicating code.
>
> Cc: Thomas Rast <tr@thomasrast.ch>
> Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
> ---
>  line-log.c | 26 ++------------------------
>  1 file changed, 2 insertions(+), 24 deletions(-)

You have to love a diffstat like that :-)

Thanks.

-- 
Thomas Rast
tr@thomasrast.ch
