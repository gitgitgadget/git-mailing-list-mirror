From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fetch-pack: start multi-head pulling.
Date: Sat, 13 Aug 2005 02:09:57 -0700
Message-ID: <7vd5oip5i2.fsf@assigned-by-dhcp.cox.net>
References: <7vwtmr4hm5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508120858420.3295@g5.osdl.org>
	<Pine.LNX.4.63.0508121818230.26488@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7vk6irumv3.fsf@assigned-by-dhcp.cox.net>
	<pan.2005.08.13.03.25.28.489523@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 11:10:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3s1h-0004zK-EX
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 11:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVHMJJ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 05:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVHMJJ7
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 05:09:59 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:57573 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932140AbVHMJJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 05:09:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050813090958.NEDR1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 Aug 2005 05:09:58 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matthias Urlichs <smurf@smurf.noris.de> writes:

>> I have been trying, admittably perhaps not very successfully, to
>> stay away from bashism in the core GIT scripts.
>
> We should probably use #!/bin/bash for scripts with bashisms...

As a fall-back position, yes, but I'd rather see trivial
bashisms eradicated when the rewrite does not make things too
complicated.
