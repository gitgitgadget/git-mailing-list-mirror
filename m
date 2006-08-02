From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Wed, 02 Aug 2006 00:45:46 -0700
Message-ID: <7v1wrzwpg5.fsf@assigned-by-dhcp.cox.net>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com>
	<7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net>
	<46a038f90608011913t777cf20dh9baaf355b19d18e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 09:45:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8BQN-0000fq-Du
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 09:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWHBHps (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 03:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWHBHps
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 03:45:48 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:36737 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751344AbWHBHps (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 03:45:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060802074547.WAXD6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Aug 2006 03:45:47 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90608011913t777cf20dh9baaf355b19d18e6@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 2 Aug 2006 14:13:51 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24635>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> I'm a bit lost as to gitweb config. Are we not relying on %ENV for
> this stuff?

It is Ok to use %ENV as an alternative way, but I'd rather not
make it the _only_ way for basic configuration.  Not everybody
runs Apache.
