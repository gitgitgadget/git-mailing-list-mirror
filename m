From: Junio C Hamano <junkio@cox.net>
Subject: FIXED: [WARNING] Please be careful when using "git add" from "next" branch
Date: Thu, 18 May 2006 23:28:34 -0700
Message-ID: <7vy7wyil4d.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605170927050.10823@g5.osdl.org>
	<7vhd3ocvyy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605171321020.10823@g5.osdl.org>
	<7v64k3698l.fsf@assigned-by-dhcp.cox.net>
	<7vwtcj4tp6.fsf@assigned-by-dhcp.cox.net>
	<7vsln74sv7.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 08:28:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgyTY-0002s9-RP
	for gcvg-git@gmane.org; Fri, 19 May 2006 08:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWESG2h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 02:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWESG2h
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 02:28:37 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:31107 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932241AbWESG2g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 02:28:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060519062835.KXDO15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 May 2006 02:28:35 -0400
To: git@vger.kernel.org
In-Reply-To: <7vsln74sv7.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 18 May 2006 01:52:44 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20327>

Junio C Hamano <junkio@cox.net> writes:

> There is still a small breakage in the built-in "git add" on the
> "next" branch that ends up creating nonsense tree objects.

This was fixed this morning, in case I scared people.
 
