From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH RESEND] send-email: add 'specify-author' option
Date: Fri, 6 Apr 2012 21:47:58 +0200
Message-ID: <87d37kr6a9.fsf@thomas.inf.ethz.ch>
References: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>,
	"Pierre Habouzit" <madcoder@debian.org>,
	Michael Witten <mfwitten@MIT.EDU>,
	"Pascal Obry" <pascal@obry.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Brown <git@davidb.org>, Adam Roben <aroben@apple.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Matthew Wilcox <matthew@wil.cx>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 21:48:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGF8o-0006rb-7e
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 21:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757868Ab2DFTsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 15:48:04 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:17036 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757671Ab2DFTsD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 15:48:03 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Fri, 6 Apr
 2012 21:47:59 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (80.219.158.96) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 6 Apr
 2012 21:47:59 +0200
In-Reply-To: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 6 Apr 2012 15:21:13 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [80.219.158.96]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194900>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Some mail servers (Microsoft Exchange) mangle the 'From' header, so
> while applying the patches, the author has to be fixed manually.
>
> This option allows to always specify the author of the commit in the
> body of the message, even if the committer is the author.

I imagine a user forced to send her email over such a broken server
would have this problem all the time.  Wouldn't a config option be in
order?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
