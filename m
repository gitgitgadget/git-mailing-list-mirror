From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 18/31] rebase: extract merge code to new source file
Date: Fri, 31 Dec 2010 13:23:46 +0100
Message-ID: <201012311323.47102.trast@student.ethz.ch>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <201012292231.33333.j6t@kdbg.org> <alpine.DEB.1.10.1012292315070.7175@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 31 13:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYe1S-00059F-Cv
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 13:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365Ab0LaMXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 07:23:49 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:47369 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753237Ab0LaMXs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 07:23:48 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 31 Dec
 2010 13:23:14 +0100
Received: from pctrast.inf.ethz.ch (217.162.250.31) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 31 Dec
 2010 13:23:45 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <alpine.DEB.1.10.1012292315070.7175@debian>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164380>

Martin von Zweigbergk wrote:
> On Wed, 29 Dec 2010, Johannes Sixt wrote:
> > 
> > Is export -f portable?
> 
> It seems like it isn't. What is a good way to check?

On my system I have POSIX docs for various commands, coming from the
'man-pages-posix' package.  Maybe your distribution has those too?
Then you can simply run 'man 1p export' for the documentation.
Anything that is documented there should be safe (except on Windows
maybe).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
