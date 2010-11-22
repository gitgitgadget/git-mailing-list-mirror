From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] rebase -i: remove undocumented '--verify' flag
Date: Mon, 22 Nov 2010 14:14:15 +0100
Message-ID: <201011221414.15982.trast@student.ethz.ch>
References: <1290408504-14639-1-git-send-email-martin.von.zweigbergk@gmail.com> <vpqoc9hsemy.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	<git@vger.kernel.org>, Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 22 14:20:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKWJv-000552-UP
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 14:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059Ab0KVNUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 08:20:31 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:29131 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754093Ab0KVNUa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 08:20:30 -0500
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Nov 2010 08:20:30 EST
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 22 Nov
 2010 14:13:58 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 22 Nov
 2010 14:14:16 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.36-93-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <vpqoc9hsemy.fsf@bauges.imag.fr>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161888>

Matthieu Moy wrote:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> 
> > Remove the undocumented and unused '--verify' flag from interactive
> > rebase.
> 
> I don't think this change is good. If a command has a --no-whatever
> flag, one expects the --whatever flag to exist too, even if it's a
> no-op.
[...]
> I think a better change would be to add a comment like
> 
> --verify)
> 	# no-op, exists because --no-verify exists too.

Shouldn't that be

  OK_TO_SKIP_PRE_REBASE=

instead, so that it undoes the effect of an earlier --no-verify?

> 	;;
-- 
Thomas Rast
trast@{inf,student}.ethz.ch
