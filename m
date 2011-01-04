From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 26/31] rebase: remember strategy and strategy options
Date: Tue, 4 Jan 2011 20:27:26 +0100
Message-ID: <201101042027.26737.trast@student.ethz.ch>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-27-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 20:27:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaCXg-0000ix-67
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 20:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315Ab1ADT13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 14:27:29 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:51050 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014Ab1ADT12 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 14:27:28 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 4 Jan
 2011 20:26:45 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 4 Jan
 2011 20:27:27 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <1293528648-21873-27-git-send-email-martin.von.zweigbergk@gmail.com>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164514>

Martin von Zweigbergk wrote:
> How to add support for strategy options to interactive rebase?

AFAICS rebase -i currently only uses the strategy when dealing with
multiple parents, i.e., in --preserve-merges mode.  I think
git-cherry-pick needs to learn about the -s and -X options, and then
it'll be a simple matter of passing them along.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
