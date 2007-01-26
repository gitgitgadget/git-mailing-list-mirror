From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH] diff --check: use colour
Date: Fri, 26 Jan 2007 10:06:54 -0600
Message-ID: <17850.10014.251824.979660@lisa.zopyra.com>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vr6tkdnee.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701251015390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vk5za925w.fsf@assigned-by-dhcp.cox.net>
	<17849.13327.527531.262943@lisa.zopyra.com>
	<Pine.LNX.4.63.0701260034320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17850.8953.478146.754550@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 17:07:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HATbP-0007AC-CH
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 17:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030553AbXAZQG4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 11:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030559AbXAZQG4
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 11:06:56 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60682 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030553AbXAZQGz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 11:06:55 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0QG6s026445;
	Fri, 26 Jan 2007 10:06:54 -0600
In-Reply-To: <17850.8953.478146.754550@lisa.zopyra.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37869>

On Friday, January 26, 2007 at 09:49:13 (-0600) Bill Lear writes:
>...
>Assuming that is correct, I should have a patch out before the end of
>the day.

I did this:

git format-patch -s HEAD^

it produced this file:

0001-Document-check-option-to-git-diff.patch

which looks to be formatted as a mail message:

>From 2a81f1e97564b89ab622cf32b68e7cebf605eafe Mon Sep 17 00:00:00 2001
>From: Bill Lear <rael@zopyra.com>
>Date: Fri, 26 Jan 2007 09:58:07 -0600
>Subject: [PATCH] Document --check option to git-diff.
>
>
>Signed-off-by: Bill Lear <rael@zopyra.com>
>---
> Documentation/diff-options.txt |    5 +++++
> Documentation/git-diff.txt     |    6 ++++++
> 2 files changed, 11 insertions(+), 0 deletions(-)
>...


Do I optionally edit this file, putting my comments before the
"Signed-off-by" line, and then just send this off to the list with my
mail command, i.e.:

% mail git@vger.kernel.org < 0001-Document-check-option-to-git-diff.patch

?


Bill
