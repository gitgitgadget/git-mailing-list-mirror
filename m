From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] Documentation: --amend cannot be combined with -c/-C/-F.
Date: Thu, 25 Jan 2007 23:38:05 +0100
Message-ID: <20070125223805.GA13677@moooo.ath.cx>
References: <20070124195446.GA13817@bohr.gbar.dtu.dk> <slrnerh8la.7v0.mdw@metalzone.distorted.org.uk> <7vodom9284.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 25 23:38:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HADEV-0007vK-0a
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 23:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030640AbXAYWiL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 17:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030643AbXAYWiL
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 17:38:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:55340 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030640AbXAYWiK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 17:38:10 -0500
Received: (qmail invoked by alias); 25 Jan 2007 22:38:08 -0000
Received: from pD9EB9DDE.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.157.222]
  by mail.gmx.net (mp045) with SMTP; 25 Jan 2007 23:38:08 +0100
X-Authenticated: #5358227
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vodom9284.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37770>

Junio C Hamano <junkio@cox.net> wrote:
> What you want might be an --amend-tree option; it would be to
> the --amend option what the -C (--reuse-message) option is to
> the -c (--reedit-message).
Why not add --amend-tree and --amend-message (--amend is both in
one)?.  This would allow to amend the tree easily without changing the
message and editing the message without caring for the current state
of the index.
