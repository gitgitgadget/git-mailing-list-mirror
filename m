From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 08/31] rebase: align variable names
Date: Tue, 4 Jan 2011 20:12:25 +0100
Message-ID: <201101042012.25580.trast@student.ethz.ch>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-9-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 20:12:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaCJB-0007WX-7A
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 20:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab1ADTM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 14:12:28 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:50476 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823Ab1ADTM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 14:12:27 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 4 Jan
 2011 20:11:44 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 4 Jan
 2011 20:12:26 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <1293528648-21873-9-git-send-email-martin.von.zweigbergk@gmail.com>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164506>

Martin von Zweigbergk wrote:
> Use the same names for variables that git-rebase--interactive.sh will
> soon inherit from git-rebase.sh.

AFAICS this is partly about spelling the variables in lowercase
instead of all-caps.

Wouldn't it be nicer to simply downcase *all* variables, so that the
end result has a consistent coding style?

> -# $UPSTREAM. They are not necessarily rewritten, but their children
> +# $upstream. They are not necessarily rewritten, but their children
[...]
-- 
Thomas Rast
trast@{inf,student}.ethz.ch
