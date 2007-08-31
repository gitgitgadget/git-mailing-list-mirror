From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] fix parallel make problem
Date: Fri, 31 Aug 2007 19:00:43 +0300
Message-ID: <20070831160043.GA1973@mellanox.co.il>
References: <20070830063810.GD16312@mellanox.co.il>
	<7v7inda5ar.fsf@gitster.siamese.dyndns.org>
	<20070830072748.GF16312@mellanox.co.il>
	<7vmyw85uml.fsf@gitster.siamese.dyndns.org>
	<20070831080651.GA17637@mellanox.co.il>
	<7vabs82kcq.fsf@gitster.siamese.dyndns.org>
	<20070831081517.GB17637@mellanox.co.il>
	<7v4pig2j91.fsf@gitster.siamese.dyndns.org>
	<20070831152120.GC17637@mellanox.co.il>
	<7vr6lj1zg3.fsf@gitster.siamese.dyndns.org>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 18:01:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR8vd-0003rd-Ba
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 18:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbXHaQAx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 12:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbXHaQAw
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 12:00:52 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:35062 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbXHaQAw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 12:00:52 -0400
Received: by an-out-0708.google.com with SMTP id d31so169690and
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 09:00:51 -0700 (PDT)
Received: by 10.100.168.13 with SMTP id q13mr1748099ane.1188576050937;
        Fri, 31 Aug 2007 09:00:50 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.35.163])
        by mx.google.com with ESMTPS id b39sm3659046ugf.2007.08.31.09.00.48
        (version=SSLv3 cipher=OTHER);
        Fri, 31 Aug 2007 09:00:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vr6lj1zg3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57176>

> Quoting Junio C Hamano <gitster@pobox.com>:
> Subject: Re: [PATCH] fix parallel make problem
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> >> > So how did this end up in your mail?
> >> 
> >> Because it is not a format-patch output.
> >> 
> >> I often run "git diff --stat -p HEAD" from inside MUA in order
> >> to get the patch from my work tree, write a proposed commit
> >> message, and then reset the change away without committing after
> >> sending that message (yes I do not need "git stash" --- gmane
> >> and vger are my stashes, Mwhhhaaaa).
> >
> > So maybe we can suppress the warning when the output is not a tty?
> 
> What's your point?

Well, git diff currently says "consider running git-status", and one
wanders why doesn't it just go ahead and run git status instead
of asking the user to do it.



-- 
MST
