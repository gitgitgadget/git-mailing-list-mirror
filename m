From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail header
Date: Sat, 13 Jan 2007 09:57:41 -0800
Message-ID: <7v8xg6lsh6.fsf@assigned-by-dhcp.cox.net>
References: <871wm08kcu.fsf@morpheus.local>
	<7vd55jrj38.fsf@assigned-by-dhcp.cox.net>
	<7vr6tzogp4.fsf@assigned-by-dhcp.cox.net>
	<7vmz4nog5b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701131217410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 18:57:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5n8U-00036L-Gl
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 18:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422737AbXAMR5o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 12:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422738AbXAMR5o
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 12:57:44 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:63376 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422737AbXAMR5n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 12:57:43 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070113175743.GLID3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sat, 13 Jan 2007 12:57:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ahxy1W00g1kojtg0000000; Sat, 13 Jan 2007 12:57:59 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701131217410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 13 Jan 2007 12:19:47 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36762>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Why not just use is_utf8() and warn, or error out, if the message is not 
> UTF-8? (I tend towards the erroring out, since this _is_ a new feature, 
> and gives undesired results with "old" commits.)

That sounds sensible.
