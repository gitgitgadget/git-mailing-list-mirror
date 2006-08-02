From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Wed, 2 Aug 2006 10:54:41 +0200
Message-ID: <E1G8CUz-0002KI-VW@moooo.ath.cx>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com> <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net> <E1G8ArX-0006r2-6D@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>,
	Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Aug 02 10:54:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8CV8-0002HS-A8
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 10:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWHBIyr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 04:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWHBIyq
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 04:54:46 -0400
Received: from moooo.ath.cx ([85.116.203.178]:22756 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932077AbWHBIyq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 04:54:46 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <E1G8ArX-0006r2-6D@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24641>

Just another idea: add something like @@FOO@@ on a line of its own and
this is replaced by the content of a file if the user specifies one,
nothing if he does not.  This way one could include the config
directly into gitweb.cgi or include a file that includes the
configuration file from another place.
