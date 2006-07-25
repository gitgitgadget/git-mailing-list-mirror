From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow an alias to start with "-p"
Date: Mon, 24 Jul 2006 17:36:39 -0700
Message-ID: <7virlmfrl4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607190125150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xmjh5sv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607241408170.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 25 02:36:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5Aui-0003XC-50
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 02:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWGYAgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 20:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWGYAgl
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 20:36:41 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:22771 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932359AbWGYAgk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 20:36:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060725003640.HIBH12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Jul 2006 20:36:40 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24156>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now, something like
>
> 	[alias]
> 		pd = -p diff
>
> works as expected.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

This seems to break t5400 among other things (git-clone
complains that it is not invoked in a git repository).
