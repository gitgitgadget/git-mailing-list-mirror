From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Make tag names (i.e. the tag object's "tag" line) optional
Date: Sun, 10 Jun 2007 15:46:15 -0700
Message-ID: <7vps435sy0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	<7vwsyc8bt3.fsf@assigned-by-dhcp.cox.net>
	<200706101347.57023.johan@herland.net>
	<200706101349.33280.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 00:46:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxWB2-0007g2-FR
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 00:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761812AbXFJWqU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 18:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761514AbXFJWqT
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 18:46:19 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41541 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759626AbXFJWqR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 18:46:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610224615.YIZI18396.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 18:46:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9ymG1X0041kojtg0000000; Sun, 10 Jun 2007 18:46:17 -0400
In-Reply-To: <200706101349.33280.johan@herland.net> (Johan Herland's message
	of "Sun, 10 Jun 2007 13:49:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49783>

Johan Herland <johan@herland.net> writes:

> The tag line is now optional. If not given in the tag object data, it
> defaults to the empty string ("") in the parsed tag object.

Sorry, I may have missed the discussion.  I recall that we
talked about tagger line which may not exist for historical
reasons, but have we heard any reasoning behind this?
