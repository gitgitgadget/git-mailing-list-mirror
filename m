From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [BUG RFC/PATCH] git-cvsimport
Date: Sat, 14 Aug 2010 21:39:00 +0000
Message-ID: <AANLkTimxaVZC7j7Dwz-vLSPU2Na=b9zEC+8HsS7wF6Sc@mail.gmail.com>
References: <AANLkTikxxqgNpmqfFQq+5GVd7VAW2DTaro5anRHcx6Tt@mail.gmail.com>
	<20100814210928.GC2372@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 23:39:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkORY-0007d0-Mo
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 23:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346Ab0HNVjD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 17:39:03 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57083 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756272Ab0HNVjB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 17:39:01 -0400
Received: by gxk23 with SMTP id 23so1508779gxk.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 14:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PsQ8Hl3aKaYY3S6y38E5Qfhfr9RTww6bHAgjy/fQSlw=;
        b=MuOl0ox4hLrYe/S1r+I81dpQybXTPb268OfKRnv0eJ9wWH0IrDn+ONcGL0J0lm1NsA
         NtdHlb32vKlnbksjNB1X5bo1wLh5L2Xcmf6KURN48D2VkMQZ5KjuCAQS252FHJjsqo7D
         H69AwivVaqIyi98tyfoRI5xkeF4WoaFW2d6N0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TXjTIac5FMvgU2pRmHua1eM57OFAbce+fQBXLFtIt7PYp4oEpmFCznaMs6IBWm70ah
         QOYQVHiizme93vScRKEgvNaqRHldsG8JKDHBkq5ucI63aPRyJHaW1wdUEzi+FONZHU4w
         TiNmvMK0JKqEWVUpzt+JtM+KcSkyLTI6/8mqI=
Received: by 10.231.12.75 with SMTP id w11mr3454323ibw.134.1281821940925; Sat,
 14 Aug 2010 14:39:00 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 14 Aug 2010 14:39:00 -0700 (PDT)
In-Reply-To: <20100814210928.GC2372@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153583>

On Sat, Aug 14, 2010 at 21:09, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> cvsps will just hang due to the unfriendly chmod.
>
> Could this be fixed in cvsps[1]?

Maybe, but that's a hairy beast I'm not going to tackle :)

The main intent was actually just to get this into the collective
memory of the list archive, this sort of thing probably never happens
in the wild, and the added alarm/die complexity of dealing with it
probably isn't worth the effort.

I'm going to fix up the test though, once Junio merges my other
patches, which would conflict with this.
