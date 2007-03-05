From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [BUG] git-diff-tree or git-commit: wrong diff(stat)
Date: Mon, 5 Mar 2007 23:08:14 +0100
Message-ID: <20070305220814.GA17302@moooo.ath.cx>
References: <20070305200751.GA13655@moooo.ath.cx> <7v3b4jzbha.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 23:09:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOLMh-0003I6-3O
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 23:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbXCEWIY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 17:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbXCEWIY
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 17:08:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:40511 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751059AbXCEWIR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 17:08:17 -0500
Received: (qmail invoked by alias); 05 Mar 2007 22:08:15 -0000
X-Provags-ID: V01U2FsdGVkX1+kncEiOmKk/fajr8StLoF8GUbm7Ebi1NokYUnzjE
	3M0uVD0EYE3Za5
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3b4jzbha.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41494>

Junio C Hamano <junkio@cox.net> wrote:
> A cd_to_toplevel before that diff-tree should fix that,
> shouldn't it?

That should fix this problem.  But anyway I think it is strange that
`git diff` and `git diff --` differ in subdirectories (the latter
shows only changes for the current directory).
