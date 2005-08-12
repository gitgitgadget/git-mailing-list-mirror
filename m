From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Fri, 12 Aug 2005 13:21:07 -0700
Message-ID: <7vpssiucss.fsf@assigned-by-dhcp.cox.net>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
	<7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net>
	<7vacjsdcbj.fsf@assigned-by-dhcp.cox.net>
	<7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net>
	<pan.2005.08.10.21.15.41.143251@smurf.noris.de>
	<pan.2005.08.10.22.11.25.242201@smurf.noris.de>
	<7vd5olqtvp.fsf@assigned-by-dhcp.cox.net>
	<20050810235436.GW28270@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 22:22:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3g1h-0002UX-90
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 22:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVHLUVK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 16:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVHLUVJ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 16:21:09 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:37116 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932077AbVHLUVI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 16:21:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812202108.XNHU7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 12 Aug 2005 16:21:08 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20050810235436.GW28270@kiste.smurf.noris.de> (Matthias Urlichs's
	message of "Thu, 11 Aug 2005 01:54:36 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matthias Urlichs <smurf@smurf.noris.de> writes:

> - Split gitk off to its own package;
>   it needs tk installed, but nothing else does.

I just noticed from "dpkg --info" output that the generated
git-tk has "Architecture: i386".  Shouldn't it read "all" and
resulting package also named git-tk_${VERSION}_all.deb, instead
of whatever architecture I happened to build it?
