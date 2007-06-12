From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH 1/3] refactor dir_add_name
Date: Tue, 12 Jun 2007 23:51:04 +0200
Message-ID: <20070612215104.GB21858@diku.dk>
References: <20070611123045.GA28814@coredump.intra.peff.net> <20070611133944.GA7008@coredump.intra.peff.net> <7vk5uaqx3q.fsf@assigned-by-dhcp.pobox.com> <20070611194651.GA15309@coredump.intra.peff.net> <7v7iq9lk76.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 23:51:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyEGe-00070h-Lm
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 23:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbXFLVvJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 17:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbXFLVvI
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 17:51:08 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:50490 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990AbXFLVvH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 17:51:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 8B08CF0173;
	Tue, 12 Jun 2007 23:51:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YV2O1SIz+otF; Tue, 12 Jun 2007 23:51:05 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 22E56F0174;
	Tue, 12 Jun 2007 23:51:05 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 81E976DF845; Tue, 12 Jun 2007 23:48:43 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id F3FB762A5D; Tue, 12 Jun 2007 23:51:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7iq9lk76.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50004>

Junio C Hamano <gitster@pobox.com> wrote Tue, Jun 12, 2007:
> Anyway, it appears that Jonas picked up your patch to polish up,
> so I won't touch this series until that resurfaces.

My idea was to put the nr, alloc, and entries members into a separate
struct dir_entry_list, which should allow the dir_add_* functions to be
"united" and thus somewhat remove the need for alloc_grow. However,
after spending some time on it, changing dir.nr to dir.entry_list.nr
etc. reduced readability so much that I ended up trying to make other
cleanups and the simplicity of the series was lost.

Anyway, I don't think I can come up with a more polished version without
adding a few cleanup patches along the way. So I think apart from the
amended version of 3/3 I will take back my intension to polish it up.

-- 
Jonas Fonseca
