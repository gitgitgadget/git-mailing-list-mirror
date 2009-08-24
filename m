From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 --
	mark
Date: Mon, 24 Aug 2009 09:31:47 +0200
Message-ID: <20090824073147.GG3526@vidovic>
References: <20090823171819.6117@nanako3.lavabit.com> <7v1vn2yklo.fsf@alter.siamese.dyndns.org> <20090824060708.6117@nanako3.lavabit.com> <alpine.DEB.2.00.0908231705200.29625@GWPortableVCS> <7v7hwurwmu.fsf@alter.siamese.dyndns.org> <20090824041608.GC3526@vidovic> <7vk50tq0g5.fsf@alter.siamese.dyndns.org> <7vmy5pojsg.fsf@alter.siamese.dyndns.org> <20090824062141.GD3526@vidovic> <7v7hwtofys.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thell Fowler <git@tbfowler.name>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, Don Zickus <dzickus@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 09:32:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfU27-0003mC-LA
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 09:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbZHXHbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 03:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbZHXHbu
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 03:31:50 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:35651 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbZHXHbt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 03:31:49 -0400
Received: by ewy3 with SMTP id 3so2117568ewy.18
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 00:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=88YSTYuhsx+CQw19URnot5QsZCwTQKitIemcpY91XnU=;
        b=I0ydp5u8JZp5mOIYjYKSOT2xlGj0I4dT1QnkaAGbWjNwQIYf/OVEAOl/KZ2h5xkGt2
         5FddREwS0wYbi3j0xv1hW0DfmqGvCFByB4pBmFXu17PUKWPTQ4kB6vwGG/z74aAi4VY4
         SF7c+mGxf4d+cyLhD1Sq4dX509VJhUHPu3/u8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rsVUqRfWnL+/vUW0lIPre0CCIp+P6VBaYoz1Ld99Bu+y4Cy4xhOVshxjJNL1SGZFQt
         HCut/Wu24c0Ur86S4GN7xP1aEkv4iOaEkiiGT3s1DcRvB3JorX1xIJPhCQ2mdXqil08d
         nVj7V8eVDjyqtkYqrfO7js+TaG607F10WpeYg=
Received: by 10.211.195.3 with SMTP id x3mr4793169ebp.14.1251099110837;
        Mon, 24 Aug 2009 00:31:50 -0700 (PDT)
Received: from @ (88-121-114-119.rev.libertysurf.net [88.121.114.119])
        by mx.google.com with ESMTPS id 7sm4192352eyg.20.2009.08.24.00.31.49
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 00:31:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v7hwtofys.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126915>

( cc'ing Don Zickus )

The 23/08/09, Junio C Hamano wrote:
> Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
> 
> >> Does anybody remember what these s_hdr (vs p_hdr) buffers stand for, by
> >> the way?
> >
> > Has been added by 87ab799234639c .
> 
> That much I know ;-), thanks anyway.
> 
> The commit does not _explain_ what they are for, what they mean, and what
> these mysteriously named variables do.

-- 
Nicolas Sebrecht
