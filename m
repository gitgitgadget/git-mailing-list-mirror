From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] Re: Teach mailinfo to ignore everything before -- >8
	-- mark
Date: Mon, 24 Aug 2009 10:02:23 -0400
Message-ID: <20090824140223.GA22198@redhat.com>
References: <7v1vn2yklo.fsf@alter.siamese.dyndns.org> <20090824060708.6117@nanako3.lavabit.com> <alpine.DEB.2.00.0908231705200.29625@GWPortableVCS> <7v7hwurwmu.fsf@alter.siamese.dyndns.org> <20090824041608.GC3526@vidovic> <7vk50tq0g5.fsf@alter.siamese.dyndns.org> <7vmy5pojsg.fsf@alter.siamese.dyndns.org> <20090824062141.GD3526@vidovic> <7v7hwtofys.fsf@alter.siamese.dyndns.org> <20090824073147.GG3526@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thell Fowler <git@tbfowler.name>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Mon Aug 24 15:44:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfZqE-0001Kq-FU
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 15:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbZHXNoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 09:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbZHXNoA
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 09:44:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13622 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521AbZHXNoA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 09:44:00 -0400
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n7ODhcKN021506;
	Mon, 24 Aug 2009 09:43:38 -0400
Received: from redhat.com (dhcp-100-18-242.bos.redhat.com [10.16.18.242])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id n7ODhaJQ020800;
	Mon, 24 Aug 2009 09:43:36 -0400
Content-Disposition: inline
In-Reply-To: <20090824073147.GG3526@vidovic>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126923>

On Mon, Aug 24, 2009 at 09:31:47AM +0200, Nicolas Sebrecht wrote:
> ( cc'ing Don Zickus )
> 
> The 23/08/09, Junio C Hamano wrote:
> > Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
> > 
> > >> Does anybody remember what these s_hdr (vs p_hdr) buffers stand for, by
> > >> the way?

>From what I remember, I used p_hdr to designate primary headers, ie the
original mail headers.  s_hdr was supposed to represent the secondary
headers, ie the embedded mail headers in the body of the email that could
override the original primary mail headers.

I hope that clears things up.  Let me know if you have more questions and
I will try my best to remember what I did. :-)

Cheers,
Don

> > >
> > > Has been added by 87ab799234639c .
> > 
> > That much I know ;-), thanks anyway.
> > 
> > The commit does not _explain_ what they are for, what they mean, and what
> > these mysteriously named variables do.
> 
> -- 
> Nicolas Sebrecht
