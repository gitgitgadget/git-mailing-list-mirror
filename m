From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 04 Sep 2010 07:42:12 +0200
Message-ID: <4C81DC34.2090800@gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com> <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com> <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com> <4C7FC3DC.3060907@gmail.com> <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com> <alpine.LFD.2.00.1009021249510.19366@xanadu.home> <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com> <alpine.LFD.2.00.1009021624170.19366@xanadu.home> <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu> <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org> <alpine.LFD.2.00.1009031522590.19366@xanadu.home> <AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com> <AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com> <4C81A67B.2060400@gmail.com> <alpine.LFD.2.00
 .1009032304560.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 04 07:42:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrlWA-0005NE-Sw
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 07:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784Ab0IDFmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 01:42:18 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51965 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab0IDFmR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 01:42:17 -0400
Received: by eyb6 with SMTP id 6so1567469eyb.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 22:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=XjvKbO0zxH/AN23cibah4bV/kU4e32mhH97xxA1dLsg=;
        b=dTADGeV5zgm9VYBwU5jwrj+CzdoXFs4P/K7HHWi860YBCTifldROstqHtvufdIvicu
         l6rxKw7vt/sWUjIWlCsQoqLZvX0DRGqHTqp6CyR0uWyvU/wlJ0KjjVUw+sIbTLPNyKaR
         Mn3udMKPJImz4moEw1jByl45F5OvtkF6wlDQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=PDLtWLcqUzJ/D3M7WIgonb2NgERJG7mtBJftrlhL1uyXhYbMVy9u592pD1WnKcbW30
         cWK+EY50xOiWLRhtiQRmNcnkTED328xmCKFiv3CK3MiL6v16DEUW0Gb8tH6rXAI57B1l
         hmaFXJQqFsdoc355T6ve53VQgDtuVNk5w9xTw=
Received: by 10.213.27.68 with SMTP id h4mr423566ebc.98.1283578936309;
        Fri, 03 Sep 2010 22:42:16 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-126-51.multimo.pl [89.174.126.51])
        by mx.google.com with ESMTPS id a48sm4045816eei.7.2010.09.03.22.42.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 22:42:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <alpine.LFD.2.00.1009032304560.19366@xanadu.home>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155306>

>> 2) Git doesn't use chained deltas. IOW given commits "A --d1-> B --d2-> C",
>>    "C" can be represented as a delta against "A" or "B", but _not_ against "d1". 
>>    (Think of the case where "C" reverts /part of/ "B")
> 
> Git does use chained deltas indeed.  But deltas are used only at the 
> object level within a pack file.  Any blob object can be represented as 
> a delta against any other blob in the pack, regardless of the commit(s) 
> those blob objects belong to.  Same thing for tree objects.  So you can 
> have deltas going in total random directions if you look them from a 
> commit perspective.  So "C" can have some of its objects being deltas 
> against objects from "B", or "A", or any other commit for that matter, 
> or even objects belonging to the same commit "C". And some other objects 
> from "B" can delta against objects from "C" too. There is simply no 
> restrictions at all on the actual delta direction.  The only rule is 
> that an object may only delta against another object of the same type.
> 
> Of course we don't try to delta each object against all the other 
> available objects as that would be a O(n^2) operation (imagine with n = 
> 1.7 million objects).  So we use many heuristics to make this delta 
> packing efficient without taking an infinite amount of time.
> 
> For example, if we have objects X and Y that need to be packed together 
> and sent to a client over the net, and we find that Y is already a delta 
> against X in one pack that exists locally, then we simply and literally 
> copy the delta representation of Y from that local pack file and send it 
> out without recomputing that delta.

What i meant by 'chained deltas' is a representation that takes delta#1 and
applies delta#2 to the first delta, and applies the result to the source of
delta#1. Which could be a more compact representation of eg. a partial revert.

IOW, if I have commits A..Y, ask (via git pull) for commits X and Z, then I'm
guaranteed to receive them either raw, or as a delta vs commits A..X, right?
What I'm really asking is, if a (modified) git-upload-pack skips transferring
commit X, and just sends me commit Z (possibly as delta vs 'X'), _and_ I 
obtain commit 'X" in some other way, I will be able to reconstruct 'Z', correct?

TIA, 

artur
