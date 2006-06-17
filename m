From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild to avoid broken install
Date: Fri, 16 Jun 2006 22:28:12 -0700
Message-ID: <7vfyi4bbbn.fsf@assigned-by-dhcp.cox.net>
References: <0J0V00LDT7B9BU00@mxout2.netvision.net.il>
	<8aa486160606150426q19b0a661s@mail.gmail.com>
	<f36b08ee0606150440l544455c7r5c52609b360d0f74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 17 07:28:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrTM1-0005mk-HY
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 07:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbWFQF2O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 01:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbWFQF2O
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 01:28:14 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:4001 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751570AbWFQF2N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 01:28:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060617052813.PGZZ11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Jun 2006 01:28:13 -0400
To: "Yakov Lerner" <iler.ml@gmail.com>
In-Reply-To: <f36b08ee0606150440l544455c7r5c52609b360d0f74@mail.gmail.com>
	(Yakov Lerner's message of "Thu, 15 Jun 2006 11:40:50 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22001>

"Yakov Lerner" <iler.ml@gmail.com> writes:

> BTW, is it possible to have git use argv[0] to automatically determine
> the executable_dir without compiled-in paths ?

It is possible and I think we did that some time ago.

We fixed it since then, so that you can migrate away from
assuming bindir==gitexecdir.
