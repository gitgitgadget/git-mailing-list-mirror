From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Teach name-rev to identify revisions containing a certain blob
Date: Sat, 17 Feb 2007 10:24:22 -0800
Message-ID: <7vr6sotzft.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702171838510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mike Coleman <tutufan@gmail.com>,
	junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 17 19:24:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIUEV-00032M-7w
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 19:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbXBQSYY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 13:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbXBQSYY
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 13:24:24 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:42234 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbXBQSYX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 13:24:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217182424.UKAX1300.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 13:24:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QiQN1W00Q1kojtg0000000; Sat, 17 Feb 2007 13:24:23 -0500
In-Reply-To: <Pine.LNX.4.63.0702171838510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 17 Feb 2007 18:39:50 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40004>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If you want to know which revisions contained a certain version
> of a file, just say
>
> 	git name-rev --file <filename>
>
> which will read the file, and give you a list of revisions
> containing a file with the same contents. If <filename> is "-",
> it will read the contents from stdin. Of course, this is a really
> expensive operation.

I expected this to take arbitrary object name and let the caller
to do 'hash-object', so that you could also find a certain tree,
not just blob.
