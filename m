From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Refactor sha1_pack_index_name and sha1_pack_name to use a common backend
Date: Mon, 28 Aug 2006 15:34:44 +0200
Message-ID: <20060828133444.GA32266@diku.dk>
References: <20060828001610.GC20904@diku.dk> <7vlkp9tquz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 15:35:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHhGT-0006eS-0v
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 15:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWH1Ney (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 09:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWH1Ney
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 09:34:54 -0400
Received: from [130.225.96.91] ([130.225.96.91]:49841 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750809AbWH1Nex (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 09:34:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 8D153770026;
	Mon, 28 Aug 2006 15:34:45 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19927-10; Mon, 28 Aug 2006 15:34:44 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 5B7AA770005;
	Mon, 28 Aug 2006 15:34:44 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id C62296DF88D; Mon, 28 Aug 2006 15:33:21 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 3E1AE62A01; Mon, 28 Aug 2006 15:34:44 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkp9tquz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26156>

Junio C Hamano <junkio@cox.net> wrote Sun, Aug 27, 2006:
> Jonas Fonseca <fonseca@diku.dk> writes:
> 
> > This adds another pair of static buffers, if that's a problem and the
> > cleanup is still wanted I can change it to use malloc.
> 
> As a clean-up, I'd rather see a patch that removes the need for
> these two functions and one struct member, rather than keeping
> these two misguided functions and consolidating their
> implementations.

Thanks for the outline, I will look into removing this limitation.

-- 
Jonas Fonseca
