From: Junio C Hamano <junkio@cox.net>
Subject: Re: User-wide ignore list
Date: Thu, 15 Feb 2007 03:30:53 -0800
Message-ID: <7vmz3fd5ea.fsf@assigned-by-dhcp.cox.net>
References: <vpq4ppnvi1j.fsf@olympe.imag.fr>
	<Pine.LNX.4.63.0702151152320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 15 12:30:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHepG-0001A4-Mi
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 12:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965661AbXBOLa4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 06:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965895AbXBOLaz
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 06:30:55 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:37358 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965661AbXBOLaz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 06:30:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070215113055.ZQCI21668.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 15 Feb 2007 06:30:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PnWu1W0031kojtg0000000; Thu, 15 Feb 2007 06:30:54 -0500
In-Reply-To: <Pine.LNX.4.63.0702151152320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 15 Feb 2007 11:52:58 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39820>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 15 Feb 2007, Matthieu Moy wrote:
>
>> Is there a way to have a per-user ignore list in git?
>
> It's not really per user, but how about doing it with templates?

It might be an option to introduce a configuration variable that
points at a file to be used in addition to $GIT_DIR/info/exclude.
Then you can set that variable in ~/.gitconfig.
