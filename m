From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: [PATCH] git send-email: edit recipient addresses with the
 --compose flag
Date: Tue, 11 Nov 2008 15:53:17 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811111551450.24205@sys-0.hiltweb.site>
References: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com> <alpine.LFD.2.00.0811091344480.20499@sys-0.hiltweb.site> <20081111014919.GI7408@ece.pdx.edu> <200811111230.28076.fg@one2team.com> <alpine.LFD.2.00.0811111542230.24205@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tait <git.git@t41t.com>, Git Mailing List <git@vger.kernel.org>
To: Francis Galiegue <fg@one2team.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 21:54:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L00Fx-0003Nz-I2
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 21:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbYKKUxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 15:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbYKKUxW
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 15:53:22 -0500
Received: from mail.gmx.com ([74.208.5.67]:48494 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751668AbYKKUxV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 15:53:21 -0500
Received: (qmail invoked by alias); 11 Nov 2008 20:53:20 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com [75.185.223.130]
  by mail.gmx.com (mp-us004) with SMTP; 11 Nov 2008 15:53:20 -0500
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX1/oTG8+n1/o8NfcZJr40RRfjjnw9VDkYxVeoBJCB7
	unZwf76turXjkK
In-Reply-To: <alpine.LFD.2.00.0811111542230.24205@sys-0.hiltweb.site>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100675>

On Tue, 11 Nov 2008, Ian Hilt wrote:

Hm, how about keeping the path to perl in the snippet,

--8<--
#!/usr/bin/perl -Tw
use strict;
my $ws = "To: \nCc:";

$ws =~ /^To:\s*(.+)\s*\nCc:/ism;

if ($1 eq ' ') {
	print "\$1 is equal to a space.\n";
}
-->8--
