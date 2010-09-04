From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 04 Sep 2010 15:42:05 +0200
Message-ID: <4C824CAD.9070509@gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com> <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com> <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com> <4C7FC3DC.3060907@gmail.com> <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com> <alpine.LFD.2.00.1009021249510.19366@xanadu.home> <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com> <alpine.LFD.2.00.1009021624170.19366@xanadu.home> <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu> <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org> <alpine.LFD.2.00.1009031522590.19366@xanadu.home> <AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com> <AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com> <4C81A67B.2060400@gmail.com> <alpine.LFD.2.00
 .1009032304560.19366@xanadu.home> <4C81DC34.2090800@gmail.com> <alpine.LFD.2.00.1009040153280.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 04 15:49:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ort7K-0001z7-CK
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 15:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247Ab0IDNtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 09:49:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35366 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab0IDNtH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 09:49:07 -0400
Received: by fxm13 with SMTP id 13so1793590fxm.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 06:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=7ZiO/1QnQOJeA+R5yjJXVuYtCbgQtdidrYHUw9giMoU=;
        b=oYWVvqhutfTOrHH0vyE9fA3e9/TlH2gHRj/BcxLQVZ0n7RgEsf3FpaXe5bAEJlnmj6
         EU4IIoW/6z2TWzFgOkTdomtEfc7CZL2EGDis9zixb9i4huNd8EGZEJ/wfUw3UlNPA4KE
         DmPULZ8yslH94mE8W3WsyQITBpaHO9ATIm5Io=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=H9DwVkC3rjMUSe0M1RBImfRkZWOMTXGUQZkcXUVZCoPFRRI+7EP1usbKRNrZtx2BTV
         1eHl8SQd785wv5MSBG1iKFp3zicc+Va7ykWBIanxmzxO11RJSGWkdgeE7FwBqSzLPmAX
         tbhxg6Ti2mKPOTdiJJi1vlk+i0ZjrS/ie5DG0=
Received: by 10.223.105.129 with SMTP id t1mr736fao.59.1283607728791;
        Sat, 04 Sep 2010 06:42:08 -0700 (PDT)
Received: from [172.19.43.221] (ip-94-42-2-120.multimo.pl [94.42.2.120])
        by mx.google.com with ESMTPS id u8sm1438783fah.36.2010.09.04.06.42.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 06:42:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <alpine.LFD.2.00.1009040153280.19366@xanadu.home>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155325>

On 09/04/10 08:13, Nicolas Pitre wrote:
> On Sat, 4 Sep 2010, Artur Skawina wrote:
>> What I'm really asking is, if a (modified) git-upload-pack skips transferring
>> commit X, and just sends me commit Z (possibly as delta vs 'X'), _and_ I 
>> obtain commit 'X" in some other way, I will be able to reconstruct 'Z', correct?
> 
> Yes.  Although it is 'git pack-objects' that decides what objects to 
> send, not 'git-upload-pack'.

Thank you very much for the detailed answers.

AFAIU both previously mentioned assumptions hold, so here's an example of
git-p2p-v3 use, simplified and with most boring stuff (p2p,ref and error
handling omitted.
(the first version made a canonical, shared, virtual representation of the
object store, the second added more git-awareness to the transport, and then
I started wondering if all of that is actually necessary; hence...).

Let's say I'm a git repo tracking Linus' tree, right now the newest commit that
i have is "v2.6.33" (but it could be anything, including "" for a fresh, empty
clone) and I want to become up to date.

1) I fetch a list of IPs of well known seeds, eg from kernel.org.

2) I send an UDP packet to some of them, containing the repo 
   ("git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git"),
   the ref that I'm interested in ("master") and the hash of the last commit
   that I have ("60b341b7").
   This is enough to start participating in the cloud by serving ".."60b341b7",
   but we'll skip the server part in this example.

3) I receive answers to some of the above queries, containing the status of
   these peers wrt to the given repo and ref, ie the same data I sent above.
   Plus a list of random other live peers known to be tracking this ref, which
   I'll use to repeat step #2 and #3 until I have a list of enough peers to
   continue.

4) Now i know of 47 peers that already have the tag or commit "v2.6.37" (either
   I already knew that I wanted this one, or determined it during #3 and/or #1;
   ref handling omitted from this example for brevity).

   So i connect to one of the peers, and basically ask for the equivalent of
   "git fetch peer01 v2.6.37". 
   But that would pull all new objects from that one peer, and that isn't what
   i want. So i need to make it not only send me a thin pack, but also to omit
   some of the objects. As at this point i don't actually know anything about
   the objects in between "v2.6.33" and "v2.6.37" I can not split the request
   into smaller ones.

   So I'll cheat -- I'll take the number of available peers ("47") and the
   number of this peer ("0"), send these two integers over and ask the other
   side to skip transferring me any object whose 
   (HASH%available_peers)!=this_peer .

5) for (int this_peer=1; this_peer<available_peers; this_peer++)
     Repeat#4(this_peer);
   /* in parallel until i saturate the link */

6) Now i have 47 different packs, which probably do not make any sense
   individually, because they contain deltas vs nonexisting objects, but
   as a whole can be used to reconstruct the full tree.
   6a) Except of course if there are circular dependencies, which can
       occur eg. if peer#1 decided to encode object A as delta(B) and 
       peer#2 did B=delta(A), but this will be rare, and I'll just need
       to refetch either A or B to break the cycle, this time with real
       I-HAVES, hence this is guaranteed to succeed.

What am I missing?

artur
