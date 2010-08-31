From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Tue, 31 Aug 2010 17:47:42 +0100
Message-ID: <AANLkTikrQhzyPckN2t3+FzaJFzYboDRVfW3bPPZOGpJQ@mail.gmail.com>
References: <1283198367-11440-1-git-send-email-cdahlin@redhat.com>
	<AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com>
	<AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com>
	<20100831143839.GC16034@foucault.redhat.com>
	<AANLkTinF1o0RZSKYEL9Qc=uwXx6fBBXh6wRx2CTULBSE@mail.gmail.com>
	<20100831155159.GD16034@foucault.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Casey Dahlin <cdahlin@redhat.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 18:47:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqU00-0001ow-GW
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 18:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab0HaQrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 12:47:47 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:50413 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab0HaQrr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 12:47:47 -0400
Received: by pxi10 with SMTP id 10so2522409pxi.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=0twWnpoULRjpKGKLxvnaZUnD4azZGcAFNOIavpe8DaE=;
        b=N+KPA1/xW8kz2UxGpEL1m40TbVfgeCZs3hLqXRtPm47Ck1SiicqlOMfmatR8UH7eyy
         p0Dqg9LfGSIOQJ1HZnxj4UkLaNTcKmvmGS8mZ2GtrLNerMCHl678vRM4XEOB2I7xAP+m
         NDru/xhbA7W59CMTRdFIuynA5dmgW58F4ZOso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nnWilQkftspZjZAuOrDmUpmkZ/vd4TX4SUENR7hyOji8++c0bFgwugElJQ/i402J3j
         F/eDzbtsMqQfGRlEt+90OfDWU9cXVE+pEdMKU7m1bbEk1uP+1PzoGe+aCk7e0nwKOFAZ
         +1SIxe4vZzELdTKw3gxsXyn3rcVfu9t/dxo94=
Received: by 10.143.6.8 with SMTP id j8mr3729542wfi.20.1283273262734; Tue, 31
 Aug 2010 09:47:42 -0700 (PDT)
Received: by 10.220.98.14 with HTTP; Tue, 31 Aug 2010 09:47:42 -0700 (PDT)
In-Reply-To: <20100831155159.GD16034@foucault.redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154937>

On Tue, Aug 31, 2010 at 4:52 PM, Casey Dahlin <cdahlin@redhat.com> wrote:
> Bittorrent has the luxury of being able to proxy for the poor firewall-bound
> users since as long as there's one peer exposed to the internet you can have
> any two other peers connect to him and give him the data they want to exchange,
> to the benefit of all 3. Git won't work that way because not everyone in the
> swarm wants all chunks of data, so if you found a proxy node, you might have to
> make him carry data (possibly lots of data) that he has no personal interest
> in.

 ah, no you don't.

 but - think about it: even if they don't, if they don't want the set
of commits that get you up to a particular HEAD or other tag or
branch, what the hell are they doing?? :)  from what i can gather, git
simply doesn't operate in a way where you can "pick and choose" which
commits you are and are not going to keep around, in order to
reconstruct the repository.

 i hope that's right, because i'm counting on it.  i.e i'm counting on
the following being true:

 "all copies of all git repositories have exactly the same objects
such that git pack-object on the exact same ref and the exact same
object ref will return exactly the same information".

 if anyone knows a reason why that is NOT the case, please could you tell me!

l.
