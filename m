From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Mon, 05 Mar 2007 13:27:31 -0800
Message-ID: <7v3b4jxtx8.fsf@assigned-by-dhcp.cox.net>
References: <esgm1m$33f$1@sea.gmane.org>
	<Pine.LNX.4.63.0703051520340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45EC3905.7070406@lu.unisi.ch>
	<Pine.LNX.4.63.0703051648330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45EC4B55.3090505@lu.unisi.ch>
	<Pine.LNX.4.63.0703051812030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45EC51C6.5080505@lu.unisi.ch>
	<Pine.LNX.4.63.0703051930560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45EC8959.1090303@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Mon Mar 05 22:28:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOKjl-0001q0-9d
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 22:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933614AbXCEV2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 16:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933621AbXCEV1f
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 16:27:35 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34637 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933617AbXCEV1c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 16:27:32 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070305212732.XWTO748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 5 Mar 2007 16:27:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id X9TX1W00F1kojtg0000000; Mon, 05 Mar 2007 16:27:32 -0500
In-Reply-To: <45EC8959.1090303@lu.unisi.ch> (Paolo Bonzini's message of "Mon,
	05 Mar 2007 22:19:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41489>

Paolo Bonzini <paolo.bonzini@lu.unisi.ch> writes:

> Actually ISTR that %n is not counted in the return value and that's why I wrote the code this way.

Yes, that is correct.  Some C lib implementations seem to count
%n and others don't so it is not reliable.  That is one of the
reasons I personally have stayed away from fancier sscanf()
constructs, both inside and outside git project.
