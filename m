From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Notes in format-patch (was: Re: [PATCHv3] replace: parse revision
 argument for -d)
Date: Tue, 13 Nov 2012 11:30:19 +0100
Message-ID: <50A2213B.4060505@drmicha.warpmail.net>
References: <50A0B896.8050700@drmicha.warpmail.net> <a35a8f44b908bded0b475b02e7917011fb3bf90b.1352728712.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 11:30:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYDlR-0006xa-31
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 11:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789Ab2KMKaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 05:30:25 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54368 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754756Ab2KMKaV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2012 05:30:21 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 17CB520815;
	Tue, 13 Nov 2012 05:30:21 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 13 Nov 2012 05:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=BtmThF78FGXxI5GmI1Ae87
	ry8mw=; b=Ee0eKllDKuMO2Le48jUNagE0ECwDTp+OgY2UQ1f73GNzMcWghzpp67
	sadL+ekwaFv/mR0UYpZ0Wua3CWNvX1PtBj5ZNGUhlHHjo0AcJAsB4TDm3wfYD8Y7
	yDjKJqrKAO8bizB/yj7Z+4XdZS8G518pJd0zOjR13Y96pEtuEMqqw=
X-Sasl-enc: WYHWutvpMOU1w7XSW2lVpa/Fikc+cOMWRmH3JVvFOAnw 1352802620
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 651698E0520;
	Tue, 13 Nov 2012 05:30:20 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <a35a8f44b908bded0b475b02e7917011fb3bf90b.1352728712.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209594>

Michael J Gruber venit, vidit, dixit 12.11.2012 15:18:
> 'git replace' parses the revision arguments when it creates replacements
> (so that a sha1 can be abbreviated, e.g.) but not when deleting
> replacements.
> 
> Make it parse the argument to 'replace -d' in the same way.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> 
> Notes:
>     v3 safeguards the hex buffer against reuse
>  builtin/replace.c  | 16 ++++++++++------
>  t/t6050-replace.sh | 11 +++++++++++
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/replace.c b/builtin/replace.c

By the way - Junio, is that the intented outcome of "format-patch
--notes"? I would rather put the newline between the note and the
diffstat (and omit the one after the ---) but may have goofed up a rebase:

...

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Notes:
    v3 safeguards the hex buffer against reuse

 builtin/replace.c  | 16 ++++++++++------
...
