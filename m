From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow default core.logallrefupdates to be overridden with template's config
Date: Tue, 23 Jan 2007 17:51:36 -0800
Message-ID: <7v4pqhkx93.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0701230754p3425ded4k1f37dd26500c1744@mail.gmail.com>
	<7v64axmcmr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701240245440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 02:51:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9XIb-00046b-9I
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 02:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933165AbXAXBvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 20:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933167AbXAXBvi
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 20:51:38 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:35030 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933165AbXAXBvi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 20:51:38 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070124015137.FYTH7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Tue, 23 Jan 2007 20:51:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Eprv1W00x1kojtg0000000; Tue, 23 Jan 2007 20:51:56 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701240245440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 24 Jan 2007 02:49:17 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37593>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> While on the topic of config files, we should fix the config
>> reader not to allow per-repository variables in ~/.gitconfig
>
> So we finally get this central place where all possible config variables 
> are listed, with options (a la struct cmd_struct) which tell more about 
> where they may be used?
>
> While I think this might make sense, I feel quite uneasy about such a 
> drastic change between -rc2 and -final.

I do not like the "config registry" in 1.5.0 but a simple
blacklisting should work, shouldn't it?
