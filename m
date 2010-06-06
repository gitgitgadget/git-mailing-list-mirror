From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] bash completion: Support "unpushed commits" warnings in __git_ps1
Date: Sun, 6 Jun 2010 22:12:56 +0200
Message-ID: <201006062212.56657.trast@student.ethz.ch>
References: <4C0AE640.3040503@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sun Jun 06 22:13:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLMDm-00019d-2c
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 22:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab0FFUNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 16:13:21 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:33571 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579Ab0FFUNU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 16:13:20 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 6 Jun
 2010 22:13:21 +0200
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 6 Jun
 2010 22:12:58 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <4C0AE640.3040503@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148540>

Andrew Sayers wrote:
> People working in small teams sometimes forget to push their changes, causing
> general confusion.  A gentle reminder in the command prompt should help.
[...]
> +#       there're unpushed commits, then a '!' will be shown next to

BTW, here's another idea: how about using '>' and '<' to signal being
ahead and behind upstream, resp. (and both if they diverged)?

(I think the hard question here is whether it's helpful enough to
weigh against the confusion of having it show nothing, because the
user hasn't fetched after an update on the remote...)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
