From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 04 Sep 2010 03:52:59 +0200
Message-ID: <4C81A67B.2060400@gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>	<4C7FC3DC.3060907@gmail.com>	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>	<alpine.LFD.2.00.1009021249510.19366@xanadu.home>	<AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>	<alpine.LFD.2.00.1009021624170.19366@xanadu.home>	<B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>	<7voccezr7m.fsf@alter.siamese.dyndns.org>	<20100903183120.GA4887@thunk.org>	<alpine.LFD.2.00.1009031522590.19366@xanadu.home>	<AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com> <AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>, Ted Ts'o <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 03:53:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrhwQ-0001HO-8N
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 03:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab0IDBxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 21:53:06 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48050 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab0IDBxE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 21:53:04 -0400
Received: by eyb6 with SMTP id 6so1538580eyb.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 18:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=IndUoLnesT13Vf6CILmorB41g4BRQOBt5DdgYOZO1FM=;
        b=rVau8TltdWcU+x+EyTZfbLdFKh8lbGtd8Z6/MVt0GNdjN+TehY669ls5MGADTZWcpB
         dT35QxBlFescApN8bQZnu1YZS/K0OIaBHyCE6bBukVQK/FVYN/ugHi4A4nI1zDqKlPR1
         X2zlqVLOfUS6u4OJ5wmVe5ajcQO2uJxIo5RcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=nUnaRCrLiKyOHLEt0mMN8etNJiNB9VZRct8F/VljGNK+YGR77CqPWyJkkdoQNw6MT3
         0zvrpKMGIiOfKYtPSRe1XERfAIbMHEYGApsm8T7UGQwM7Yo4y2uqCj/MKLw8ShZHfaHY
         ErCQv8VdwEW6ZpjGsf2b/UaH/0R9rsyK8aI3U=
Received: by 10.213.36.16 with SMTP id r16mr303081ebd.37.1283565182624;
        Fri, 03 Sep 2010 18:53:02 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-40-7.multimo.pl [89.174.40.7])
        by mx.google.com with ESMTPS id u9sm3792802eeh.5.2010.09.03.18.53.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 18:53:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155297>

Hmm, taking a few steps back, what is the expected usage of git-p2p?
Note it's a bit of a trick question; what i'm really asking is what _else_,
other than pulling/tracking Linus' kernel tree will/can be done with it?

Because once you accept that all peers are equal, but some peers are more
equal than others, deriving a canonical representation of the object store
becomes relatively simple. Then, it's just a question of fetching the missing
bits, whether using a dumb (rsync-like) transport, or a git-aware protocol.
(I've no idea why you'd want to base a transfer protocol on the unstable packs,
building it on top of objects seems to be the only sane choice)

I'm mostly git-ignorant and i'm assuming the following two things -- if someone
more familiar w/ git internals could confirm/deny, that would be great:

1) "git pull git:..." would (or could be made to) work w/ a client that asks for
   "A..E", but also tells the server to omit "B,C and D" from the wire traffic.    

2) Git doesn't use chained deltas. IOW given commits "A --d1-> B --d2-> C",
   "C" can be represented as a delta against "A" or "B", but _not_ against "d1". 
   (Think of the case where "C" reverts /part of/ "B")


Then there are security implications... Which pretty much mandate having "special"
peers anyway, at least for transferring heads (branches/tags etc). Which means
the second paragraph above applies. And as the "special peer" in practice can be
just a signed tag/commit, like "v2.6.35", it's not such a big limitation like it
may seem at first...

artur
