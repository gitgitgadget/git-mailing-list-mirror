From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/5] git-instaweb: store parameters in config
Date: Wed, 26 Jul 2006 12:16:38 -0700
Message-ID: <7v3bcorxbd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607261633320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 26 21:16:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5os6-0007NJ-Qk
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 21:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWGZTQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 15:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWGZTQk
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 15:16:40 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:47504 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751764AbWGZTQj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 15:16:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060726191639.CTFG6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Jul 2006 15:16:39 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607261633320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 26 Jul 2006 16:33:43 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24239>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It already reads the config for defaults, and now it also stores
> the last passed parameters in the config.

This might need to be conditional -- usually people override the
default from the command line as a one-shot thing, and storing
them in the configuration file would upset them.
