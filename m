From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Update documentation of fetch-pack, push and send-pack
Date: Fri, 19 Jan 2007 11:22:37 -0800
Message-ID: <7v7ivihldu.fsf@assigned-by-dhcp.cox.net>
References: <20070119124300.GA2995@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 19 20:22:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7zJy-0005FZ-Mc
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 20:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbXASTWk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 14:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932858AbXASTWk
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 14:22:40 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:34304 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932856AbXASTWj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 14:22:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119192238.DHUB18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 14:22:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id D7Nv1W0121kojtg0000000; Fri, 19 Jan 2007 14:22:56 -0500
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20070119124300.GA2995@cepheus> (Uwe =?iso-8859-1?Q?Kleine-K?=
 =?iso-8859-1?Q?=F6nig's?= message of
	"Fri, 19 Jan 2007 13:43:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37194>

I think this series, including the last RFC one, is very
sensible.  Even though, strictly speaking, this is a new
feature, I think we should have it in 1.5.0.

We would need a similar change on fetch-pack and peek-remote
side.
