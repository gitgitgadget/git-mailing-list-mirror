From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [RFC PATCH] Implement vc-git-annotate-show-diff-revision-at-line for emacs vc-git
Date: Fri, 22 Feb 2008 21:17:56 +0100
Message-ID: <87ejb4kaob.fsf@wine.dyndns.org>
References: <1203706693.7552.56.camel@alexjb-desktop.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 21:19:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSeME-0006h2-6h
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 21:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbYBVUSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 15:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753909AbYBVUSW
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 15:18:22 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:42892 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbYBVUSV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 15:18:21 -0500
Received: from adsl-84-226-29-199.adslplus.ch ([84.226.29.199] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JSeLK-0007Eb-OQ; Fri, 22 Feb 2008 14:18:17 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 48A641E715D; Fri, 22 Feb 2008 21:17:56 +0100 (CET)
In-Reply-To: <1203706693.7552.56.camel@alexjb-desktop.transitives.com> (Alex
	Bennee's message of "Fri, 22 Feb 2008 18:58:13 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74755>

Alex Bennee <kernel-hacker@bennee.com> writes:

> I've had an initial stab at doing this for jumping to the commit in
> annotate mode. You can manually call it with M-x
> vc-git-annotate-show-diff-revision-at-line and it all works fine.
> However the vc logic wants vc-git-previous-version to exist before it
> will call it directly from the mode. I considered evil key-rebinding
> hacks but that seems to nasty.

vc-git is now maintained in the main Emacs repository, so that's the
version you should look at; it does have a vc-git-previous-version
implementation. The vc-git.el in the git repository is an older version
that is not being updated anymore.

-- 
Alexandre Julliard
julliard@winehq.org
