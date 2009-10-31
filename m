From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Don't create the $GIT_DIR/branches directory on init
Date: Sat, 31 Oct 2009 10:11:29 +0100
Message-ID: <200910311011.31189.trast@student.ethz.ch>
References: <1256923228-18949-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	<spearce@spearce.org>, <sasa.zivkov@sap.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 10:12:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4A0g-0007Mf-P7
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 10:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbZJaJML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 05:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906AbZJaJML
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 05:12:11 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:35501 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbZJaJMK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 05:12:10 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sat, 31 Oct
 2009 10:12:13 +0100
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sat, 31 Oct
 2009 10:12:13 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <1256923228-18949-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131838>

Robin Rosenberg wrote:
> Git itself does not even look at this directory.

This contradicts the git-fetch manpage though: from urls-remotes.txt,
it includes

  The name of one of the following can be used instead
  of a URL as `<repository>` argument:

  * a remote in the git configuration file: `$GIT_DIR/config`,
  * a file in the `$GIT_DIR/remotes` directory, or
  * a file in the `$GIT_DIR/branches` directory.

(and a longer explanation of what they need to look like).

So which one is wrong?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
