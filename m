From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add support for parallel HTTP transfers
Date: Thu, 06 Oct 2005 22:15:42 -0700
Message-ID: <7vwtkp29hd.fsf@assigned-by-dhcp.cox.net>
References: <20051005214447.GF15593@reactrix.com>
	<Pine.LNX.4.63.0510061550510.23242@iabervon.org>
	<20051007000041.GH15593@reactrix.com>
	<7virwa5ety.fsf@assigned-by-dhcp.cox.net>
	<20051007045639.GA18998@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 07:16:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENkaN-00060K-Uk
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 07:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVJGFPo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 01:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVJGFPo
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 01:15:44 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:42485 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932121AbVJGFPo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 01:15:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051007051528.WQA24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Oct 2005 01:15:28 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051007045639.GA18998@reactrix.com> (Nick Hengeveld's message
	of "Thu, 6 Oct 2005 21:56:39 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9797>

Nick Hengeveld <nickh@reactrix.com> writes:

> Not that I'm a huge fan of using environment variables, but it might make
> sense to use one here.  That would allow the setting to work whether
> git-http-fetch is run directly or via git-fetch.  GIT_HTTP_MAX_REQUESTS?

Good point.
