From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Sun, 10 Jun 2007 13:57:35 -0700
Message-ID: <7vzm377cjk.fsf@assigned-by-dhcp.cox.net>
References: <1181425132239-git-send-email-hjemli@gmail.com>
	<11814251322779-git-send-email-hjemli@gmail.com>
	<20070610002802.GD31707@planck.djpig.de>
	<8c5c35580706100158n7dabfce4y5f79f8943d8abb87@mail.gmail.com>
	<20070610121202.GD955MdfPADPa@greensroom.kotnet.org>
	<8c5c35580706100530g256de4a4yb12f4647dae06500@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, "Frank Lichtenheld" <frank@lichtenheld.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 22:57:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxUTo-0000Cb-3a
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 22:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbXFJU5h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 16:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbXFJU5h
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 16:57:37 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:41992 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbXFJU5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 16:57:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610205736.ZVFP14072.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 16:57:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9wxc1X0011kojtg0000000; Sun, 10 Jun 2007 16:57:36 -0400
In-Reply-To: <8c5c35580706100530g256de4a4yb12f4647dae06500@mail.gmail.com>
	(Lars Hjemli's message of "Sun, 10 Jun 2007 14:30:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49765>

"Lars Hjemli" <hjemli@gmail.com> writes:

> Hmm, maybe I should just rename [module] to [submodule] right now? It
> would be better forward compatible with the proposed extension, it
> would 'harmonize' the section names used in .gitmodules and
> .git/config, and it would offer a clean break from what's currently
> supported in 'master'.

Yes, the difference between '[submodule]' vs '[module]' in
.git/config and .gitmodules confused me while looking at your
latest patch series.  I am in favor of unifying them.  We would
not be breaking any released version if we harmonize them now.
