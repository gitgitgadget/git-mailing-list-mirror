From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pager: default to LESS=FRX not LESS=FRSX
Date: Mon, 26 Mar 2007 01:28:55 -0700
Message-ID: <7vwt14xvaw.fsf@assigned-by-dhcp.cox.net>
References: <20070326073502.GD44578@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Mon Mar 26 10:29:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVkZk-0004o0-Nb
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 10:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbXCZI26 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 04:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbXCZI26
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 04:28:58 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:57342 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbXCZI24 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 04:28:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326082855.UBCH748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 04:28:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fLUv1W0021kojtg0000000; Mon, 26 Mar 2007 04:28:56 -0400
In-Reply-To: <20070326073502.GD44578@codelabs.ru> (Eygene Ryabinkin's message
	of "Mon, 26 Mar 2007 11:35:02 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43130>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

> Remove unnecessary '-S' option that enabled less to chop long lines.
> It used to provide some confusion at least for the 'git diff':
> "Where are my long lines? Are they missed from the patch?".

It is not "unnecessary", but only "what _you_ are not used to".
As this breaks expectentions of people already familiar with
what git does by default, I cannot take this patch.
