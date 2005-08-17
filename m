From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach applymbox to keep the Subject: line.
Date: Wed, 17 Aug 2005 12:26:38 -0700
Message-ID: <7vek8swej5.fsf@assigned-by-dhcp.cox.net>
References: <20050816214707.6842.qmail@web26302.mail.ukl.yahoo.com>
	<7vek8t7bva.fsf@assigned-by-dhcp.cox.net>
	<7vk6il2jz8.fsf_-_@assigned-by-dhcp.cox.net>
	<430375B3.3050307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 21:28:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5TYw-000355-8n
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 21:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVHQT0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 15:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVHQT0l
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 15:26:41 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:63416 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751218AbVHQT0k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 15:26:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817192639.ELVM25443.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 15:26:39 -0400
To: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> 1) Fix applymbox such that it understands RFC822-valid Subject lines 
> which wrap across multiple text lines.

I thought I did this in mailinfo (read_one_header() function)
some time ago.  I'd appreciate it if you could point me at a
sample message that fails to get processed correctly.

> 2) Teach it to understand MIME, and not treat the MIME headers like part 
> of the message.

I share the same gripe; I always end up running applymbox -q and
hand-fixing things for this reason.
