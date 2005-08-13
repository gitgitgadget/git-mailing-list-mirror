From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added hook in git-receive-pack
Date: Sat, 13 Aug 2005 12:27:39 -0700
Message-ID: <7voe81myc4.fsf@assigned-by-dhcp.cox.net>
References: <200507312117.43957.Josef.Weidendorfer@gmx.de>
	<200508132031.27668.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 21:28:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E41fY-0004uu-Ts
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 21:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVHMT1n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 15:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVHMT1m
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 15:27:42 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:17374 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932206AbVHMT1m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 15:27:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050813192741.IGO15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 Aug 2005 15:27:41 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200508132031.27668.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Sat, 13 Aug 2005 20:31:27 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> Or is there already an easy way to detect the fast-forward situation in the 
> script?

Since you are given old and new, presumably you can do
merge-base in the hook to see what it yields?
