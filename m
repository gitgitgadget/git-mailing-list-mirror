From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] fix parallel make problem
Date: Fri, 31 Aug 2007 18:21:20 +0300
Message-ID: <20070831152120.GC17637@mellanox.co.il>
References: <20070830063810.GD16312@mellanox.co.il>
	<7v7inda5ar.fsf@gitster.siamese.dyndns.org>
	<20070830072748.GF16312@mellanox.co.il>
	<7vmyw85uml.fsf@gitster.siamese.dyndns.org>
	<20070831080651.GA17637@mellanox.co.il>
	<7vabs82kcq.fsf@gitster.siamese.dyndns.org>
	<20070831081517.GB17637@mellanox.co.il>
	<7v4pig2j91.fsf@gitster.siamese.dyndns.org>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 17:21:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR8JU-0007Og-HF
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 17:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbXHaPVa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 11:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbXHaPVa
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 11:21:30 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:63604 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379AbXHaPV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 11:21:29 -0400
Received: by an-out-0708.google.com with SMTP id d31so167625and
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 08:21:28 -0700 (PDT)
Received: by 10.100.196.3 with SMTP id t3mr1694570anf.1188573688218;
        Fri, 31 Aug 2007 08:21:28 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.35.163])
        by mx.google.com with ESMTPS id e33sm1345077ugd.2007.08.31.08.21.25
        (version=SSLv3 cipher=OTHER);
        Fri, 31 Aug 2007 08:21:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4pig2j91.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57172>

> > So how did this end up in your mail?
> 
> Because it is not a format-patch output.
> 
> I often run "git diff --stat -p HEAD" from inside MUA in order
> to get the patch from my work tree, write a proposed commit
> message, and then reset the change away without committing after
> sending that message (yes I do not need "git stash" --- gmane
> and vger are my stashes, Mwhhhaaaa).

So maybe we can suppress the warning when the output is not a tty?


-- 
MST
