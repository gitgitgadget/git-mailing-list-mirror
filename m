From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 16:03:08 -0700 (PDT)
Message-ID: <m3prnsrbdp.fsf@localhost.localdomain>
References: <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	<7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
	<20080827001705.GG23698@parisc-linux.org>
	<7v63pmkozh.fsf@gitster.siamese.dyndns.org>
	<1219907659.7107.230.camel@pmac.infradead.org>
	<7vtzd5fta0.fsf@gitster.siamese.dyndns.org>
	<1219912327.7107.245.camel@pmac.infradead.org>
	<94a0d4530808280157p230d289dlf0c85cd517541801@mail.gmail.com>
	<20080828115408.GA30834@hera.kernel.org>
	<94a0d4530808280615i2befb89cm7d6153bfceb11b19@mail.gmail.com>
	<94a0d4530808280634k1c23fe10q8934875c83d4a2f5@mail.gmail.com>
	<alpine.LFD.1.10.0808280936300.3300@nehalem.linux-foundation.org>
	<B0BAA28F-C029-411B-BE86-3A63951CE213@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Al Viro <viro@hera.kernel.org>,
	Matthew Wilcox <matthew@wil.cx>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:04:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYqXJ-0004nQ-1s
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056AbYH1XDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753920AbYH1XDN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:03:13 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:62995 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbYH1XDL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:03:11 -0400
Received: by ey-out-2122.google.com with SMTP id 6so185118eyi.37
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 16:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=N8psNbNCR0bG52reIltpnmU4KUZQzR0zCoCQz36BBuM=;
        b=jsZ6Bf4qwLZueJX1EVLUo/7hDTzLUhGjpq8WaSvjVt6zoGQc63tS9zwbpI6926E/h3
         /JpEXkcUW9Hd+KK+n/Stv5/O8Xt+i0rDpKfUQCTlc08JpYDsepw9tyJTZTyuyQ+dKxCz
         H4ypksiRLHhemufieMxQiQu7eixQrzHfB/HaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=VlWili7MG+eSnppAMf/Hr2k8BSaFd0xw78ABmRHMujsWQzd130ignzZoWa4A03LKLg
         3IJItYWNnPlVCMOVr+sgXq8subnkCkB1NH+pzbwiNfMco30OwpJj3k/Yc//9WDAqlmHh
         5j0ZvcpBeeiofWSU/C3cFzX4M3/el0prlO+/k=
Received: by 10.210.105.20 with SMTP id d20mr634448ebc.18.1219964589935;
        Thu, 28 Aug 2008 16:03:09 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.255.225])
        by mx.google.com with ESMTPS id f13sm5347465gvd.10.2008.08.28.16.03.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Aug 2008 16:03:08 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7SN36EQ023962;
	Fri, 29 Aug 2008 01:03:06 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7SN2xgm023959;
	Fri, 29 Aug 2008 01:02:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <B0BAA28F-C029-411B-BE86-3A63951CE213@cs.indiana.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94198>

Perry Wagle <wagle@cs.indiana.edu> writes:

> On Aug 28, 2008, at 9:37 AM, Linus Torvalds wrote: 
>> On Thu, 28 Aug 2008, Felipe Contreras wrote:
>>>
>>> If the git-foo was supposed to be deprecated in 1.6.0
>>
>> Itw as deprecated over a _year_ ago.
> 
> No, it wasn't.  As of March 2008, git<DASH> was still in the sample
> hooks and in git-web. [...]

If by "git-web" you mean "gitweb", the git web interface in Perl, this
is simply not true.  From the commit 25691fb (gitweb: Use --git-dir
parameter instead of setting $ENV{'GIT_DIR'}) _at least_ gitweb uses
"git <comd>" and not "git-cmd" form.  And this commit was on 28 August
2006, so in March 2008 gitweb didn't use git<DASH> form...

Check your facts, please...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
