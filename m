From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tracking files across tree reorganizations
Date: Wed, 14 Dec 2005 16:36:49 -0800
Message-ID: <7vd5jzurfi.fsf@assigned-by-dhcp.cox.net>
References: <43A08B8F.1000901@zytor.com> <20051214223656.GJ22159@pasky.or.cz>
	<Pine.LNX.4.64.0512141538440.3292@g5.osdl.org>
	<43A0AE6B.3040309@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 01:39:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emh7n-0003JT-VC
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 01:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbVLOAhE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 19:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVLOAhB
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 19:37:01 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:10216 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030258AbVLOAgv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 19:36:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215003558.MMKZ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Dec 2005 19:35:58 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13665>

"H. Peter Anvin" <hpa@zytor.com> writes:

> HOWEVER, I maintain that this is unnecessary (and, as Linus has pointed 
> out several time, losing) -- we already detect renames without relying 
> on commit-time metadata.  If it's too expensive to generate the metadata 
> on every merge, it can be cached.

I agree; I was wondering why you brought it up again.
