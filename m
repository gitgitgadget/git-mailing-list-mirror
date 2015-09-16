From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Feature Request] git blame showing only revisions from git rev-list --first-parent
Date: Tue, 15 Sep 2015 18:14:26 -0700
Message-ID: <xmqqwpvrtbbh.fsf@gitster.mtv.corp.google.com>
References: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com>
	<20150911140133.GA14311@sigill.intra.peff.net>
	<xmqqa8ss29tq.fsf@gitster.mtv.corp.google.com>
	<xmqqsi6kzsgc.fsf@gitster.mtv.corp.google.com>
	<20150912033054.GA30431@sigill.intra.peff.net>
	<xmqqy4gcxcp4.fsf@gitster.mtv.corp.google.com>
	<20150913100728.GA26562@sigill.intra.peff.net>
	<CAPc5daUcwCferagupF+iy3gxxorfMyEMn0oFMRWBNjc0=2r4og@mail.gmail.com>
	<20150915100538.GA21831@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stephen Connolly <stephen.alan.connolly@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 03:14:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc1J7-0001Cn-PF
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 03:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbbIPBOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 21:14:40 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33913 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbbIPBO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 21:14:28 -0400
Received: by padhy16 with SMTP id hy16so191971950pad.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 18:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lkU5BpXC62YvLcV02LhoDK0en267J0jEaGGzmEAqNRs=;
        b=M/kM+wvSb18wQ2VAJ96oEk90Jx7w2Hug733Tg+hVW94nMaNSP2NQJhaEoPbDIG01Q8
         XJ+7+VvnEfHL8JrVW8NWTr3D/koWx3X0V6KhqYNFi1j5bUintqKk9ZzZa9o/NYfqh+0m
         q/3ZIP3YJ3BDY+zrIWByxe4i4KJTfSHSeYQkEmJKJZnCs3yb5xBlOFQKZ2Oq6rr/X0rz
         AGdv6P0E0yRbEp3ixdYajGCHPZtSAEmSx/6OOC6AzdQDDMRzEb5oQO+e30AQgxofbUl2
         vByZCTnpEWPmRieKeXsryGlp0Jl3l2kKtA6TWZWeEtUgzP9rYryxhwpWxnSYtaVnJjq9
         z/KQ==
X-Received: by 10.66.157.72 with SMTP id wk8mr52965633pab.132.1442366068285;
        Tue, 15 Sep 2015 18:14:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id x6sm24350090pbt.3.2015.09.15.18.14.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Sep 2015 18:14:27 -0700 (PDT)
In-Reply-To: <20150915100538.GA21831@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 15 Sep 2015 06:05:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277990>

Jeff King <peff@peff.net> writes:

> It seems like nobody is actually that interested in what "blame
> --first-parent --reverse" does in the first place, though, and there's
> no reason for its complexity to hold up vanilla --first-parent. So what
> do you think of:

I like the part that explicitly disables the combination of the two
;-)
