From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: branch --set-upstream considered harmful
Date: Mon, 7 Jun 2010 08:37:16 +0200
Message-ID: <201006070837.16713.trast@student.ethz.ch>
References: <AANLkTiln_xxnF-e33YA7kkfbBBcBMd40xag8JTW0eqws@mail.gmail.com> <AANLkTikUkkWQl7cYuPiKGaJFYL_JlIGFCXXf7En8t0FN@mail.gmail.com> <AANLkTildT6TRd0sPlv1QbCLO7oOPHM-L1yWNIdhdp0ex@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Tay Ray Chuan <rctay89@gmail.com>, git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 08:37:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLVxr-0007Dp-DQ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 08:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382Ab0FGGhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 02:37:34 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:33910 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674Ab0FGGhe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 02:37:34 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 7 Jun
 2010 08:37:31 +0200
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 7 Jun
 2010 08:37:17 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <AANLkTildT6TRd0sPlv1QbCLO7oOPHM-L1yWNIdhdp0ex@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148578>

Jay Soffian wrote:
> 
> Git is inconsistent.
[...]
> $ git branch --set-upstream=origin/master
> $ git branch --set-upstream origin/master

Doesn't this just make it *more* confusing?

Either we document this, and the user will be left wondering why we
have two almost identical (and by the conventions of many other
programs, including git-send-email, *equivalent*) syntaxes doing,
well, something not quite entirely unlike the same.

Or we don't, and the user will eventually typo it and wonder WTF he
just did wrong.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
