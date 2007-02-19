From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Mon, 19 Feb 2007 21:50:49 +0100
Message-ID: <m3fy91q3bq.fsf@maximus.localdomain>
References: <200702191839.05784.andyparkins@gmail.com>
	<17881.62094.56975.799862@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Feb 19 21:51:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJFTr-0001Bk-2t
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 21:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbXBSUux (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 15:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbXBSUux
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 15:50:53 -0500
Received: from khc.piap.pl ([195.187.100.11]:55925 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932648AbXBSUuw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 15:50:52 -0500
Received: by khc.piap.pl (Postfix, from userid 500)
	id 025DC66221; Mon, 19 Feb 2007 21:50:50 +0100 (CET)
In-Reply-To: <17881.62094.56975.799862@lisa.zopyra.com> (Bill Lear's message of "Mon, 19 Feb 2007 12:55:10 -0600")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40150>

Bill Lear <rael@zopyra.com> writes:

> Would this be less error-prone, and just as efficient?:
>
> #define PATH_REMOTES "remotes/"
> #define LIT_STRLEN(S) ((sizeof(S) / sizeof(S[0])) -1)
> #define STRLEN_PATH_REMOTES LIT_STRLEN(PATH_REMOTES)

sizeof(char) is always 1.
-- 
Krzysztof Halasa
