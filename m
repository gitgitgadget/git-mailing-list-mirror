From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] prune: --expire=time
Date: Sun, 21 Jan 2007 11:37:24 +0100
Message-ID: <20070121103724.GA23256@moooo.ath.cx>
References: <20070118172408.GG15428@spearce.org> <20070118174244.GA14287@moooo.ath.cx> <20070118175134.GH15428@spearce.org> <20070118222919.GA22060@moooo.ath.cx> <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net> <20070119034404.GA17521@spearce.org> <20070119104935.GA5189@moooo.ath.cx> <7vfya6hll3.fsf@assigned-by-dhcp.cox.net> <20070120111832.GA30368@moooo.ath.cx> <7vlkjw50nl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 11:37:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8a4z-00063k-2X
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 11:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbXAUKh3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 05:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbXAUKh3
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 05:37:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:46251 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751391AbXAUKh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 05:37:28 -0500
Received: (qmail invoked by alias); 21 Jan 2007 10:37:26 -0000
Received: from pD9EBAE7B.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.174.123]
  by mail.gmx.net (mp030) with SMTP; 21 Jan 2007 11:37:26 +0100
X-Authenticated: #5358227
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vlkjw50nl.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37314>

Junio C Hamano <junkio@cox.net> wrote:
> I am considering to commit the attached instead.
Looks fine.  Just one question:  You said normally unsigned long would
be used for time_t but time_t itself seems to be signed.  Using
unsigned long instead of int for prune_grace_period (which is used as
time_t here) results in 'warning: comparison between signed and
unsigned'.  Perhaps you want to change it here anyway to be consistent
with the rest of the code (approxidate returns unsigned long too).
